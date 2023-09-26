const asyncHandler = require('express-async-handler');
const connection = require('../DataBaseConf/MySqlConnection');





exports.getAllUsers = asyncHandler(async  (req, res,next) => {

     const selectQuery = "SELECT * FROM user";
     connection.query(selectQuery, (err, rows) => {
         if (err) throw err;
         res.json(rows);
     });
});


exports.createUser = asyncHandler(async (req, res,next) => {
     const user = req.body;

     const fullName = user.fullName;
     const email = user.email;
     const password = user.password;
     const insertQuery = "INSERT INTO user (fullName, email, password) VALUES (?,?,?)";
     connection.query(insertQuery, [fullName, email, password], (err, rows) => {
         if (err) throw err;
         res.json(rows);
     });
 }
 );

 
exports.deleteUser = asyncHandler(async  (req, res,next) => {
     const id = req.params.id;
     const deleteQuery = "DELETE FROM user WHERE id = ?";
     connection.query(deleteQuery, [id], (err, rows) => {
         if (err) throw err;
         res.json(rows);
     });
 });


