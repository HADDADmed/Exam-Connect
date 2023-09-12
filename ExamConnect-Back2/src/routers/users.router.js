const express = require("express");

const router = express.Router();


const connection = require("../DataBaseConf/MySqlConnection");


router.get('/', (req, res) => {
    res.send('Hello World users!')
});



module.exports = router;  