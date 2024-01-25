const {
  addFoodToFavorite,
  getFavoriteFoods,
  deleteFavoriteFood,
  checkFoodIsFavorite,
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
}

module.exports = UserService;
