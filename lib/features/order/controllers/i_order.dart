import 'package:ddnangcao_project/models/order.dart';

abstract class IOrder {
  Future<OrderModel> createOrder(
      int totalPrice,
      int totalApplyDiscount,
      int feeShip,
      String shippingAddress,
      String paymentMethod,
      List<String> foodId,
      List<int> quantity, String phone,
      String note, String storeId);
}