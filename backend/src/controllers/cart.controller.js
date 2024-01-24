const { CREATED, OK } = require("../core/success.response");
const CartService = require("../services/cart.service");

class CartController {
  addToCart = async (req, res, next) => {
    const result = await CartService.addToCart({
      user: req.user.userId,
      food: req.body.food,
    });
    return new CREATED({
      message: "Add to cart successfully!",
      metadata: result,
    }).send(res);
  };
  getCart = async (req, res, next) => {
    const result = await CartService.getCart({
      user: req.user.userId,
    });
    return new OK({
      message: "Get cart successfully!",
      metadata: result,
    }).send(res);
  };
}

module.exports = new CartController();
