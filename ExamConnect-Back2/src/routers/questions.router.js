const express = require("express");
const router = express.Router();
const connection = require("../DataBaseConf/MySqlConnection");

// Get All Questions from the database

router.get("/", (req, res) => {
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

  connection.query(query, (err, results) => {
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
      res.status(200).json(questions);
    }
  });
});


// Get all Questions id's and isQcm's from the database

router.get("/ids", (req, res) => {
    const query = "SELECT id, isQcm FROM question";
    // english
    connection.query(query, (err, results) => {
        if (err) {
            console.error("Error while fetching questions:", err);
            res.status(500).json({ message: "Error while fetching questions" });
        } else {

            res.status(200).json(results);
        }
    });
});



// add new question to the database

router.post("/", (req, res) => {
  const question = req.body;
  const options = question.qstOptions;

  // inserting the wuestion first
  const query = "INSERT INTO question (question_text, isQcm) VALUES (?, ?)";
  connection.query(query, [question.qstText, question.isQcm], (err, result) => {
    if (err) {
      console.error("Erreur lors de l'insertion d'une question:", err);
      res
        .status(500)
        .json({ message: "Erreur lors de l'insertion d'une question" });
    } else {
      // inserting the question options
      if (options) {
        const question_id = result.insertId;
        const query =
          "INSERT INTO questionOption (question_id, question_text, isTrue) VALUES ?";
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
            res
              .status(500)
              .json({
                message:
                  "Erreur lors de l'insertion des options d'une question",
              });
          } else {
            res.status(200).json({ message: "Question added successfuly !" });
          }
        });
      } else {
        res.status(200).json({ message: "Question added successfuly !" });
      }
    }
  });
});

// update a question in the database

router.put("/:id", (req, res) => {
  const question = req.body;
  const options = question.qstOptions;
  const question_id = req.params.id;

  // delete the old question options
  const query = "DELETE FROM questionOption WHERE question_id = ?";

  connection.query(query, [question_id], (err, result) => {
    if (err) {
      console.error(
        "Erreur lors de la suppression des options d'une question:",
        err
      );
      res
        .status(500)
        .json({
          message: "Erreur lors de la suppression des options d'une question",
        });
    } else {
      // update the question
      const query = `
                UPDATE question
                SET question_text = ?, isQcm = ?
                WHERE id = ?
            `;

      connection.query(
        query,
        [question.qstText, question.isQcm, question_id],
        (err, result) => {
          if (err) {
            console.error("Erreur lors de la mise à jour d'une question:", err);
            res
              .status(500)
              .json({
                message: "Erreur lors de la mise à jour d'une question",
              });
          } else {
            // inserting the question options

            if (options) {
              const query =
                "INSERT INTO questionOption (question_id, question_text, isTrue) VALUES ?";

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
                  res
                    .status(500)
                    .json({
                      message:
                        "Erreur lors de l'insertion des options d'une question",
                    });
                } else {
                  res
                    .status(200)
                    .json({ message: "Question updated successfuly !" });
                }
              });
            } else {
              res
                .status(200)
                .json({ message: "Question updated successfuly !" });
            }
          }
        }
      );
    }
  });
});




/// delete a question from the database
router.delete("/:id", (req, res) => {
    const question_id = req.params.id;
    const query = "DELETE FROM question WHERE id = ?";
    const query2 = "DELETE FROM questionOption WHERE question_id = ?";
    connection.query(query2, [question_id], (err, result) => {
        if (err) {
            console.error("Erreur lors de la suppression des options d'une question:", err);
            res.status(500).json({ message: "Erreur lors de la suppression des options d'une question" });
        } else {
            connection.query(query, [question_id], (err, result) => {
                if (err) {
                    console.error("Erreur lors de la suppression d'une question:", err);
                    res.status(500).json({ message: "Erreur lors de la suppression d'une question" });
                } else {
                    res.status(200).json({ message: "Question deleted successfuly !" });
                }
            });
        }
    });
   
 });


module.exports = router; // Export the router
