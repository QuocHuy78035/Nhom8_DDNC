const { getSelectData, convertToObjectId } = require("../../utils");

const food = require("../food.model");

const findAllFoods = async ({ select = [], filter = {}, sort = "ctime" }) => {
  let sortBy = Object.fromEntries([sort].map((val) => [val, -1]));
  return await food
    .find(filter)
    .populate({ path: "store", select: { createdAt: 0, updatedAt: 0, __v: 0 } })
    .populate({
      path: "category",
      select: { createdAt: 0, updatedAt: 0, __v: 0 },
    })
    .select(getSelectData(select))
    .sort(sortBy);
};

const findFood = async ({ id, select = [] }) => {
  return await food.findById(id).select(getSelectData(select));
};

const findAllFoodsByCategory = async (categoryId) => {
  return await food.find({ category: convertToObjectId(categoryId) });
};

const createFood = async (data) => {
  return await food.create(data);
};

module.exports = { findAllFoods, findFood, createFood, findAllFoodsByCategory };
