const {
  addToCart,
  getCart,
  updateNumberCart,
  deleteAllCarts,
} = require("../models/repositories/cart.repo");

class CartService {
  static async addToCart({ user, food, number }) {
    return await addToCart({ userId: user, foodId: food, number });
  }
  static async updateNumberCart({ user, food, mode }) {
    return await updateNumberCart({ userId: user, foodId: food, mode });
  }
  static async getCart({ user, coordinate }) {
    return await getCart({
      user,
      select: [
        "_id",
        "number",
        "food._id",
        "food.name",
        "food.price",
        "food.store",
        "food.image",
      ],
      coordinate,
    });
  }
  static async deleteAllCarts({user}) {
    return await deleteAllCarts({user});
  }
}

module.exports = CartService;
