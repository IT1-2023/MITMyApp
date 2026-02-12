const router = require("express").Router();
const Order = require("../models/Order");
const verifyToken = require("../middleware/verifyToken");
const verifyAdmin = require("../middleware/verifyAdmin");



// CREATE PAYMENT INTENT (AUTH)
router.post("/payment-intent", verifyToken, async (req, res) => {
  try {
    
    const amount = Number(req.body.amount);
    const currency = (req.body.currency || "usd").toString().toLowerCase();

    if (!amount || amount <= 0 || !Number.isInteger(amount)) {
      return res
        .status(400)
        .json({ message: "amount must be a positive integer in cents" });
    }

    const paymentIntent = await stripe.paymentIntents.create({
      amount,
      currency,
      automatic_payment_methods: { enabled: true },
      metadata: {
        userId: req.user.id,
      },
    });

    return res.status(200).json({
      clientSecret: paymentIntent.client_secret,
    });
  } catch (err) {
    return res.status(500).json(err);
  }
});

// CREATE ORDER (AUTH)
router.post("/", verifyToken, async (req, res) => {
  try {
    const order = new Order({
      userId: req.user.id,
      customerName: req.body.customerName,
      items: req.body.items,
      totalPrice: req.body.totalPrice,
      status: req.body.status || "Pending",
      date: req.body.date || Date.now(),
    });

    const saved = await order.save();
    res.status(201).json(saved);
  } catch (err) {
    res.status(500).json(err);
  }
});

// GET MY ORDERS (AUTH)
router.get("/my", verifyToken, async (req, res) => {
  try {
    const orders = await Order.find({ userId: req.user.id }).sort({ createdAt: -1 });
    res.status(200).json(orders);
  } catch (err) {
    res.status(500).json(err);
  }
});

// GET ALL ORDERS (ADMIN)
router.get("/", verifyToken, verifyAdmin, async (req, res) => {
  try {
    const orders = await Order.find().sort({ createdAt: -1 });
    res.status(200).json(orders);
  } catch (err) {
    res.status(500).json(err);
  }
});

// UPDATE STATUS (ADMIN)
router.put("/:id/status", verifyToken, verifyAdmin, async (req, res) => {
  try {
    const updated = await Order.findByIdAndUpdate(
      req.params.id,
      { $set: { status: req.body.status } },
      { new: true }
    );
    res.status(200).json(updated);
  } catch (err) {
    res.status(500).json(err);
  }
});

module.exports = router;
