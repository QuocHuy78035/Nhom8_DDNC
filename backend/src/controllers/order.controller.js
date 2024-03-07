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
  findAllOrders = async (req, res, next) => {
    const { status, sort, search } = req.query;
    const orders = await OrderService.findAllOrders({
      filter: { status },
      sort,
      search,
    });
    new OK({
      message: "Find all orders successfully!",
      metadata: {
        orders,
      },
    }).send(res);
  };
  updateStatusOrders = async (req, res, next) => {
    const order = await OrderService.updateStatusOrders({
      orderId: req.params.id,
      status: req.body.status,
    });
    new OK({
      message: "Update order successfully!",
      metadata: {
        order,
      },
    }).send(res);
  };
}

module.exports = new OrderController();
