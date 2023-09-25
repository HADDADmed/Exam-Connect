const express = require("express");
const router = express.Router();
const verifyToken = require("../middlewares/verifyToken");
const verifyAdmin = require("../middlewares/verifyAdmin");
const exams_controller = require("../controllers/exams.controller");
//

router.get("/", verifyAdmin, exams_controller.getAllExams);
router.post("/", verifyAdmin, exams_controller.createExam);
router.get("/exam/:id", verifyToken, exams_controller.getExamById);
router.get(
     "/checkAuth/:id",
     verifyToken,
     exams_controller.checkAuthorizationToExam
);
router.get(
     "/userexamStatus/:id",
     verifyToken,
     exams_controller.changeUserExamStatus
);

//
module.exports = router;
