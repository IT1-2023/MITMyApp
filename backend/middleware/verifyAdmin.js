const verifyToken = require("./verifyToken");

const verifyAdmin = (req, res, next) => {
  if (!req.user) {
    return res.status(401).json("You are not authenticated");
  }

  if (!req.user.isAdmin) {
    return res.status(403).json("You are not allowed (admin only)");
  }

  next();
};

module.exports = verifyAdmin;

