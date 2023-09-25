const express = require("express");
const router = express.Router();
const multer = require("multer");
const path = require("path"); // Import the 'path' module
const questions_controller = require("../controllers/questions.controller");

// Multer storage configuration
const storage = multer.diskStorage({
     destination: (req, file, cb) => {
          cb(null, "public/images/"); // Save to the 'public/images' directory
     },
     filename: (req, file, cb) => {
          const date = new Date(Date.now());
          const ext = path.extname(file.originalname);
          var formatedDate = `${date.getDate()}-${date.getMonth()}-${date.getFullYear()}`;
          const uniqueSuffix =
               Math.round(Math.random() * 1e9) + "-" + formatedDate;
          cb(null, uniqueSuffix + ext);
     },
});

// Create a Multer instance with the storage configuration
const upload = multer({ storage });

const uploadVariant = upload.fields([
     { name: "image", maxCount: 1 },
     { name: "isTrue", maxCount: 1 },
     { name: "qstId", maxCount: 1 },
]);
//


router.get("/", questions_controller.getAllQuestions);
router.post("/", questions_controller.createQuestion);
router.post("/img", uploadVariant, questions_controller.uploadOptionAsImage);
router.get("/ids", questions_controller.getAllIdsAndTypes);
router.delete("/:id", questions_controller.deleteQuestion);
router.get("/counts", questions_controller.getQuestionsCountByType);


//
module.exports = router; // Export the router
