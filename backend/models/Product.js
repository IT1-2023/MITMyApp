const mongoose = require("mongoose");

const ProductSchema = new mongoose.Schema({

  name: {
    type: String,
    required: true
  },

  description: {
    type: String,
    required: true
  },

  price: {
    type: Number,
    required: true
  },

  imageUrl: {
    type: String
  },

  category: {
    type: String
  },
  rating: {
    type: Number,
    default: 0
  },

  ratingCount: {
    type: Number,
    default: 0
  },


  inStock: {
    type: Boolean,
    default: true
  }

}, { timestamps: true });

module.exports = mongoose.model("Product", ProductSchema);
