const { BadRequestError } = require("../../core/error.response");
const { removeUndefinedInObject } = require("../../utils");
const Order = require("../order.model");

const findAllOrders = async ({ vendor, filter, sort, search }) => {
  const sortBy = Object.fromEntries([sort].map((val) => [val, 1]));
  const orders = await Order.find(
    removeUndefinedInObject({
      ...filter,
    })
  )
    .sort(sortBy)
    .populate({ path: "user", select: { _id: 1, name: 1, avatar: 1 } })
    .populate({ path: "store", match: { vendor } })
    .lean();
  return orders.filter((order) => order.store !== null);
};

const updateStatusOrders = async ({ orderId, status }) => {
  const statuses = [
    "pending",
    "confirmed",
    "new",
    "outgoing",
    // "cancelled",
    "delivered",
  ];
  const index = statuses.indexOf(status);
  if (index < 0) {
    throw new BadRequestError("Status is not valid!");
  }
  const order = await Order.findById(orderId);
  if (statuses.indexOf(order.status) + 1 !== index) {
    throw new BadRequestError(
      `Update status failed! Order must be in ${statuses[index - 1]} status`
    );
  }
  const updatedOrder = await Order.findByIdAndUpdate(
    orderId,
    { status },
    { new: true }
  );

  return updatedOrder;
};
module.exports = { findAllOrders, updateStatusOrders };
