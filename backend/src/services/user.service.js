const {
  addFoodToFavorite,
  getFavoriteFoods,
  deleteFavoriteFood,
  checkFoodIsFavorite,
  addStoreToFavorite,
  getFavoriteStores,
  deleteFavoriteStore,
  checkStoreIsFavorite,
} = require("../models/repositories/user.repo");

class UserService {
  static async addFoodToFavorite({ userId, food }) {
    return await addFoodToFavorite({ userId, food });
  }
  static async getFavoriteFoods({ userId }) {
    return await getFavoriteFoods({
      userId,
    });
  }
  static async deleteFavoriteFood({ userId, food }) {
    return await deleteFavoriteFood({ userId, food });
  }
  static async checkFoodIsFavorite({ userId, food }) {
    return await checkFoodIsFavorite({ userId, food });
  }

  static async addStoreToFavorite({ userId, store }) {
    return await addStoreToFavorite({ userId, store });
  }
  static async getFavoriteStores({ userId }) {
    return await getFavoriteStores({
      userId,
    });
  }
  static async deleteFavoriteStore({ userId, store }) {
    return await deleteFavoriteStore({ userId, store });
  }
  static async checkStoreIsFavorite({ userId, store }) {
    return await checkStoreIsFavorite({ userId, store });
  }
}

module.exports = UserService;
