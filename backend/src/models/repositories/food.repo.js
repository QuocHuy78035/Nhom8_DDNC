const {
  getSelectData,
  convertToObjectId,
  getUnselectData,
  removeUndefinedInObject,
} = require("../../utils");
const UploadFiles = require("../../utils/uploadFile");

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

const createFood = async ({ name, category, store, price, left }, file) => {
  const image = await new UploadFiles(
    "foods",
    "image",
    file
  ).uploadFileAndDownloadURL();
  return await food.create({ name, image, category, store, price, left });
};

module.exports = { findAllFoods, findFood, createFood, findAllFoodsByCategory };
