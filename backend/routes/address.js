const router = require("express").Router();
const Address = require("../models/Address");
const verifyToken = require("../middleware/verifyToken");

// GET MY ADDRESS (AUTH)
router.get("/", verifyToken, async (req, res) => {
  try {
    const address = await Address.findOne({ userId: req.user.id });
    res.status(200).json(address);
  } catch (err) {
    res.status(500).json(err);
  }
});

// UPDATE MY ADDRESS (AUTH)
router.put("/", verifyToken, async (req, res) => {
  try {
    const updated = await Address.findOneAndUpdate(
      { userId: req.user.id },
      { $set: { ...req.body, userId: req.user.id } },
      { new: true, upsert: true }
    );

    res.status(200).json(updated);
  } catch (err) {
    res.status(500).json(err);
  }
});

module.exports = router;
