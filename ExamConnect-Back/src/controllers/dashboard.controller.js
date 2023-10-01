const asyncHandler = require("express-async-handler");
const connection = require("../DataBaseConf/MySqlConnection");




exports.getExamsStatistics = asyncHandler(async (req, res, next) => {

    const selectQuery = `
    SELECT
    id as user_exam_id,
    exam_id,
    createdAt as user_exam_created_at ,
    status as user_exam_status,
    (SELECT COUNT(*) FROM exam ) as total_exams
    FROM exam_user ;
    `
    connection.query(selectQuery, (err, rows) => {
        if (err) {
            console.log(err);
            res.status(500).json({ message: "Internal server error" });
        } else {

                res.status(200).json({
                    message: "Exams statistics fetched successfully",
                    user_exams: rows,
                });


        }
    });
}
);


exports.getQuestionsStatistics = asyncHandler(async (req, res, next) => {
    const selectQuery = ` SELECT
    (SELECT COUNT(*) FROM question ) as total_questions,
    (SELECT COUNT(*) FROM question WHERE isQcm = 0) as textQuestions,
    (SELECT COUNT(*) FROM question WHERE isQcm = 1) as qcmQuestions,
    (SELECT COUNT(*) FROM question WHERE isQcm = 2) as imgQuestions
    FROM question ;`
    connection.query(selectQuery, (err, rows) => {
        if (err) {
            console.log(err);
            res.status(500).json({ message: "Internal server error" });
        } else {
            res.status(200).json({
                message: "Questions statistics fetched successfully",
                questionsStatistics: rows[0],
            });
        }
    });
}
);

exports.getUsersStatistics = asyncHandler(async (req, res, next) => {
     const selectQuery = `
     SELECT
     id,
     fullName,
     email,
     createdAt,
     password,
     (SELECT COUNT(*) From exam_user WHERE user_id = user.id) as total_user_exams
     From user;
     `
     connection.query(selectQuery, (err, rows) => {
          if (err) {
               console.log(err);
               res.status(500).json({ message: "Internal server error" });
          } else {
               res.status(200).json({
                    message: "Users statistics fetched successfully",
                    users: rows,
               });
          }
     });
}
);






