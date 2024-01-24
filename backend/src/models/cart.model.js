"use strict";
const { Schema, model } = require("mongoose");
const COLLECTION_NAME = "Carts";
const DOCUMENT_NAME = "Cart";

const cartSchema = new Schema(
  {
    user: { type: Schema.Types.ObjectId, ref: "User", required: true },
    food: { type: Schema.Types.ObjectId, ref: "Food", required: true },
    number: { type: Number, required: true, default: 1 },
  },
  { timestamps: true, collection: COLLECTION_NAME }
);

//Export the model
module.exports = model(DOCUMENT_NAME, cartSchema);
