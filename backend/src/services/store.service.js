const {
  createStore,
  findAllStores,
  findStore,
  findTop10RatingStores,
} = require("../models/repositories/store.repo");

class StoreService {
  static async findAllStores({ sort, categories, search }) {
    return await findAllStores({
      unselect: ["createdAt", "updatedAt", "__v"],
      categoriesId: categories,
      search,
      sort,
    });
  }
  static async findTop10RatingStores() {
    return await findTop10RatingStores({
      unselect: ["createdAt", "updatedAt", "__v"],
    });
  }
  static async findStore(id) {
    return await findStore({
      id,
      unselect: ["createdAt", "updatedAt", "__v"],
    });
  }
  static async createStore({
    name,
    image,
    address,
    time_open,
    time_close,
    rating,
  }) {
    return await createStore({
      name,
      image,
      address,
      time_open,
      time_close,
      rating,
    });
  }
}

module.exports = StoreService;
