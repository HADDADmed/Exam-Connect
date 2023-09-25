const jwt = require("jsonwebtoken");
const connection = require("../DataBaseConf/MySqlConnection");

// create a middleware function to verify the admin

const verifyAdmin = (req, res, next) => {
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
                                            if (req.user.isAdmin) {
                                                next();
                                            } else {
                                                res.status(401).json({
                                                    message: "Unauthorized",
                                                });
                                            }
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
    }

module.exports = verifyAdmin;