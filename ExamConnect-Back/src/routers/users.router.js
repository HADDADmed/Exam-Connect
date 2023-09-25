const express = require("express");
const router = express.Router();
const users_controller = require("../controllers/users.controller");
//

router.get("/", users_controller.getAllUsers);
router.post("/", users_controller.createUser);
router.delete("/:id", users_controller.deleteUser);

//
module.exports = router;
