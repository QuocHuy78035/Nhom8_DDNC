"use strict";
const mongoose = require("mongoose");
const COLLECTION_NAME = "Orders";
const DOCUMENT_NAME = "Order";

const orderSchema = new mongoose.Schema(
  {
    user: { type: Schema.Types.ObjectId, ref: "User" },
    shop: { type: Schema.Types.ObjectId, ref: "Shop" },
    rating: {
      type: Number,
      min: [1, "Rating must be above or equal 1"],
      max: [5, "Rating must be below or equal 5"],
      default: 3,
    },
    dateBuy: { type: Date, required: true },
  },
  { timestamps: true, collection: COLLECTION_NAME }
);

//Export the model
module.exports = mongoose.model(DOCUMENT_NAME, orderSchema);
