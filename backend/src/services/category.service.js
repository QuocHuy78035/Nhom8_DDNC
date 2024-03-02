const {
  createCategory,
  findAllCategories,
  findCategory,
} = require("../models/repositories/category.repo");

class CategoryService {
  static async findAllCategories() {
    return await findAllCategories({ select: ["_id", "name", "image"] });
  }
  static async findCategory(id) {
    return await findCategory({ id, select: ["_id", "name", "image"] });
  }
  static async createCategory({ name }, file) {
    return await createCategory({
      name,
    }, file);
  }
}

module.exports = CategoryService;
