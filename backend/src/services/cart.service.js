const { addToCart, getCart } = require("../models/repositories/cart.repo");

class CartService {
  static async addToCart({ user, food }) {
    return await addToCart({ user, food });
  }
  static async getCart({ user }) {
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
    });
  }
}

module.exports = CartService;
