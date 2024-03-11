"use strict";
const { Schema, model } = require("mongoose");
const COLLECTION_NAME = "Orders";
const DOCUMENT_NAME = "Order";

const orderSchema = new Schema(
  {
    user: { type: Schema.Types.ObjectId, ref: "User" },
    checkout: {
      type: {
        totalPrice: { type: Number, required: true, default: 0 },
        totalApplyDiscount: { type: Number, required: true, default: 0 },
        feeShip: { type: Number, required: true, default: 0 },
      },
      default: {},
    },
    shipping_address: { type: String, required: true },
    payment: { type: Object, default: {} }, // method,
    trackingNumber: { type: String, default: "#0000000000" },
    store: { type: Schema.Types.ObjectId, ref: "Store" },
    distance: { type: Number },
    foods: {
      type: [
        {
          food: { type: Schema.Types.ObjectId, ref: "Food" },
          quantity: { type: Number, required: true, default: 1 },
        },
      ],
      required: true,
    },
    status: {
      type: String,
      enum: [
        "pending",
        "confirmed",
        "new",
        "outgoing",
        "cancelled",
        "delivered",
      ],
      default: "pending",
    },
    note: { type: String },
    phone: { type: String },
  },
  { timestamps: true, collection: COLLECTION_NAME }
);

orderSchema.post("find", function (docs) {
  docs.forEach((doc) => {
    doc["distance"] = doc["distance"].toString();
  });
  return docs;
});

//Export the model
module.exports = model(DOCUMENT_NAME, orderSchema);
