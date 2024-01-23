"use strict";
const mongoose = require("mongoose");
const COLLECTION_NAME = "Vouchers";
const DOCUMENT_NAME = "Voucher";

const cartSchema = new mongoose.Schema(
  {
    price: { type: Number, required: true },
    minimumPrice: { type: Number, required: true },
    expiresAt: { type: Date },
  },
  { timestamps: true, collection: COLLECTION_NAME }
);

//Export the model
module.exports = mongoose.model(DOCUMENT_NAME, cartSchema);
