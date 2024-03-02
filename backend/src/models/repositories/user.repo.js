const { BadRequestError } = require("../../core/error.response");
const { getUnselectData, convertToObjectId } = require("../../utils");
const userModel = require("../user.model");

const addFoodToFavorite = async ({ userId, food }) => {
  const user = await userModel.findById(userId);
  if (user.favoriteFoods.includes(food)) {
    throw new BadRequestError("This food is already in your favorite list.");
  }
  return await userModel.findByIdAndUpdate(
    userId,
    {
      $addToSet: { favoriteFoods: convertToObjectId(food) },
    },
    { new: true }
  );
};

const getFavoriteFoods = async ({ userId }) => {
  const user = await userModel
    .findById(userId)
    .populate("favoriteFoods")
    .lean();
  return user.favoriteFoods;
};

const deleteFavoriteFood = async ({ userId, food }) => {
  const user = await userModel.findById(userId);
  if (!user.favoriteFoods.includes(food)) {
    throw new BadRequestError("This food is not in your favorite list!");
  }
  return await userModel.findByIdAndUpdate(userId, {
    $pull: { favoriteFoods: convertToObjectId(food) },
  });
};

const checkFoodIsFavorite = async ({ userId, food }) => {
  const user = await userModel.findById(userId);
  return user.favoriteFoods.includes(food);
};

const addStoreToFavorite = async ({ userId, store }) => {
  const user = await userModel.findById(userId);
  if (user.favoriteStores.includes(store)) {
    throw new BadRequestError("This food is already in your favorite list.");
  }
  return await userModel.findByIdAndUpdate(
    userId,
    {
      $addToSet: { favoriteStores: convertToObjectId(store) },
    },
    { new: true }
  );
};

const getFavoriteStores = async ({ userId }) => {
  const user = await userModel.findById(userId).populate("favoriteStores").lean();
  return user.favoriteStores;
};

const deleteFavoriteStore = async ({ userId, store }) => {
  const user = await userModel.findById(userId);
  if (!user.favoriteStores.includes(store)) {
    throw new BadRequestError("This food is not in your favorite list!");
  }
  return await userModel.findByIdAndUpdate(userId, {
    $pull: { favoriteStores: convertToObjectId(store) },
  });
};

const checkStoreIsFavorite = async ({ userId, store }) => {
  const user = await userModel.findById(userId);
  return user.favoriteStores.includes(store);
};

module.exports = {
  addFoodToFavorite,
  getFavoriteFoods,
  deleteFavoriteFood,
  checkFoodIsFavorite,
  addStoreToFavorite,
  getFavoriteStores,
  deleteFavoriteStore,
  checkStoreIsFavorite,
};
