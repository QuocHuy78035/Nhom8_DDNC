const { BadRequestError } = require("../core/error.response");
const User = require("../models/user.model");
const Food = require("../models/food.model");
const Order = require("../models/order.model");
const Cart = require("../models/cart.model");
const Store = require("../models/store.model");
const transaction = require("../helpers/transaction");
const Statistic = require("../models/statistic.model");
const { getDistanceFromLatLonInKm } = require("../utils/index");
const {
  findAllOrders,
  updateStatusOrders,
} = require("../models/repositories/order.repo");
class OrderService {
  static createOrder = async ({
    userId,
    checkout,
    shipping_address,
    payment,
    foods,
    storeId,
    coordinate,
    note,
    phone,
  }) => {
    return await transaction(async (session) => {
      if (!coordinate) {
        throw new BadRequestError("Coordinate is not exist!");
      }
      const [longtitude, latitude] = coordinate.split(",");
      if (!longtitude || !latitude) {
        throw new BadRequestError("Longtitude or latitude is required!");
      }

      const statistic = (await Statistic.find())[0];

      //Kiểm tra người dùng hợp lệ
      const user = await User.findById(userId);
      if (!user) {
        throw new BadRequestError("You are not logged in!");
      }

      // Kiểm tra store tồn tại
      const store = await Store.findById(storeId);
      if (!store) {
        throw new BadRequestError(
          `The store with id ${storeId} does not exist`
        );
      }

      const distance = getDistanceFromLatLonInKm(
        latitude,
        longtitude,
        store.latitude,
        store.longtitude
      );

      if (!foods.length) {
        throw new BadRequestError("Food is required!");
      }
      // Kiểm tra food tồn tại
      const existedFoods = await Promise.all(
        foods.map(async (food) => {
          const existedFood = await Food.findById(food.food);
          if (!existedFood) {
            throw new BadRequestError(
              `The food with id ${food.food} does not exist`
            );
          }
          const existedFoodBelongToStore = await Food.findOne({
            store: storeId,
          });
          if (!existedFoodBelongToStore) {
            throw new BadRequestError(
              `Food is not belong to store! Please check again!`
            );
          }
          return existedFood;
        })
      );

      // xóa đồ ăn trong giỏ hàng của user sau khi thêm đơn hàng và
      // cập nhật số lượng còn đồ ăn của cửa hàng
      await Promise.all(
        foods.map(async (food, i) => {
          // Kiểm tra số lượng còn của đồ ăn có đủ cho số lượng được đặt hay không?
          if (food.quantity > existedFoods[i].left) {
            throw new BadRequestError(
              "The quantity of food in store is not enough to order!"
            );
          }
          await Cart.findOneAndDelete(
            { user: userId, food: food.food },
            { session }
          );

          await Food.findByIdAndUpdate(
            food.food,
            {
              $inc: {
                left: -food.quantity,
              },
            },
            { session }
          );
        })
      );
      // Cập nhật thống kê số lượng đơn hàng
      await Statistic.findByIdAndUpdate(
        statistic._id,
        {
          $inc: {
            number_of_orders: 1,
          },
        },
        { session }
      );

      // tạo đơn hàng
      const order = await Order.create(
        [
          {
            user: userId,
            checkout,
            shipping_address,
            payment,
            foods,
            trackingNumber: `#${statistic.number_of_orders + 1}`,
            status: "pending",
            store: storeId,
            distance,
            note,
            phone,
          },
        ],
        { session }
      );

      if (!order[0]) {
        throw new BadRequestError("Create order failed!");
      }

      return order[0];
    });
  };
  static findAllOrders = async ({ vendor, filter, sort, search }) => {
    return await findAllOrders({ vendor, filter, sort, search });
  };
  static updateStatusOrders = async ({ orderId, status }) => {
    return await updateStatusOrders({ orderId, status });
  };
}

module.exports = OrderService;
