const express = require("express");
const router = express.Router();
const connection = require("../DataBaseConf/MySqlConnection");

router.get("/", (req, res) => {
  const query = `
                SELECT 
                  Exam.id AS exam_id, 
                  Exam.ExamTitle, 
                  Exam.questionsCount, 
                  Exam.startTime,
                  Exam.endTime,
                  Exam.createdAt,
                  question.id AS question_id, 
                  question.isQcm 
                FROM Exam 
                INNER JOIN exam_question ON Exam.id = exam_question.exam_id
                INNER JOIN question ON exam_question.question_id = question.id
      `;
  connection.query(query, (err, results) => {
    if (err) {
       console.error("Error while fetching exams:", err);
      res
        .status(500)
        .json({ message: "Error while fetching exams" });
    } else {
      const exams = [];
      results.forEach((row) => {
        const existingExam = exams.find(
          (exam) => exam.exam_id === row.exam_id
        );
        if (!existingExam) {
          exams.push({
            exam_id: row.exam_id,
            ExamTitle: row.ExamTitle,
            questionsCount: row.questionsCount,
            startTime: row.startTime,
            endTime: row.endTime,
            createdAt: row.createdAt,
            questions: [
              {
                 id: row.question_id,
                 isQcm: row.isQcm,
              },
            ],
          });
        } else {
          existingExam.questions.push({
            id: row.question_id,
            isQcm: row.isQcm,
          });
        }
      });
          res.status(200).json(exams);
    }
  });
});

// create a new exam

router.post("/", (req, res) => {
  const exam = req.body;
  console.log("exam");
  console.log(exam);
  const questions = exam.questions;
  console.log("questions");
  console.log(questions);
  const query = `
    INSERT INTO Exam 
    (examTitle, questionsCount, startTime, endTime)
    VALUES
    (?, ?, ?, ?)
    `;
  connection.query(
    query,
    [exam.examTitle, exam.questionsCount, exam.startTime, exam.endTime],
    (err, results) => {
      if (err) { 
        console.error("Error while creating exam:", err);
        res
          .status(500)
          .json({ message: "Error while creating exam" });
      } else {
        // insert questions
        const examId = results.insertId;
        const query = `
            INSERT INTO exam_question
            (exam_id, question_id)
            VALUES
            (?, ?)
            `;
        questions.forEach((question) => {
          connection.query(query, [examId, question.id], (err, results) => {
            if (err) {
              console.error("Error while creating exam:", err);
              res
                .status(500)
                .json({ message: "Error while creating exam" });
            } else {
                 console.log("question added to the Exam successfuly");
                }
          });


        });
        res.status(200).json({ message: "Exam created successfuly !" });
      }
    }
  );
});

// get exam by id

router.get("/exam/:id", (req, res) => {
  const examId = req.params.id;
  const query = `
          SELECT 
            Exam.id AS exam_id, 
            Exam.ExamTitle, 
            Exam.questionsCount, 
            Exam.startTime,
            Exam.endTime,
            Exam.createdAt,
            question.id AS question_id, 
            question.question_text,
            question.isQcm,
            qo.id AS option_id,
            qo.question_text,
            qo.isTrue
            
            FROM Exam 
            INNER JOIN exam_question ON Exam.id = exam_question.exam_id
            INNER JOIN question ON exam_question.question_id = question.id
            INNER JOIN questionoption AS qo ON question.id = qo.question_id
            WHERE Exam.id = ?;
    `;
    
  connection.query(query, [examId], (err, results) => {
    if (err) {
      console.error("Error while fetching exam:", err);
      res
        .status(500)
        .json({ message: "Error while fetching exam" });
    } else {
       if(results.length === 0) {
        res.status(404).json({ message: "Exam not found" });

          } else{
            const exam = {
              exam_id: results[0].exam_id,
              ExamTitle: results[0].ExamTitle,
              questionsCount: results[0].questionsCount,
              startTime: results[0].startTime,
              endTime: results[0].endTime,
              createdAt: results[0].createdAt,
              questions: [],
            };
            results.forEach((row) => {
              const existingQuestion = exam.questions.find(
                (question) => question.question_id === row.question_id
              );
              if (!existingQuestion) {
                exam.questions.push({
                  question_id: row.question_id,
                  question_text: row.question_text,
                  isQcm: row.isQcm,
                  options: [
                    {
                      id: row.option_id,
                      question_text: row.question_text,
                      isTrue: row.isTrue,
                    },
                  ],
                });
              } else {
                existingQuestion.options.push({
                  id: row.option_id,
                  question_text: row.question_text,
                  isTrue: row.isTrue,
                });
              }
            });
            res.status(200).json(exam);
          }
    }
  }
  );
}
);






module.exports = router;
