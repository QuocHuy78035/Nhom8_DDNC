import 'dart:convert';

import 'package:ddnangcao_project/api_service.dart';
import 'package:ddnangcao_project/features/order/controllers/i_order.dart';
import 'package:ddnangcao_project/models/order.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderController implements IOrder{
  final ApiServiceImpl apiServiceImpl = ApiServiceImpl();
  @override
  Future<OrderModel> createOrder(int totalPrice, int totalApplyDiscount, int feeShip, String shippingAddress, String paymentMethod,
          List<String> foodId, List<int> quantity, String note, String phone, String storeId) async{
    List<Map<String, dynamic>> foods = [];
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    double? longitude = sharedPreferences.getDouble("longitude");
    double? latitude = sharedPreferences.getDouble("latitude");
    for(int i = 0; i < foodId.length; i++){
      foods.add({"food" : foodId[i], "quantity" : quantity[i]});
    }
    late OrderModel orderModel = OrderModel();
    final response = await apiServiceImpl.post(url: "order?coordinate=$longitude,$latitude", params: {
      "checkout": {
        "totalPrice": totalPrice,
        "totalApplyDiscount": totalApplyDiscount,
        "feeShip": feeShip
      },
      "shipping_address": shippingAddress,
      "payment": {"method": paymentMethod},
      "foods": foods,
      "phone" : phone,
      "note" : note,
      "storeId" : storeId
    });
    print(response.body);
    if(response.statusCode == 201){
      final Map<String, dynamic> data = jsonDecode(response.body);
      if(data['status'] == 201){
        orderModel = OrderModel.fromJson(data['metadata']['order']);
      }else{
        print("fail to create order");
      }
    }
    return orderModel;
  }
}
