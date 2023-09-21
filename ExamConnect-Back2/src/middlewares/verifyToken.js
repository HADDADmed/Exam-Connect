const jwt = require("jsonwebtoken");
const connection = require("../DataBaseConf/MySqlConnection");



const verifyToken = (req, res, next) => {
    if (
         req.headers.authorization &&
         req.headers.authorization.split(" ")[0] === "JWT"
    ) {
         jwt.verify(
              req.headers.authorization.split(" ")[1],
               process.env.JWT_SECRET_KEY,
              (err, decoded) => {
                   if (err) {
                        res.status(401).json({ message: "Unauthorized" });
                   } else {
                        const selectQuery = "SELECT * FROM user WHERE id = ?";
                        connection.query(
                             selectQuery,
                             [decoded.id],
                             (err, results) => {
                                  if (err) {
                                       res.status(500).json({
                                            message: "Internal Server Error",
                                       });
                                       return;
                                  }
                                  if (results.length === 1) {
                                       req.user = results[0];
                                       next();
                                  } else {
                                       res.status(401).json({
                                            message: "Unauthorized",
                                       });
                                  }
                             }
                        );
                   }
              }
         );
    } else {
         res.status(401).json({ message: "Unauthorized" });
    }
};



module.exports = verifyToken;
