const express = require("express");
const router = express.Router();
const verifyToken = require("../middlewares/verifyToken");
const userAnswers_controller = require("../controllers/userAnswers.controller");
//

router.get("/", userAnswers_controller.getAllUserAnswers);
router.post("/", verifyToken, userAnswers_controller.createUserAnswer);
router.get(
     "/user/:user_id/exam/:exam_id",
     userAnswers_controller.getUserAnswerByUserIdAndExamId
);

//
module.exports = router;
