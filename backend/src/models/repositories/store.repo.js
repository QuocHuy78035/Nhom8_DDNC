const { BadRequestError } = require("../../core/error.response");
const {
  getSelectData,
  getUnselectData,
  convertToObjectId,
  getDistanceFromLatLonInKm,
} = require("../../utils");
const UploadFiles = require("../../utils/uploadFile");
const storeModel = require("../store.model");

const findAllStores = async ({
  sort = "createdAt",
  categoriesId,
  search,
  unselect = [],
  coordinate, // long,lat
}) => {
  const [long, lat] = coordinate.split(",");
  if (!long || !lat) {
    throw new BadRequestError("Longtitude or latitude must be provided!");
  }
  let sortBy = Object.fromEntries([sort].map((val) => [val, -1]));
  let stores = await storeModel.aggregate([
    { $match: { name: { $regex: search || "", $options: "i" } } },
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
      $sort: sortBy,
    },
    {
      $project: { foods: 0, ...getUnselectData(unselect) },
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
  stores.forEach((store) => {
    store["distance"] = getDistanceFromLatLonInKm(
      lat,
      long,
      store["latitude"],
      store["longtitude"]
    ).toFixed(1);
  });
  return stores;
};

const findTop10RatingStores = async ({ unselect = [] }) => {
  return await storeModel
    .find({ rating: { $gt: 4.5 } })
    .limit(10)
    .select(getUnselectData(unselect));
};

const findStore = async ({
  id,
  unselect = [],
  coordinate, // long,lat
}) => {
  const [long, lat] = coordinate.split(",");
  if (!long || !lat) {
    throw new BadRequestError("Longtitude or latitude must be provided!");
  }
  const store = await storeModel
    .findById(id)
    .select(getUnselectData(unselect))
    .lean();
  store["distance"] = getDistanceFromLatLonInKm(
    lat,
    long,
    store["latitude"],
    store["longtitude"]
  ).toFixed(1);
  return store;
};
const createStore = async (
  { name, address, time_open, time_close, rating, longtitude, latitude },
  file
) => {
  const image = await new UploadFiles(
    "stores",
    "image",
    file
  ).uploadFileAndDownloadURL();
  return await storeModel.create({
    name,
    image,
    address,
    time_open,
    time_close,
    rating,
    longtitude,
    latitude,
  });
};

module.exports = {
  findAllStores,
  findStore,
  createStore,
  findTop10RatingStores,
};
