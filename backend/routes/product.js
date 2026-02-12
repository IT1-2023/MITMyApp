const router = require("express").Router();
const fs = require("fs");
const path = require("path");
const multer = require("multer");
const Product = require("../models/Product");
const verifyToken = require("../middleware/verifyToken");
const verifyAdmin = require("../middleware/verifyAdmin");

const uploadDir = path.join(__dirname, "..", "uploads");
if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir, { recursive: true });
}

const storage = multer.diskStorage({
  destination: (_, __, cb) => cb(null, uploadDir),
  filename: (_, file, cb) => {
    const ext = path.extname(file.originalname || "");
    const base = path
      .basename(file.originalname || "image", ext)
      .replace(/[^a-zA-Z0-9_-]/g, "_");
    cb(null, `${Date.now()}_${base}${ext || ".jpg"}`);
  },
});

const upload = multer({ storage });

// UPLOAD PRODUCT IMAGE (ADMIN ONLY)
router.post(
  "/upload",
  verifyToken,
  verifyAdmin,
  upload.single("image"),
  async (req, res) => {
    try {
      if (!req.file) {
        return res.status(400).json({ message: "Image file is required" });
      }

      return res.status(200).json({
        imageUrl: `/uploads/${req.file.filename}`,
      });
    } catch (err) {
      return res.status(500).json(err);
    }
  }
);

// CREATE PRODUCT (ADMIN ONLY)
router.post("/", verifyToken, verifyAdmin, async (req, res) => {
  try {
    const product = new Product(req.body);
    await product.save();

    res.status(201).json(product);
  } catch (err) {
    res.status(500).json(err);
  }
});

// RATE PRODUCT (AUTH)
router.post("/:id/rate", verifyToken, async (req, res) => {
  try {
    const rating = Number(req.body.rating);
    if (!rating || rating < 1 || rating > 5) {
      return res.status(400).json("Rating must be between 1 and 5");
    }

    const product = await Product.findById(req.params.id);
    if (!product) {
      return res.status(404).json("Product not found");
    }

    const count = product.ratingCount || 0;
    const avg = product.rating || 0;

    const newCount = count + 1;
    const newAvg = (avg * count + rating) / newCount;

    product.rating = Number(newAvg.toFixed(2));
    product.ratingCount = newCount;

    await product.save();
    res.status(200).json(product);
  } catch (err) {
    res.status(500).json(err);
  }
});

router.put("/:id", verifyToken, verifyAdmin, async (req, res) => {
  try {
    const updated = await Product.findByIdAndUpdate(
      req.params.id,
      { $set: req.body },
      { new: true }
    );
    res.status(200).json(updated);
  } catch (err) {
    res.status(500).json(err);
  }
});

// GET ALL PRODUCTS (PUBLIC)
router.get("/", async (req, res) => {
  try {
    const products = await Product.find();
    res.status(200).json(products);
  } catch (err) {
    res.status(500).json(err);
  }
});

router.get("/:id", async (req, res) => {
  try {
    const product = await Product.findById(req.params.id);
    res.status(200).json(product);
  } catch (err) {
    res.status(500).json(err);
  }
});

// DELETE PRODUCT (ADMIN)
router.delete("/:id", verifyToken, verifyAdmin, async (req, res) => {
  try {
    await Product.findByIdAndDelete(req.params.id);
    res.status(200).json("Product deleted");
  } catch (err) {
    res.status(500).json(err);
  }
});

module.exports = router;
