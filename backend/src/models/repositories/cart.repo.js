const { BadRequestError } = require("../../core/error.response");
const { getSelectData, convertToObjectId } = require("../../utils");
const cartModel = require("../cart.model");

const addToCart = async ({ user, food }) => {
  const cart = await cartModel.findOne({ user, food });
  if (cart) {
    throw new BadRequestError("Food has added to cart already!");
  }
  return await cartModel.create({ user, food });
};

const getCart = async ({ user, select = [] }) => {
  const cart = await cartModel.aggregate([
    { $match: { user: convertToObjectId(user) } },
    {
      $lookup: {
        from: "Foods", // COLLECTION NAME REFERENCES TO
        localField: "food", //attr of cart
        foreignField: "_id", // attr of Foods
        as: "food", // set name
      },
    },
    { $unwind: "$food" }, // get first element of array food
    { $project: getSelectData(select) },
    {
      $group: {
        _id: "$food.store",
        foods: { $push: "$$ROOT" },
        numberOfFoods: { $sum: "$number" },
      },
    },
    {
      $lookup: {
        from: "Stores",
        localField: "_id",
        foreignField: "_id",
        as: "store",
      },
    },
    {
      $unwind: "$store",
    },
    {
      $project: { _id: 0 },
    },
  ]);
  return cart;
};

module.exports = {
  addToCart,
  getCart,
};
