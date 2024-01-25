const {
  getSelectData,
  getUnselectData,
  convertToObjectId,
} = require("../../utils");
const storeModel = require("../store.model");

const findAllStores = async ({
  sort = "ctime",
  categoriesId,
  search,
  unselect = [],
}) => {
  let sortBy = Object.fromEntries([sort].map((val) => [val, -1]));
  let stores = await storeModel.aggregate([
    { $match: { name: { $regex: search || "" } } },
    {
      $lookup: {
        from: "Foods",
        localField: "_id",
        foreignField: "store",
        as: "foods",
      },
    },
    {
      $lookup: {
        from: "Categories",
        localField: "foods.category",
        foreignField: "_id",
        as: "categories",
      },
    },
    {
      $project: { foods: 0, ...getUnselectData(unselect) },
    },
    {
      $sort: sortBy,
    },
  ]);
  if (categoriesId) {
    stores = stores.filter((store) => {
      const categoriesStore = store.categories.map((category) =>
        category._id.toString()
      );
      return categoriesId
        .split(",")
        .every((category) => categoriesStore.includes(category));
    });
  }
  return stores;
};

const findTop10RatingStores = async ({ unselect = [] }) => {
  return await storeModel
    .find({ rating: { $gt: 4.5 } })
    .limit(10)
    .select(getUnselectData(unselect));
};

const findStore = async ({ id, unselect = [] }) => {
  return await storeModel.findById(id).select(getUnselectData(unselect));
};
const createStore = async (data) => {
  return await storeModel.create(data);
};

module.exports = {
  findAllStores,
  findStore,
  createStore,
  findTop10RatingStores,
};
