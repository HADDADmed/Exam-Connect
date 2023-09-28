const express = require("express");
const bodyParser = require("body-parser");
const verifyAdmin = require("./middlewares/verifyAdmin");
const connection = require("./DataBaseConf/MySqlConnection");
const app = express();
const cors = require("cors"); // Import the cors package
const allowedOrigins = [
     "http://localhost:3000/",
     "http://192.168.1.106:5173",
     "http://localhost:5173",
     "http://localhost:5174",
];
const PORT = process.env.SERVER_PORT || 3000;

require("dotenv").config();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use("/public", express.static("public"));
app.use(
     cors({
          origin: function (origin, callback) {
                callback(null, true);
          },
     })
);

// check if the DataBase is connected successfully
connection.connect(function (err) {
     if (err) throw err;
     console.log("Connected successfuly to MySql !");
});

app.use("/api/questions", verifyAdmin, require("./routers/questions.router"));
app.use("/api/users", verifyAdmin, require("./routers/users.router"));
app.use("/api/exams", require("./routers/exams.router"));
app.use("/api/userAnswers", require("./routers/userAnswers.router"));
app.use("/api/auth", require("./routers/auth.router"));
//

//
app.listen(PORT, () => {
     console.log(`Server is running on PORT ${PORT}`);
});
