"use strict";
const mongoose = require("mongoose");
const COLLECTION_NAME = "Carts";
const DOCUMENT_NAME = "Cart";

const cartSchema = new mongoose.Schema(
  {
    user: { type: Schema.Types.ObjectId, ref: "User" },
    shop: { type: Schema.Types.ObjectId, ref: "Shop" },
    number: { type: Number, default: 1 },
  },
  { timestamps: true, collection: COLLECTION_NAME }
);

//Export the model
module.exports = mongoose.model(DOCUMENT_NAME, cartSchema);
