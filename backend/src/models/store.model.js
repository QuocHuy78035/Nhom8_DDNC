"use strict";
const mongoose = require("mongoose");
const COLLECTION_NAME = "Stores";
const DOCUMENT_NAME = "Store";

const storeSchema = new mongoose.Schema(
  {
    name: { type: String },
    image: { type: String, default: "" },
    address: { type: String },
    rating: {
      type: Number,
      min: [1, "Rating must be above or equal 1"],
      max: [5, "Rating must be below or equal 5"],
      default: 3,
    },
    time_open: { type: String },
    time_close: { type: String },
  },
  { timestamps: true, collection: COLLECTION_NAME }
);

//Export the model
module.exports = mongoose.model(DOCUMENT_NAME, storeSchema);
