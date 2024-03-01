const {
  getSelectData,
  convertToObjectId,
  getUnselectData,
  removeUndefinedInObject,
} = require("../../utils");

const food = require("../food.model");

const findAllFoods = async ({
  unselect = [],
  filter = {},
  sort = "createdAt",
  search,
}) => {
  let sortBy = Object.fromEntries([sort].map((val) => [val, -1]));
  return await food
    .find(
      removeUndefinedInObject({
        ...filter,
        name: { $regex: search ? search : "", $options: "i" },
      })
    )
    .populate({ path: "store", select: { createdAt: 0, updatedAt: 0, __v: 0 } })
    .populate({
      path: "category",
      select: { createdAt: 0, updatedAt: 0, __v: 0 },
    })
    .select(getUnselectData(unselect))
    .sort(sortBy)
    .lean();
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
