const asyncHandler = require("express-async-handler");
const connection = require("../DataBaseConf/MySqlConnection");

exports.getAllUserAnswers = asyncHandler(async (req, res, next) => {
     const selectQuery = "SELECT * FROM userAnswer";
     connection.query(selectQuery, (err, rows) => {
          if (err) throw err;
          res.json(rows);
     });
});

exports.createUserAnswer = asyncHandler(async (req, res, next) => {
     const userAnswer = req.body;
     const user_id = req.user.id;
     const exam_id = userAnswer.exam_id;
     const question_id = userAnswer.question_id;

     console.log("userAnswer :");
     console.log(userAnswer);

     let isTrue = null;
     let userAnswerText = null;
     let questionOption_id = null;

     userAnswer.userAnswerText
          ? (userAnswerText = userAnswer.userAnswerText)
          : null;
     userAnswer.questionOption_id
          ? (questionOption_id = userAnswer.questionOption_id)
          : null;
     let selectQuery = "";
     const insertQuery =
                    "INSERT INTO userAnswer ( user_id,exam_id,question_id, questionOption_id,isTrue,userAnswerText ) VALUES (?,?,?,?,?,?)";
     if (questionOption_id !== null) {
          selectQuery = ` SELECT id FROM questionOption WHERE question_id = ? AND isTrue = 1 `;

          connection.query(selectQuery, [question_id], (err, rows) => {
               if (err) throw err;
               if (!rows[0].id) {
                    return
               }
               isTrue = rows[0].id === questionOption_id ? 1 : 0;
               connection.query(
                    insertQuery,
                    [
                         user_id,
                         exam_id,
                         question_id,
                         questionOption_id,

                         isTrue,
                         userAnswerText,
                    ],
                    (err, rows) => {
                         if (err) throw err;
                         console.log("answer added successfully");
                         res.json(rows);
                    }
               );
          });
     }
     else {
          connection.query(
               insertQuery,
               [
                    user_id,
                    exam_id,
                    question_id,
                    questionOption_id,
                    isTrue,
                    userAnswerText,
               ],
               (err, rows) => {
                    if (err) throw err;
                    console.log("answer added successfully");
                    res.json(rows);
               }
          );
     }
});


exports.getUserAnswerByUserIdAndExamId = asyncHandler(
     async (req, res, next) => {
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
                userAnswer.isTrue AS userAnswer_isTrue,
                Exam.id AS exam_id,
                Exam.ExamTitle AS exam_title,
                Exam.questionsCount AS exam_questionsCount,
                user.fullName AS user_fullName,
                question.question_text,
                question.isQcm AS isQcm,
                questionOption.id AS question_option_id,
                questionOption.question_text AS question_option_text,
                questionOption.isTrue AS question_option_isTrue,
                exam_user.status AS exam_status,
                exam_user.id AS exam_user_id
            FROM userAnswer
            LEFT JOIN Exam ON userAnswer.exam_id = Exam.id
            LEFT JOIN user ON userAnswer.user_id = user.id 
            LEFT JOIN question ON userAnswer.question_id = question.id
            LEFT JOIN questionOption ON userAnswer.question_id = questionOption.question_id
            LEFT JOIN exam_user ON userAnswer.exam_id = exam_user.exam_id
            WHERE userAnswer.user_id = ? AND userAnswer.exam_id = ? and exam_user.user_id = ? AND exam_user.exam_id = ? ;   
        `;

          connection.query(
               selectQuery,
               [user_id, exam_id, user_id, exam_id],
               (err, rows) => {
                    if (err) throw err;
                    if(rows.length === 0) {
                        res.status(404).json({ message: "Not Found" });
                         return;
                    }
                    let userAnswer = {
                         exam_id: rows[0].exam_id,
                         exam_title: rows[0].exam_title,
                         exam_questionsCount: rows[0].exam_questionsCount,
                         user_fullName: rows[0].user_fullName,
                         user_id: rows[0].user_id,
                         exam_status: rows[0].exam_status,
                         exam_user_id: rows[0].exam_user_id,
                         examStatist: {
                              correctQuestions: 0,
                              wrongQuestions: 0,
                              correctQcmAndImage: 0,
                              correctTextQuestions: 0,
                              pendingReview: 0,
                              notAnsweredQuestions: 0,
                              total: rows[0].exam_questionsCount,
                              totalQcm: 0,
                              totalText: 0,
                              totalImage: 0,
                         },
                         questions: [],
                    };

                    rows.forEach((row) => {
                         const existingQuestion = userAnswer.questions.find(
                              (question) => question.question_id === row.question_id
                         );
                         let question = {};
                         if (!existingQuestion) {
                              if (row.isQcm === 0) {
                                   question = {
                                        question_id: row.question_id,
                                        question_text: row.question_text,
                                        isQcm: row.isQcm,
                                        userAnswerText: row.userAnswerText,
                                        isTrue: row.userAnswer_isTrue,
                                        options: [],
                                   };
                              } else {
                                   question = {
                                        question_id: row.question_id,
                                        question_text: row.question_text,
                                        isQcm: row.isQcm,
                                        isTrue: row.userAnswer_isTrue,
                                        options: [],
                                   };
                              }
                              userAnswer.questions.push(question);
                         }

                         const existingQuestionOption = userAnswer.questions
                              .find(
                                   (question) => question.question_id === row.question_id
                              )
                              .options.find(
                                   (option) =>
                                        option.id === row.question_option_id
                              );

                         if (!existingQuestionOption) {
                              const option = {
                                   id: row.question_option_id,
                                   question_text: row.question_option_text,
                                   isTrue: row.question_option_isTrue,
                                   isChecked:
                                        row.userAnswer_questionOption_id ===
                                        row.question_option_id
                                             ? 1
                                             : 0,
                              };
                              userAnswer.questions
                                   .find(
                                        (question) =>
                                             question.question_id === row.question_id
                                   )
                                   .options.push(option);
                         }
                    });

                    const textQuestions = userAnswer.questions.filter(
                         (question) => question.isQcm === 0
                    );
                    const qcmQuestions = userAnswer.questions.filter(
                         (question) => question.isQcm === 1
                    );
                    const imageQuestions = userAnswer.questions.filter(
                         (question) => question.isQcm === 2
                    );

                    userAnswer.questions = textQuestions.concat(
                         qcmQuestions,
                         imageQuestions
                    );

                    userAnswer.questions.forEach((question) => {
                         // calculate totalQcm
                         if (question.isQcm === 1) {
                              userAnswer.examStatist.totalQcm++;
                         }

                         // calculate totalText
                         if (question.isQcm === 0) {
                              userAnswer.examStatist.totalText++;
                         }

                         // calculate totalImage
                         if (question.isQcm === 2) {
                              userAnswer.examStatist.totalImage++;
                         }


                         if (question.isQcm === 1 || question.isQcm === 2) {
                              if (question.isTrue === 1) {
                                   userAnswer.examStatist.correctQuestions++;
                                   userAnswer.examStatist.correctQcmAndImage++;
                              }else if (question.isTrue === 0) {
                                   userAnswer.examStatist.wrongQuestions++;
                              }else if (question.isTrue === null) {
                                   userAnswer.examStatist.notAnsweredQuestions++;
                              }
                         }


                         if (question.isQcm == 0 ){
                              if (question.isTrue === 1) {
                                   userAnswer.examStatist.correctTextQuestions++;
                                   userAnswer.examStatist.correctQuestions++;
                              }

                              if (question.isTrue === 0) {
                                   userAnswer.examStatist.wrongQuestions++;
                              }
                              if (question.isTrue === null ) {
                                   userAnswer.examStatist.pendingReview++;

                              }
                         }

                          
                         // calculate notAnsweredQuestions
                         if (
                              question.isQcm === 0 &&
                              question.userAnswerText === null
                         ) {
                              userAnswer.examStatist.notAnsweredQuestions++;
                         }
                         if (
                              question.isQcm === 1 &&
                              question.options.every(
                                   (option) => option.isChecked === 0
                              )
                         ) {
                              userAnswer.examStatist.notAnsweredQuestions++;
                         }
                    });
                    res.json(userAnswer);
               }
          );
     }
);

exports.submitReview = asyncHandler(async (req, res, next) => {
     const userAnswer = req.body;
     const user_id = userAnswer.user_id;
     const exam_id = userAnswer.exam_id;
     const question_id = userAnswer.question_id;
     const review = userAnswer.review;

     
     if (review == null) {
          res.json({ message: "review is null" });
          return;
     }

     const updateQuery =
          "UPDATE userAnswer SET isTrue = ? WHERE user_id = ? AND exam_id = ? AND question_id = ? ";
     connection.query(
          updateQuery,
          [review == "success" ? 1 : 0, user_id, exam_id, question_id],
          (err, rows) => {
               if (err) throw err;
               console.log("answer updated successfully");
               console.log(rows);
               res.json(rows);
          }
     );
});


exports.submitFinalReview = asyncHandler(async (req, res, next) => {
    
     const exam_user_id = req.body.exam_user_id;
     const exam_id = req.body.exam_id;
     const user_id = req.body.user_id;
     const status_id = req.body.status_id;
     const insertQuery = `INSERT INTO exam_user_status (status_id,exam_user_id) VALUES (?,?)`;

     connection.query(
          insertQuery,
          [status_id, exam_user_id],
          (err, rows) => {
               if (err) throw err;
                const updateQuery = `UPDATE exam_user SET status = ? WHERE exam_id = ? and user_id = ?`;
                    connection.query(
                         updateQuery,
                         [status_id == 4 ?'failed':'passed',exam_id, user_id],
                         (err, rows) => {
                              if (err) throw err;
                              res.json(rows);
                         }
                    );
          }
          

     );
}
);
