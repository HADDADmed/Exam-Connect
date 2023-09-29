const express = require("express");
const router = express.Router();



const dashboard_controller = require("../controllers/dashboard.controller");
//


router.get('/exams', dashboard_controller.getExamsStatistics);
// router.get('/users', dashboard_controller.getUsersStatistics);
router.get('/questions', dashboard_controller.getQuestionsStatistics);

//
module.exports = router;