
const express = require("express");
const router = express.Router();
const connection = require("./middleware/mysqlConfig");



const multer = require("multer");

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "public/images");
  },
  filename: (req, file, cb) => {
    const uniqueSuffix = Date.now() + "-" + Math.round(Math.random() * 1e9);
    cb(null, uniqueSuffix + "-" + file.originalname);
  },
});



const upload = multer({ storage: storage });


router.post("/addQuestion", upload.single("image"), (req, res) => {
    const { question, answer, option1, option2, option3, option4 } = req.body;
    const image = req.file.filename;
    const sql = `INSERT INTO questions (question,answer,option1,option2,option3,option4,image) VALUES (?,?,?,?,?,?,?)`;
    connection.query(
        sql,
        [question, answer, option1, option2, option3, option4, image],
        (err, result) => {
        if (err) throw err;
        res.status(200).json({ message: "Question added successfully" });
        }
    );
});