const {
  createCategory,
  findAllCategories,
  findCategory,
} = require("../models/repositories/category.repo");

class CategoryService {
  static async findAllCategories() {
    return await findAllCategories({ select: ["_id", "name", "picture"] });
  }
  static async findCategory(id) {
    return await findCategory({ id, select: ["_id", "name", "picture"] });
  }
  static async createCategory({ name, picture }) {
    return await createCategory({
      name,
      picture,
    });
  }
}

module.exports = CategoryService;
