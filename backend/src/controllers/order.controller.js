const { OK, CREATED } = require("../core/success.response");
const OrderService = require("../services/order.service");

class OrderController {
  createOrder = async (req, res, next) => {
    const order = await OrderService.createOrder({
      userId: req.user.userId,
      ...req.body,
    });
    new CREATED({
      message: "Create order successfully!",
      metadata: {
        order,
      },
    }).send(res);
  };
}

module.exports = new OrderController();
