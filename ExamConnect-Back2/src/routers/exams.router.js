const express = require("express");
const router = express.Router();
const connection = require("../DataBaseConf/MySqlConnection");

const verifyToken = require("../middlewares/verifyToken");
const verifyAdmin = require("../middlewares/verifyAdmin");

router.get("/", verifyAdmin, (req, res) => {
     const query = `
                SELECT 
                  Exam.id AS exam_id, 
                  Exam.ExamTitle, 
                  Exam.questionsCount, 
                  Exam.startTime,
                  Exam.endTime,
                  Exam.createdAt,
                  Exam.duration_minutes,
                  question.id AS question_id, 
                  question.isQcm,
                  (SELECT COUNT(*) FROM exam_user WHERE exam_id = Exam.id ) AS usersCount
                FROM Exam 
                INNER JOIN exam_question ON Exam.id = exam_question.exam_id
                INNER JOIN question ON exam_question.question_id = question.id
                ORDER BY Exam.createdAt DESC;
      `;
     connection.query(query, (err, results) => {
          if (err) {
               console.error("Error while fetching exams:", err);
               res.status(500).json({ message: "Error while fetching exams" });
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
                              duration_minutes: row.duration_minutes,
                              usersCount: row.usersCount,
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

router.post("/", verifyAdmin, (req, res) => {
     const exam = req.body;
     const questions = exam.questions;

     const usersSelected = exam.usersSelected;

     const query = `
    INSERT INTO Exam 
    (examTitle, questionsCount, startTime, endTime,duration_minutes)
    VALUES
    (?, ?, ?, ?, ?)
    `;
     connection.query(
          query,
          [
               exam.examTitle,
               exam.questionsCount,
               exam.startTime,
               exam.endTime,
               exam.duration_minutes,
          ],
          (err, results) => {
               if (err) {
                    console.error("Error while creating exam:", err);
                    res.status(500).json({
                         message: "Error while creating exam",
                    });
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
                         connection.query(
                              query,
                              [examId, question.id],
                              (err, results) => {
                                   if (err) {
                                        console.error(
                                             "Error while creating exam:",
                                             err
                                        );
                                        res.status(500).json({
                                             message: "Error while creating exam",
                                        });
                                   } else {
                                        console.log(
                                             "question added to the Exam successfuly"
                                        );
                                   }
                              }
                         );
                    });
                    // insert users ids to the exam_user table
                    const isertExam_UserQuery = `
                            INSERT INTO exam_user
                            (exam_id, user_id, status)
                            VALUES
                            (?, ?, ?)
                            `;
                    usersSelected.forEach((user) => {
                         connection.query(
                              isertExam_UserQuery,
                              [examId, user.id, "notStarted"],
                              (err, results) => {
                                   if (err) {
                                        console.error(
                                             "Error while creating exam:",
                                             err
                                        );
                                        res.status(500).json({
                                             message: "Error while creating exam",
                                        });
                                   } else {
                                        // insert to the exam_user_status table
                                        const insertedExam_User_Id =
                                             results.insertId;
                                        const isertExam_User_StatusQuery = `
                                                    INSERT INTO exam_user_status
                                                    (status_id,exam_user_id)
                                                    VALUES
                                                    (?, ?)
                                                    `;

                                        connection.query(
                                             isertExam_User_StatusQuery,
                                             [1, insertedExam_User_Id],
                                             (err, results) => {
                                                  if (err) {
                                                       console.error(
                                                            "Error while creating exam:",
                                                            err
                                                       );
                                                       res.status(500).json({
                                                            message: "Error while creating exam",
                                                       });
                                                  } else {
                                                       console.log(
                                                            "status added to the user_exam successfuly"
                                                       );
                                                  }
                                             }
                                        );
                                        console.log(
                                             "user added to the Exam successfuly"
                                        );
                                   }
                              }
                         );
                    });
                    res.status(201).json({
                         message: "Exam created successfuly !",
                    });
               }
          }
     );
});

// get exam by id

router.get("/exam/:id", verifyToken, (req, res) => {
     const examId = req.params.id;
     const query = `
    SELECT 
        Exam.id AS exam_id, 
        Exam.ExamTitle, 
        Exam.questionsCount, 
        Exam.startTime,
        Exam.endTime,
        Exam.duration_minutes,
        Exam.createdAt,
        question.id AS question_id, 
        question.question_text,
        question.isQcm,
        qo.id AS option_id,
        qo.question_text AS option_question_text,
        qo.isTrue,
        user.id AS user_id,
        user.fullName,
        user.email,
        exam_user.status
    FROM Exam 
    INNER JOIN exam_question ON Exam.id = exam_question.exam_id
    INNER JOIN question ON exam_question.question_id = question.id
    LEFT JOIN questionoption AS qo ON question.id = qo.question_id
    LEFT JOIN exam_user ON Exam.id = exam_user.exam_id
    LEFT JOIN user ON exam_user.user_id = user.id

    WHERE Exam.id = ?;
`;

     connection.query(query, [examId], (err, results) => {
          if (err) {
               console.error("Error while fetching exam:", err);
               res.status(500).json({ message: "Error while fetching exam" });
          } else {
               if (results.length === 0) {
                    res.status(404).json({ message: "Exam not found" });
               } else {
                    const exam = {
                         exam_id: results[0].exam_id,
                         ExamTitle: results[0].ExamTitle,
                         questionsCount: results[0].questionsCount,
                         startTime: results[0].startTime,
                         endTime: results[0].endTime,
                         duration_minutes: results[0].duration_minutes,
                         usersCount: 0,
                         createdAt: results[0].createdAt,

                         users: [],
                         questions: [],
                    };
                    results.forEach((row) => {
                         const existingQuestion = exam.questions.find(
                              (question) =>
                                   question.question_id === row.question_id
                         );
                         if (!existingQuestion) {
                              exam.questions.push({
                                   question_id: row.question_id,
                                   question_text: row.question_text,
                                   isQcm: row.isQcm,
                                   options: [],
                              });
                         }
                         const existingOption = exam.questions
                              .find(
                                   (question) =>
                                        question.question_id === row.question_id
                              )
                              .options.find(
                                   (option) =>
                                        option.option_id === row.option_id
                              );
                         if (!existingOption) {
                              exam.questions
                                   .find(
                                        (question) =>
                                             question.question_id ===
                                             row.question_id
                                   )
                                   .options.push({
                                        option_id: row.option_id,
                                        question_text: row.option_question_text,
                                        isTrue: row.isTrue,
                                   });
                         }
                         const existingUser = exam.users.find(
                              (user) => user.id === row.user_id
                         );
                         if (!existingUser) {
                              exam.users.push({
                                   id: row.user_id,
                                   fullName: row.fullName,
                                   email: row.email,
                                   exam_status: row.status,
                              });
                         }
                    });

                    // sorting the questions by isQcm  (qcm questions first) (text questions second) (image questions third)

                    const qcmQuestions = exam.questions.filter(
                         (question) => question.isQcm === 1
                    );
                    const textQuestions = exam.questions.filter(
                         (question) => question.isQcm === 0
                    );
                    const imageQuestions = exam.questions.filter(
                         (question) => question.isQcm === 2
                    );
                    exam.questions = qcmQuestions.concat(
                         textQuestions,
                         imageQuestions
                    );
                     exam.usersCount = exam.users.length;
                    res.status(200).json(exam);
               }
          }
     });
});

router.get("/checkAutorisationToExam/:id", verifyToken, (req, res) => {
     const user_id = req.user.id;
     const exam_id = req.params.id;
     const query = `
     SELECT id from exam where id = ? ;
     `;
     connection.query(query, [exam_id], (err, results1) => {
          if (err) {
               console.error("Error while fetching exam:", err);
               res.status(500).json({ message: "Error while fetching exam" });
          } else {
               if (results1.length === 0) {
                    console.log("exam not found");
                    res.status(404).json({ message: "Exam not found" });
               } else {
                    const query = `
                    SELECT * from exam_user where exam_id = ? and user_id = ? ;
                    `;
                    connection.query(
                         query,
                         [exam_id, user_id],
                         (err, results) => {
                              if (err) {
                                   console.error(
                                        "Error while fetching exam:",
                                        err
                                   );
                                   res.status(500).json({
                                        message: "Error while fetching exam",
                                   });
                              } else {
                                   if (results.length === 0) {
                                         res.status(401).json({
                                             message: "Unauthorized",
                                        });
                                        
                                   } else {
                                        console.log("Authorized");
                                        console.log(results[0]);
                                        res.status(200).json({
                                             message: "Authorized",
                                             user_exam : results[0]
                                        });
                                   }
                              }
                         }
                    );
               }
          }
     });
});


router.get('/userexamStatus/:id', verifyToken, (req, res) => {
     const user_id = req.user.id;
     const exam_id = req.params.id;
     const startOrEnd = req.query.startOrEnd;
     
     console.log('startOrEnd');
     console.log(startOrEnd);
      console.log('user_id');
     console.log(user_id);
     console.log('exam_id');
     console.log(exam_id);


     const selectIdQuery = `
     SELECT id as exam_user_id from exam_user  WHERE exam_id = ? AND user_id = ? ;
     `;

    const insertQuery = `
     INSERT INTO exam_user_status 
     (status_id, exam_user_id)
     VALUES
     (?, ?);
     `;
     const updateQuery = `
          UPDATE exam_user 
          SET status = ?
          WHERE id = ? ;
     `;


     


     connection.query(selectIdQuery, [exam_id, user_id], (err, results) => {
          if (err) {
               console.error("Error while fetching exam:", err);
               res.status(500).json({ message: "Error while fetching exam" });
          } else {
               if (results.length === 0) {
                    console.log("exam not found");
                    res.status(404).json({ message: "Exam not found" });
               } else {
                    const exam_user_id = results[0].exam_user_id;
                    connection.query(
                         insertQuery,
                         [startOrEnd == 'start'?2:3, exam_user_id],
                         (err, results) => {
                              if (err) {
                                   console.error(
                                        "Error while fetching exam:",
                                        err
                                   );
                                   res.status(500).json({
                                        message: "Error while fetching exam",
                                   });
                              } else {
                                   connection.query(
                                        updateQuery,
                                        [startOrEnd == 'start' ?"inProgress":"pendingReview", exam_user_id],
                                        (err, results) => {
                                             if (err) {
                                                  console.error(
                                                       "Error while fetching exam:",
                                                       err
                                                  );
                                                  res.status(500).json({
                                                       message:
                                                            "Error while fetching exam",
                                                  });
                                             } else {
                                                  res.status(200).json({
                                                       message:
                                                            "exam status updated successfuly",
                                                  });
                                             }
                                        }
                                   );
                              }
                         }
                    );
               }
          }
     });


}
);





module.exports = router;
