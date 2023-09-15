

const bodyParser = require("body-parser") ;




const express = require("express");
const app = express();


app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));




const cors = require("cors"); // Import the cors package
// Add Access Control Allow Origin headers
const allowedOrigins = ['http://localhost:3000/','http://192.168.1.107:5173', 'http://localhost:5173'];
app.use(cors({
  origin: function (origin, callback) {
    if (!origin || allowedOrigins.includes(origin)) {
      callback(null, true);
    } else {
      callback(new Error('Not allowed by CORS'));
    }
  }
}));


// set up the connection to the database
const connection = require("./DataBaseConf/MySqlConnection");  
connection.connect(function (err) {
     if (err) throw err;
     console.log("Connected successfuly to MySql !");
});



//make the public folder available to the public
app.use('/public', express.static('public'));


app.use("/api/questions", require("./routers/questions.router"));
app.use("/api/users", require("./routers/users.router"));
app.use("/api/exams", require("./routers/exams.router"));

 




const PORT = process.env.SERVER_PORT || 3000;
app.listen(PORT, () => {
     console.log(`Server is running on PORT ${PORT}`);
});
