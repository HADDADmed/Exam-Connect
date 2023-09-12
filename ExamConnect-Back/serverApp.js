

const express = require("express");
const app = express();
const PORT = 3000;



const bodyParser = require("body-parser");
const cors = require("cors");
const connection = require("./middleware/mysqlConfig");



app.use(express.json());
app.use(cors());
app.use(express.static("public"));
app.use(
  bodyParser.urlencoded({
    extended: true,
  })
);



app.use(connection);



const multer = require("multer");

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "public/images");
  },
  filename: (req, file, cb) => {
    const uniqueSuffix = Date.now() + "-" + Math.round(Math.random() * 1e9);
    cb(null, uniqueSuffix + "-" + file.originalname);
  },
});



const upload = multer({ storage: storage });



app.post("/upload-image", upload.single("image"), (req, res) => {
  if (!req.file) {
    return res
      .status(400)
      .json({ message: "Aucune image n'a été téléchargée." });
  }
  const imageUrl = req.file.filename;
  res.status(201).json({ imageUrl: imageUrl });
});

app.get("/", (req, res) => {
  connection.query("SELECT * FROM questions", (err, rows) => {
    if (err) {
      console.error("Erreur de requête SQL :", err);
      res.status(500).send("Erreur de base de données");
    } else {
      res.json(rows);
    }
  });
});

app.get("/questions", (req, res) => {
  const query = "SELECT * FROM questions";
  connection.query(query, (err, result) => {
    if (err) {
      console.error("Erreur lors de la récupération des questions:", err);
      res
        .status(500)
        .json({ message: "Erreur lors de la récupération des questions" });
    } else {
      res.status(200).json(result);
    }
  });
});

app.post("/questions", (req, res) => {
  const { text_question, type_question, choices, correctChoiceIndex } =
    req.body;
  const query =
    "INSERT INTO questions (texte_question, type_question) VALUES (?, ?)";
  connection.query(query, [text_question, type_question], (err, result) => {
    if (err) {
      console.error("Erreur lors de l'enregistrement de la question:", err);
      res
        .status(500)
        .json({ message: "Erreur lors de l'enregistrement de la question" });
    } else {
      const question_id = result.insertId;

      if (choices && choices.length > 0) {
        const choiceQuery =
          "INSERT INTO choix (text_question, question_id, status) VALUES (?, ?, ?)";
        choices.forEach((choice, index) => {
          let choiceText =
            choice.type === "text" ? choice.value : choice.source;
          let choiceStatus =
            index === correctChoiceIndex ? "active" : "inactive";
          connection.query(
            choiceQuery,
            [choiceText, question_id, choiceStatus],
            (err, choiceResult) => {
              if (err) {
                console.error("Erreur lors de l'enregistrement du choix:", err);
              }
            }
          );
        });
      }
      res
        .status(201)
        .json({ message: "Question et choix enregistrés avec succès" });
    }
  });
});

app.post("/questions/:question_id/choices", (req, res) => {
  const question_id = req.params.question_id;
  const { choices, correctChoiceIndex } = req.body;

  if (choices && choices.length > 0) {
    const choiceQuery =
      "INSERT INTO choix (text_question, question_id, status) VALUES (?, ?, ?)";
    choices.forEach((choice, index) => {
      let choiceText = choice.type === "text" ? choice.value : choice.source;
      let choiceStatus = index === correctChoiceIndex ? "active" : "inactive";
      connection.query(
        choiceQuery,
        [choiceText, question_id, choiceStatus],
        (err, choiceResult) => {
          if (err) {
            console.error("Erreur lors de l'enregistrement du choix:", err);
          }
        }
      );
    });
    res.status(201).json({ message: "Choix enregistrés avec succès" });
  } else {
    res.status(400).json({ message: "Aucun choix fourni" });
  }
});

app.get("/exams", (req, res) => {
  const query = `
      SELECT 
        examens.id AS examen_id, 
        examens.titre, 
        examens.nombre_qsts, 
        examens.date_heure_debut,
        examens.date_heure_fin,
        questions.id AS question_id, 
        questions.texte_question, 
        questions.type_question
      FROM examens
      INNER JOIN examen_question ON examens.id = examen_question.examen_id
      INNER JOIN questions ON examen_question.question_id = questions.id
    `;
  connection.query(query, (err, results) => {
    if (err) {
      console.error("Erreur lors de la récupération des examens:", err);
      res
        .status(500)
        .json({ message: "Erreur lors de la récupération des examens" });
    } else {
      const exams = [];
      results.forEach((row) => {
        const existingExam = exams.find(
          (exam) => exam.examen_id === row.examen_id
        );

        if (!existingExam) {
          exams.push({
            examen_id: row.examen_id,
            titre: row.titre,
            nombre_qsts: row.nombre_qsts,
            date_heure_debut: row.date_heure_debut,
            date_heure_fin: row.date_heure_fin,
            questions: [
              {
                id: row.question_id,
                texte_question: row.texte_question,
                type_question: row.type_question,
              },
            ],
          });
        } else {
          existingExam.questions.push({
            id: row.question_id,
            texte_question: row.texte_question,
            type_question: row.type_question,
          });
        }
      });
      res.status(200).json(exams);
    }
  });
});

app.post("/exams", (req, res) => {
  const { titre, nombre_qsts, date_heure_debut, date_heure_fin, questions } =
    req.body;

  const examQuery =
    "INSERT INTO examens (titre, nombre_qsts, date_heure_debut, date_heure_fin) VALUES (?, ?, ?, ?)";

  connection.query(
    examQuery,
    [titre, nombre_qsts, date_heure_debut, date_heure_fin],
    (err, examResult) => {
      if (err) {
        console.error("Erreur lors de l'enregistrement de l'examen:", err);
        res
          .status(500)
          .json({ message: "Erreur lors de l'enregistrement de l'examen" });
      } else {
        const examen_id = examResult.insertId;

        if (questions && questions.length > 0) {
          const examQuestionQuery =
            "INSERT INTO examen_question (examen_id, question_id) VALUES (?, ?)";
          questions.forEach((question) => {
            const question_id = question.id;
            connection.query(
              examQuestionQuery,
              [examen_id, question_id],
              (err, examQuestionResult) => {
                if (err) {
                  console.error(
                    "Erreur lors de l'enregistrement de la question de l'examen:",
                    err
                  );
                }
              }
            );
          });
        }
        res.status(201).json({ message: "Examen enregistré avec succès" });
      }
    }
  );
});

app.get("/exams/:id", (req, res) => {
  const examenId = req.params.id;

  const query = `
    SELECT 
      examens.id AS examen_id, 
      examens.titre, 
      examens.nombre_qsts, 
      examens.date_heure_debut,
      examens.date_heure_fin,
      questions.id AS question_id, 
      questions.texte_question, 
      questions.type_question
    FROM examens
    INNER JOIN examen_question ON examens.id = examen_question.examen_id
    INNER JOIN questions ON examen_question.question_id = questions.id
    WHERE examens.id = ?
  `;

  connection.query(query, [examenId], (err, results) => {
    if (err) {
      console.error(
        "Erreur lors de la récupération de l'examen et des questions:",
        err
      );
      res
        .status(500)
        .json({
          message:
            "Erreur lors de la récupération de l'examen et des questions",
        });
    } else {
      if (results && results.length > 0) {
        const examen = {
          id: results[0].examen_id,
          titre: results[0].titre,
          nombre_qsts: results[0].nombre_qsts,
          date_heure_debut: results[0].date_heure_debut,
          date_heure_fin: results[0].date_heure_fin,
          questions: [],
        };

        results.forEach((row) => {
          examen.questions.push({
            id: row.question_id,
            texte_question: row.texte_question,
            type_question: row.type_question,
          });
        });

        res.status(200).json(examen);
      } else {
        res.status(404).json({ message: "Examen non trouvé" });
      }
    }
  });
});

// API pour obtenir les questions d'un examen spécifique
app.get("/exams/:examenId/questions", (req, res) => {
  const examenId = req.params.examenId;

  const query = `
    SELECT
      questions.id AS question_id,
      questions.texte_question,
      questions.type_question
    FROM questions
    INNER JOIN examen_question ON questions.id = examen_question.question_id
    WHERE examen_question.examen_id = ?
  `;

  connection.query(query, [examenId], (err, results) => {
    if (err) {
      console.error(
        "Erreur lors de la récupération des questions de l'examen:",
        err
      );
      res
        .status(500)
        .json({
          message: "Erreur lors de la récupération des questions de l'examen",
        });
    } else {
      const questions = results.map((row) => ({
        id: row.question_id,
        texte_question: row.texte_question,
        type_question: row.type_question,
      }));

      res.status(200).json(questions);
    }
  });
});

app.post("/register", (req, res) => {
  const { nom, prenom, email, mot_de_passe, level } = req.body;

  const query =
    "INSERT INTO utilisateur (nom, prenom, email, mot_de_passe, level) VALUES (?, ?, ?, ?, ?)";

  connection.query(
    query,
    [nom, prenom, email, mot_de_passe, level],
    (err, result) => {
      if (err) {
        console.error("Erreur lors de l'enregistrement de l'utilisateur:", err);
        res
          .status(500)
          .json({
            message: "Erreur lors de l'enregistrement de l'utilisateur",
          });
      } else {
        res.status(201).json({ message: "Utilisateur enregistré avec succès" });
      }
    }
  );
});

app.post("/login", (req, res) => {
  const { email, mot_de_passe } = req.body;
  const query =
    "SELECT * FROM utilisateur WHERE email = ? AND mot_de_passe = ?";
  connection.query(query, [email, mot_de_passe], (err, row) => {
    if (err) {
      console.error(err);
      res.status(500).json({ message: "Erreur interne du serveur" });
      return;
    }

    if (!row) {
      res
        .status(401)
        .json({ message: "L'email ou le mot de passe est incorrect" });
      return;
    }
    res.status(200).json({ message: "Connexion réussie", user: row });
  });
});

app.get("/users", (req, res) => {
  const query = "SELECT * FROM utilisateur";
  connection.query(query, (err, results) => {
    if (err) {
      console.error("Erreur lors de la récupération des utilisateurs:", err);
      res
        .status(500)
        .json({ error: "Erreur lors de la récupération des utilisateurs" });
    } else {
      res.status(200).json(results);
    }
  });
});

app.listen(process.env.PORT || PORT, () => {
  console.log(
    `Serveur en cours d'exécution sur http://localhost:${
      process.env.PORT || PORT
    }`
  );
});
