const {
  BadRequestError,
  AuthFailureError,
} = require("../../core/error.response");
const { convertToObjectId } = require("../../utils");
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
  const user = await userModel
    .findById(userId)
    .populate("favoriteStores")
    .lean();
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
  if (!user) {
    throw new BadRequestError(`User with id ${userId} does not exit!`);
  }
  return user.favoriteStores.includes(store);
};

const getAllPendingVendors = async () => {
  return await userModel.find({
    role: "vendor",
    status: "pending",
  });
};

const changeStatusOfUser = async ({ userId, status }) => {
  const changedStatuses = ["inactive", "active"];
  if (!changedStatuses.includes(status)) {
    throw new BadRequestError(
      "Admin just change status to inactive or active!"
    );
  }
  const user = await userModel.findById(userId);
  if (!user) {
    throw new BadRequestError(`User with id ${userId} does not exist!`);
  }
  if (user.status === status) {
    throw new BadRequestError(`Account has already been ${status}`);
  }
  if (status === "inactive") {
    if (user.status !== "active") {
      throw new BadRequestError(
        "Can't inactive the account because it is not active!"
      );
    }
    return await userModel.findByIdAndUpdate(userId, { status: "inactive" });
  } else if (status === "active") {
    if (user.role === "vendor") {
      if (user.status !== "pending") {
        throw new BadRequestError(
          "Can't inactive the account because it is unverified!"
        );
      }
      return await userModel.findByIdAndUpdate(
        userId,
        { status: "active" },
        { new: true }
      );
    } else
      throw new AuthFailureError(
        "Admin does not have permission to active user account!"
      );
  }
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
  getAllPendingVendors,
  changeStatusOfUser,
};
