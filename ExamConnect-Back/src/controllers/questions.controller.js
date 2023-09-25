const asyncHandler = require("express-async-handler");
const connection = require("../DataBaseConf/MySqlConnection");



exports.getAllQuestions = asyncHandler(async (req,res,next) => {
     // select all the questions from the database with all there options


     const query = `
                   SELECT
                       q.id,
                       q.question_text,
                       q.isQcm,
                       q.createdAt,
                       o.id AS option_id,
                       o.question_text AS option_text,
                       o.isTrue
                   FROM question q
                   LEFT JOIN questionOption o ON q.id = o.question_id
                   UNION  /* MariaDB doesn't support FULL OUTER JOIN so we have to do it manually by doing a union LEFT JOIN and a RIGHT JOIN */
                   SELECT
                       q.id,
                       q.question_text,
                       q.isQcm,
                       q.createdAt,
                       o.id AS option_id,
                       o.question_text AS option_text,
                       o.isTrue
                   FROM question q
                   RIGHT JOIN questionOption o ON q.id = o.question_id

           `;

     await connection.query(query, (err, results) => {
       if (err) {
         console.error("Erreur lors de la récupération des questions:", err);
         res
           .status(500)
           .json({ message: "Erreur lors de la récupération des questions" });
       } else {
         const questions = [];
         results.forEach((row) => {
           const existingQuestion = questions.find(
             (question) => question.id === row.id
           );
           if (!existingQuestion) {
             if (row.isQcm) {
               questions.push({
                 id: row.id,
                 question_text: row.question_text,
                 isQcm: row.isQcm,
                 createdAt: row.createdAt,
                 options: [
                   {
                     id: row.option_id,
                     question_text: row.option_text,
                     isTrue: row.isTrue,
                   },
                 ],
               });
             } else {
               questions.push({
                 id: row.id,
                 question_text: row.question_text,
                 isQcm: row.isQcm,
                 createdAt: row.createdAt,
                 options: [],
               });
             }
           } else {
             existingQuestion.options.push({
               id: row.option_id,
               question_text: row.option_text,
               isTrue: row.isTrue,
             });
           }
         });
         // sort the questions by isQcm  isQcm = 1 first then isQcm = 0 then isQcm = 2 ordred by createdAt
         const qcmQsts = questions.filter((question) => question.isQcm === 1);
         const textQsts = questions.filter((question) => question.isQcm === 0);
         const imgQsts = questions.filter((question) => question.isQcm === 2);

         // sort by createdAt the recent questions first
         qcmQsts.sort((a, b) => b.createdAt - a.createdAt);
         textQsts.sort((a, b) => b.createdAt - a.createdAt);
         imgQsts.sort((a, b) => b.createdAt - a.createdAt);

         const sortedQuestions = qcmQsts.concat(textQsts, imgQsts);

         res.status(200).json(sortedQuestions);
       }
     });
   });



exports.getAllIdsAndTypes = asyncHandler(async (req, res,next) => {
     const query = "SELECT id, isQcm FROM question";
     // english
     await connection.query(query, (err, results) => {
       if (err) {
         console.error("Error while fetching questions:", err);
         res.status(500).json({ message: "Error while fetching questions" });
       } else {
         res.status(200).json(results);
       }
     });
   });


exports.createQuestion = asyncHandler(async  (req, res,next) => {
     const question = req.body;
     const isQcm = question.isQcm;
     const options = question.qstOptions;
     console.log(question);

     // inserting the wuestion first
     const query = "INSERT INTO question (question_text, isQcm) VALUES (?, ?)";
     await connection.query(query, [question.qstText, question.isQcm], (err, result) => {
       if (err) {
         console.error("Erreur lors de l'insertion d'une question:", err);
         res
           .status(500)
           .json({ message: "Erreur lors de l'insertion d'une question" });
       } else {
          // inserting the question options
         if (!isQcm || (isQcm && isQcm === 2)) {
           res.status(200).json(result);
         } else if (isQcm && isQcm === 1) {
           const query =
             "INSERT INTO questionOption (question_id, question_text, isTrue) VALUES ?";
           const question_id = result.insertId;

           const values = options.map((option) => [
             question_id,
             option.qstText,
             option.isTrue,
           ]);



           connection.query(query, [values], (err, result) => {
             if (err) {
               console.error(
                 "Erreur lors de l'insertion des options d'une question:",
                 err
               );
               res.status(500).json({
                 message: "Error while inserting question options",
               });
             } else {
               res.status(200).json({ message: "Question added successfuly !" });
             }
           });
         }
       }
     });
   });



exports.uploadOptionAsImage = asyncHandler(async  (req, res,next) => {
     // inserting the image question options
     const question_id = req.body.qstId;
     const isTrue = req.body.isTrue == "true" ? 1 : 0;

     const query =
       "INSERT INTO questionOption (question_id, question_text, isTrue) VALUES (?, ?, ?)";

     await connection.query(
       query,
       [question_id, req.files["image"][0].filename, isTrue],
       (err, result) => {
         if (err) {
           console.error(
             "Erreur lors de l'insertion des options d'une question:",
             err
           );
           res.status(500).json({
             message: "Error while inserting question options",
           });
         } else {
           console.log("result :");
           console.log(result);
           res.status(200).json({ message: "Question added successfuly !" });
         }
       }
     );
   }
 );


exports.getQuestionsCountByType = asyncHandler(async   (req, res,next) => {

     const countQuery = `
       SELECT
         COUNT(*) AS total,
         SUM(isQcm = 1) AS qcmQstsCount,
         SUM(isQcm = 0) AS textQstsCount,
         SUM(isQcm = 2) AS imgQstsCount
       FROM question
     `;

     connection.query(countQuery, (err, results) => {
       if (err) {
         console.error("Error while fetching questions:", err);
         res.status(500).json({ message: "Error while fetching questions" });
       } else {
         res.status(200).json(results[0]);
       }
     }
     );
   }
   );

   exports.deleteQuestion = asyncHandler(async (req, res) => {
    const question_id = req.params.id;
    const query = "DELETE FROM question WHERE id = ?";
    try {
      connection.query(query, [question_id], (err, result) => {
        if (err) {
          console.error("DATABASE ERROR:", err); // Log the error
          res.status(500).json({
            message: "Erreur lors de la suppression des options d'une question",
          });
        } else {
          res.status(200).json({ message: "Question deleted successfully!" });
        }
      });
    } catch (error) {
      console.error("INTERNAL SERVER ERROR:", error); // Log the error
      res.status(500).json({
        message: "Internal server error while deleting the question",
      });
    }
  });

