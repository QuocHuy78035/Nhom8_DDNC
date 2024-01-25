const {
  findAllFoods,
  createFood,
  findFood,
} = require("../models/repositories/food.repo");

class FoodService {
  static async findAllFoods({ filter, sort, search }) {
    return await findAllFoods({
      unselect: ["createdAt", "updatedAt", "__v"],
      filter,
      sort,
      search,
    });
  }
  static async findFood(id) {
    return await findFood({
      id,
      unselect: ["createdAt", "updatedAt", "__v"],
    });
  }
  static async createFood({ name, image, category, store, price, left }) {
    return await createFood({ name, image, category, store, price, left });
  }
}

module.exports = FoodService;
