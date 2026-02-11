const path = require("path");
require("dotenv").config();
const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

const app = express();

app.use(cors());
app.use(express.json());

// Serve uploaded product images.
app.use("/uploads", express.static(path.join(__dirname, "uploads")));

const authRoute = require("./routes/auth");
app.use("/api/auth", authRoute);

const productRoute = require("./routes/product");
app.use("/api/products", productRoute);

const orderRoute = require("./routes/order");
app.use("/api/orders", orderRoute);

const addressRoute = require("./routes/address");
app.use("/api/address", addressRoute);

const wishlistRoute = require("./routes/wishlist");
app.use("/api/wishlist", wishlistRoute);

mongoose
  .connect(process.env.MONGO_URI)
  .then(() => console.log(" MongoDB connected"))
  .catch((err) => console.log(err));

app.get("/", (req, res) => {
  res.send("API is running...");
});

const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
  console.log("Server running on port " + PORT);
});
