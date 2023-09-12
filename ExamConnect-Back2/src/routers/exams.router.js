
const express = require('express');
const router = express.Router();
const connection = require('../DataBaseConf/MySqlConnection');




router.get("/", (req, res) => {
    const query = `
                SELECT 
                  Exam.id AS examen_id, 
                  Exam.ExamTitle, 
                  Exam.questionsCount, 
                  Exam.startTime,
                  Exam.endTime,
                  question.id AS question_id, 
                  question.question_text, 
                  question.isQcm 
                FROM Exam 
                INNER JOIN exam_question ON Exam.id = exam_question.exam_id
                INNER JOIN question ON exam_question.question_id = question.id
      `;
    connection.query(query, (err, results) => {
      if (err) {
        console.error("Erreur lors de la récupération des Exam:", err);
        res
          .status(500)
          .json({ message: "Erreur lors de la récupération des Exam" });
      } else {
        const exams = [];
         results.forEach((row) => {
          const existingExam = exams.find(
            (exam) => exam.examen_id === row.examen_id
          );
          if (!existingExam) {
            exams.push({
              examen_id: row.examen_id,
              ExamTitle: row.ExamTitle,
              questionsCount: row.questionsCount,
              startTime: row.startTime,
              endTime: row.endTime,
              questions: [
                {
                  id: row.question_id,
                  question_text: row.question_text,
                  isQcm: row.isQcm,
                },
              ],
            });
          } else {
            existingExam.questions.push({
              id: row.question_id,
              question_text: row.question_text,
              isQcm: row.isQcm,
            });
          }
        });
        res.status(200).json(exams);
      }
    });
  });




  module.exports = router;