const router = require("express").Router();
const Wishlist = require("../models/Wishlist");
const verifyToken = require("../middleware/verifyToken");

// GET MY WISHLIST (AUTH)
router.get("/", verifyToken, async (req, res) => {
  try {
    const wishlist = await Wishlist.findOne({ userId: req.user.id }).populate("items");
    if (!wishlist) return res.status(200).json({ items: [] });
    res.status(200).json(wishlist);
  } catch (err) {
    res.status(500).json(err);
  }
});

// TOGGLE/ADD PRODUCT (AUTH)
router.post("/", verifyToken, async (req, res) => {
  try {
    const productId = req.body.productId;

    let wishlist = await Wishlist.findOne({ userId: req.user.id });

    if (!wishlist) {
      wishlist = new Wishlist({ userId: req.user.id, items: [productId] });
    } else {
      const exists = wishlist.items.some((id) => id.toString() === productId);
      if (exists) {
        wishlist.items = wishlist.items.filter((id) => id.toString() !== productId);
      } else {
        wishlist.items.push(productId);
      }
    }

    const saved = await wishlist.save();
    const populated = await saved.populate("items");
    res.status(200).json(populated);
  } catch (err) {
    res.status(500).json(err);
  }
});

// REMOVE PRODUCT (AUTH)
router.delete("/:productId", verifyToken, async (req, res) => {
  try {
    const wishlist = await Wishlist.findOne({ userId: req.user.id });
    if (!wishlist) return res.status(200).json({ items: [] });

    wishlist.items = wishlist.items.filter(
      (id) => id.toString() !== req.params.productId
    );

    const saved = await wishlist.save();
    const populated = await saved.populate("items");
    res.status(200).json(populated);
  } catch (err) {
    res.status(500).json(err);
  }
});

module.exports = router;
