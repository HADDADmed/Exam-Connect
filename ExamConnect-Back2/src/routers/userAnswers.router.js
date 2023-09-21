const express = require("express");

const router = express.Router();

const connection = require("../DataBaseConf/MySqlConnection");
const verifyToken = require("../middlewares/verifyToken");

router.get("/", (req, res) => {
     const selectQuery = "SELECT * FROM userAnswer";
     connection.query(selectQuery, (err, rows) => {
          if (err) throw err;
          res.json(rows);
     });
});

router.post("/", verifyToken, (req, res) => {
     const userAnswer = req.body;
     const user_id = req.user.id;
     const exam_id = userAnswer.exam_id;
     const question_id = userAnswer.question_id;


     let isTrue = null;
     let userAnswerText = null;
     let questionOption_id = null;

     userAnswer.userAnswerText? userAnswerText = userAnswer.userAnswerText : null;
     userAnswer.questionOption_id? questionOption_id = userAnswer.questionOption_id : null;
     userAnswer.questionOption_id? isTrue = userAnswer.isTrue : null;


     const insertQuery =
          "INSERT INTO userAnswer ( user_id,exam_id,question_id, questionOption_id,isTrue,userAnswerText ) VALUES (?,?,?,?,?,?)";
     connection.query(
          insertQuery,
          [
               user_id,
               exam_id,
               question_id,
               questionOption_id ,
               isTrue ,
               userAnswerText ,
          ],
          (err, rows) => {
               if (err) throw err;
               console.log('answer added successfully');
               res.json(rows);
          }
     );
});

router.get('/user/:user_id/exam/:exam_id', (req, res) => {
        const user_id = req.params.user_id;
        const exam_id = req.params.exam_id;
         
        const selectQuery = `
            SELECT 
                userAnswer.id AS userAnswer_id,
                userAnswer.user_id,
                userAnswer.exam_id,
                userAnswer.question_id,
                userAnswer.questionOption_id AS userAnswer_questionOption_id,
                userAnswer.userAnswerText,
                Exam.id AS exam_id,
                Exam.ExamTitle AS exam_title,
                Exam.questionsCount AS exam_questionsCount,
                user.fullName AS user_fullName,
                question.question_text,
                question.isQcm AS isQcm,
                questionOption.id AS question_option_id,
                questionOption.question_text AS question_option_text,
                questionOption.isTrue AS question_option_isTrue,
                exam_user.status AS exam_user_status
            FROM userAnswer
            LEFT JOIN Exam ON userAnswer.exam_id = Exam.id
            LEFT JOIN user ON userAnswer.user_id = user.id
            LEFT JOIN question ON userAnswer.question_id = question.id
            LEFT JOIN questionOption ON userAnswer.questionOption_id = questionOption.id
            LEFT JOIN exam_user ON userAnswer.exam_id = exam_user.exam_id
            WHERE userAnswer.user_id = ? AND userAnswer.exam_id = ? ;   
        `;

        connection.query(selectQuery, [user_id, exam_id], (err, rows) => {
            if (err) throw err;
            res.json(rows);
        });

        
       
    }
);


module.exports = router;
