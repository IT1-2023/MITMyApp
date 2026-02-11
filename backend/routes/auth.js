const router = require("express").Router();
const User = require("../models/user");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const verifyToken = require("../middleware/verifyToken");
const verifyAdmin = require("../middleware/verifyAdmin");

console.log("AUTH ROUTE LOADED");

const ADMIN_EMAIL = (
  process.env.ADMIN_EMAIL || "admin@admin.com"
).trim().toLowerCase();

function normalizeEmail(email) {
  return String(email || "").trim().toLowerCase();
}

//  REGISTER 
router.post("/register", async (req, res) => {
  try {
    const email = normalizeEmail(req.body.email);
    if (!email) {
      return res.status(400).json("Email is required");
    }

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json("Email already in use");
    }

    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(req.body.password, salt);

    const user = new User({
      name: req.body.name,
      email,
      password: hashedPassword,
      isAdmin: email === ADMIN_EMAIL,
    });

    await user.save();

    res.status(201).json("User created successfully");
  } catch (err) {
    if (err && err.code === 11000) {
      return res.status(400).json("Email already in use");
    }
    res.status(500).json(err);
  }
});

// LOGIN 
router.post("/login", async (req, res) => {
  try {
    const email = normalizeEmail(req.body.email);

    const user = await User.findOne({ email });
    if (!user) {
      return res.status(404).json("User not found");
    }

    const validPassword = await bcrypt.compare(req.body.password, user.password);
    if (!validPassword) {
      return res.status(400).json("Wrong password");
    }

    const token = jwt.sign(
      {
        id: user._id,
        isAdmin: user.isAdmin,
      },
      process.env.JWT_SECRET,
      { expiresIn: "7d" }
    );

    const { password, ...userData } = user._doc;

    res.status(200).json({
      ...userData,
      token,
    });
  } catch (err) {
    res.status(500).json(err);
  }
});

//  ME 
router.get("/me", verifyToken, async (req, res) => {
  try {
    const user = await User.findById(req.user.id).select("-password");
    res.status(200).json(user);
  } catch (err) {
    res.status(500).json(err);
  }
});

// ---- admin
router.get("/admin-test", verifyToken, verifyAdmin, (req, res) => {
  res.status(200).json("ADMIN ACCESS GRANTED");
});

module.exports = router;
