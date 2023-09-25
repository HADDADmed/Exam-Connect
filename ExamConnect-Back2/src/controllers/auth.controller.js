const asyncHandler = require("express-async-handler");
const connection = require("../DataBaseConf/MySqlConnection");
const jwt = require("jsonwebtoken");

exports.login = asyncHandler(async (req, res, next) => {
     const email = req.body.email;
     const password = req.body.password;
     const selectQuery = "SELECT * FROM user WHERE email = ? AND password = ?";
     connection.query(selectQuery, [email, password], (err, rows) => {
          if (err) {
               console.log(err);
               res.status(500).json({ message: "Internal server error" });
          } else {
               if (rows.length > 0) {
                    const user = rows[0];
                    const accessToken = jwt.sign(
                         { id: user.id },
                         process.env.JWT_SECRET_KEY,
                         {
                              expiresIn: "24h",
                         }
                    );
                    res.status(200).json({
                         message: "login success",
                         user: {
                              fullName: user.fullName,
                              isAdmin: user.isAdmin,
                         },
                         accessToken: accessToken,
                    });
               } else {
                    res.status(401).json({ message: "Invalid Credentials !" });
               }
          }
     });
});
