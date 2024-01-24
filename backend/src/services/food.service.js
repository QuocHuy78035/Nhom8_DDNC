const {
  findAllFoods,
  createFood,
  findFood,
} = require("../models/repositories/food.repo");

class FoodService {
  static async findAllFoods({ filter, sort }) {
    return await findAllFoods({
      select: ["name", "image", "category", "store", "price", "rating"],
      filter,
      sort,
    });
  }
  static async findFood(id) {
    return await findFood({
      id,
      select: ["name", "image", "category", "store", "price", "rating"],
    });
  }
  static async createFood({ name, picture, category, store, price, left }) {
    return await createFood({ name, picture, category, store, price, left });
  }
}

module.exports = FoodService;
