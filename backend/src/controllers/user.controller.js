const { CREATED, OK } = require("../core/success.response");
const UserService = require("../services/user.service");

class UserController {
  addFoodToFavorite = async (req, res, next) => {
    const result = await UserService.addFoodToFavorite({
      userId: req.user.userId,
      food: req.body.food,
    });
    return new CREATED({
      message: "Add to favorite successfully!",
      metadata: result,
    }).send(res);
  };
  getFavoriteFoods = async (req, res, next) => {
    const result = await UserService.getFavoriteFoods({
      userId: req.user.userId,
    });
    return new OK({
      message: "Get favorite foods successfully!",
      metadata: result,
    }).send(res);
  };
  deleteFavoriteFood = async (req, res, next) => {
    await UserService.deleteFavoriteFood({
      userId: req.user.userId,
      food: req.params.food,
    });
    return new OK({
      message: "Delete favorite foods successfully!",
    }).send(res);
  };
  checkFoodIsFavorite = async (req, res, next) => {
    const result = await UserService.checkFoodIsFavorite({
      userId: req.user.userId,
      food: req.params.food,
    });
    return new OK({
      message: "Check food is favorite successfully!",
      metadata: { result },
    }).send(res);
  };

  addStoreToFavorite = async (req, res, next) => {
    const result = await UserService.addStoreToFavorite({
      userId: req.user.userId,
      store: req.body.store,
    });
    return new CREATED({
      message: "Add to favorite successfully!",
      metadata: result,
    }).send(res);
  };
  getFavoriteStores = async (req, res, next) => {
    const result = await UserService.getFavoriteStores({
      userId: req.user.userId,
    });
    return new OK({
      message: "Get favorite foods successfully!",
      metadata: result,
    }).send(res);
  };
  deleteFavoriteStore = async (req, res, next) => {
    await UserService.deleteFavoriteStore({
      userId: req.user.userId,
      store: req.params.store,
    });
    return new OK({
      message: "Delete favorite stores successfully!",
    }).send(res);
  };
  checkStoreIsFavorite = async (req, res, next) => {
    const result = await UserService.checkStoreIsFavorite({
      userId: req.user.userId,
      store: req.params.store,
    });
    return new OK({
      message: "Check store is favorite successfully!",
      metadata: { result },
    }).send(res);
  };
}

module.exports = new UserController();
