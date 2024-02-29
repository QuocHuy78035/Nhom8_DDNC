"use strict";
const { Schema, model } = require("mongoose");
const COLLECTION_NAME = "Comments";
const DOCUMENT_NAME = "Comment";

const commentSchema = new Schema(
  {
    user: { type: Schema.Types.ObjectId, ref: "User", required: true },
    store: { type: Schema.Types.ObjectId, ref: "Store", required: true },
    food: { type: Schema.Types.ObjectId, ref: "Food", required: true },
    comment: { type: String, required: true },
    rating: {
      type: Number,
      min: [1, "Rating must be above or equal 1"],
      max: [5, "Rating must be below or equal 5"],
      default: 1,
    },
    numberOfLikes: { type: Number, default: 0 },
    imageURL: [{ type: String, default: "default.png" }],
  },
  { timestamps: true, collection: COLLECTION_NAME }
);

//Export the model
module.exports = model(DOCUMENT_NAME, commentSchema);
