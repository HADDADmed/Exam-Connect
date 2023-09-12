const express = require("express");
const router = express.Router();
 









// Define your route on the router object
router.get('/', (req, res) => {
    res.send('Hello World!')
});







module.exports = router; // Export the router