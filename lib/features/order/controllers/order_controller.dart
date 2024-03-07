import 'dart:convert';

import 'package:ddnangcao_project/api_service.dart';
import 'package:ddnangcao_project/features/order/controllers/i_order.dart';
import 'package:ddnangcao_project/models/order.dart';

class OrderController implements IOrder{
  final ApiServiceImpl apiServiceImpl = ApiServiceImpl();
  @override
  Future<OrderModel> createOrder(int totalPrice, int totalApplyDiscount, int feeShip, String shippingAddress, String paymentMethod,
          List<String> foodId, List<int> quantity) async{
    List<Map<String, dynamic>> foods = [];
    print(foodId.length);
    for(int i = 0; i < foodId.length; i++){
      foods.add({"food" : foodId[i], "quantity" : quantity[i]});
    }
    late OrderModel orderModel = OrderModel();
    final response = await apiServiceImpl.post(url: "order", params: {
      "checkout": {
        "totalPrice": totalPrice,
        "totalApplyDiscount": totalApplyDiscount,
        "feeShip": feeShip
      },
      "shipping_address": shippingAddress,
      "payment": {"method": paymentMethod},
      "foods": foods
    });
    if(response.statusCode == 201){
      final Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      if(data['status'] == 201){
        orderModel = OrderModel.fromJson(data['metadata']['order']);
      }else{
        print("fail to create order");
      }
    }
    return orderModel;
  }
}
