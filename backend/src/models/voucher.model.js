"use strict";
const {Schema, model} = require("mongoose");
const COLLECTION_NAME = "Vouchers";
const DOCUMENT_NAME = "Voucher";

const voucherSchema = new Schema(
  {
    price: { type: Number, required: true },
    minimumPayment: { type: Number, required: true },
    expiresAt: { type: Date, required: true },
    image: { type: String },
    description: { type: String },
  },
  { timestamps: true, collection: COLLECTION_NAME }
);

//Export the model
module.exports = model(DOCUMENT_NAME, voucherSchema);
