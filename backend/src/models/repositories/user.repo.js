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
  const user = await userModel.findById(userId).populate("favoriteFoods");
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

module.exports = {
  addFoodToFavorite,
  getFavoriteFoods,
  deleteFavoriteFood,
  checkFoodIsFavorite,
};
