const express = require("express");
const router = express.Router();
const connection = require("../DataBaseConf/MySqlConnection");
const multer = require("multer");



// Multer storage configuration
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    // Define the destination directory where uploaded images will be stored
    cb(null, 'uploads/'); // You should create the 'uploads' directory
  },
  filename: (req, file, cb) => {
    // Define how uploaded files should be named
    const ext = path.extname(file.originalname);
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, uniqueSuffix + ext);
  },
});

// Create a Multer instance with the storage configuration
const upload = multer({ storage });



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
  const isQcm = question.isQcm;
  const options = question.qstOptions;

  // inserting the wuestion first
  const query = "INSERT INTO question (question_text, isQcm) VALUES (?, ?)";
  connection.query(query, [question.qstText, question.isQcm], (err, result) => {
    if (err || isQcm && isQcm === 2) {
      console.error("Erreur lors de l'insertion d'une question:", err);
      res
        .status(500)
        .json({ message: "Erreur lors de l'insertion d'une question" });
    } else {
      // inserting the question options
      if(!isQcm){
        res.status(200).json({ message: "Question added successfuly !" });
      }else if (isQcm && isQcm === 1) {
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
            res
              .status(500)
              .json({
                message:
                  "Error while inserting question options",
              });
          } else {
            res.status(200).json({ message: "Question added successfuly !" });
          }
        });
      } 
    }
  });
});

 

// add new question with images 

// router.post("/imageQuestion", upload.single('image'), async (req, res) => {

//   const question = req.body;
//   const isQcm = question.isQcm;
//   const options = question.qstOptions;
//   const images =    // using multer to upload the image to the server and sharp to resize it


// // add new question with images
// router.post("/imageQuestion", upload.single("image"), async (req, res) => {
//   try {
//     if (!req.file) {
//       throw new Error("Please upload an image");
//     }

//     // Process the uploaded image using sharp
//     const imagePath = path.join(__dirname, "../public/images/", req.file.filename);

//     await sharp(req.file.path)
//       .resize(300) // Set the desired image width (you can adjust as needed)
//       .toFile(imagePath);

//     // Now, imagePath contains the path to the processed image

//     // You can save the imagePath to your database or use it as needed
//     // For example, if you want to store the image path in a database:
//     // const imagePathToSaveInDatabase = `/public/images/${req.file.filename}`;
    
//     // Respond with success
//     res.status(201).send({ message: "Image uploaded and processed successfully" });
//   } catch (error) {
//     console.error(error);
//     res.status(400).send({ error: error.message });
//   }
// });

// POST route for handling image uploads
router.post('/imageQuestion', upload.array('qstImages'), (req, res) => {
  // The 'qstImages' parameter in upload.array('qstImages', 5) should match the field name in your FormData on the frontend

  // Here, req.files contains an array of uploaded files
  // Each file will have properties like 'fieldname', 'originalname', 'filename', 'path', and 'size'
  console.log("req.files :");
  console.log(req.files);
  console.log("req.body.qstImages :");
  console.log(req.body.qstImages);
  // Access other form fields in req.body
 
  // Perform any necessary processing with the uploaded files and form data

  // Send a response to the client
  res.json({ message: 'File(s) uploaded successfully' });
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
