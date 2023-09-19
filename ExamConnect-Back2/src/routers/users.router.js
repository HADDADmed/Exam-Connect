const express = require("express");

const router = express.Router();


const connection = require("../DataBaseConf/MySqlConnection");


router.get('/', (req, res) => {
    
        const selectQuery = "SELECT * FROM user";
        connection.query(selectQuery, (err, rows) => {
            if (err) throw err;
            res.json(rows);
        });  
});

router.post('/', (req, res) => {
    const user = req.body;  

    const fullName = user.fullName;
    const email = user.email;
    const password = user.password;

    const insertQuery = "INSERT INTO user (fullName, email, password) VALUES (?,?,?)";
    connection.query(insertQuery, [fullName, email, password], (err, rows) => {
        if (err) throw err;
        res.json(rows);
    });
}
);

router.delete('/:id', (req, res) => {
    const id = req.params.id;
    const deleteQuery = "DELETE FROM user WHERE id = ?";
    connection.query(deleteQuery, [id], (err, rows) => {
        if (err) throw err;
        res.json(rows);
    });
});

 
module.exports = router;  