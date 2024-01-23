const {
  createStore,
  findAllStores,
  findStore,
} = require("../models/repositories/store.repo");

class StoreService {
  static async findAllStores() {
    return await findAllStores({
      unselect: ["createdAt", "updatedAt", "__v"],
    });
  }
  static async findStore(id) {
    return await findStore({
      id,
      unselect: ["createdAt", "updatedAt", "__v"],
    });
  }
  static async createStore({ name, picture, address, time_open, time_close }) {
    return await createStore({
      name,
      picture,
      address,
      time_open,
      time_close,
    });
  }
}

module.exports = StoreService;
