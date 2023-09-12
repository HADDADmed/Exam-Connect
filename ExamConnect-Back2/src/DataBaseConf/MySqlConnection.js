
var mysql = require('mysql');


var connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "ExamConnect"
});


module.exports = connection;
