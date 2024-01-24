const {
  addFoodToFavorite,
  getFavoriteFoods,
  deleteFavoriteFood,
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
}

module.exports = UserService;
