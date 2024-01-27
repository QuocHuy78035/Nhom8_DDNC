import 'dart:convert';
import 'package:ddnangcao_project/features/add_to_cart/controllers/i_add_to_cart.dart';
import 'package:ddnangcao_project/models/food_cart.dart';
import 'package:ddnangcao_project/utils/global_variable.dart';
import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

class AddToCartController implements IAddToCart{
  @override
  Future<String> addToCart(String foodId, int quantity) async{
    late String message;
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString("accessToken");
    final String? userId = sharedPreferences.getString("userId");
    final response = await https.post(
      Uri.parse("${GlobalVariable.apiUrl}/cart"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': token ?? "",
        "x-client-id": userId ?? ""
      },
      body: jsonEncode(
        {"food": foodId, "number" : quantity},
      ),
    );
    if(response.statusCode == 201 || response.statusCode == 400){
      final Map<String, dynamic> data = jsonDecode(response.body);
      message = data['message'];
    }else{
      throw("Fail to add to cart");
    }return message;
  }

  @override
  Future<void> removeFromCart(String foodId) {
    // TODO: implement removeFromCart
    throw UnimplementedError();
  }

  @override
  Future<List<FoodCartModel>> getAllCart() async {
    List<FoodCartModel> listCart = [];
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString("accessToken");
    final String? userId = sharedPreferences.getString("userId");
    final response = await https.get(
      Uri.parse("${GlobalVariable.apiUrl}/cart"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': token ?? "",
        "x-client-id": userId ?? ""
      },
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    if (data['status'] == 200) {
      List<dynamic> metadataList = data['metadata'];
      for(int i = 0 ; i < metadataList.length; i++){
        for(var cartData in metadataList[i]['foods']){
          FoodCartModel cart = FoodCartModel.fromJson(cartData);
          listCart.add(cart);
        }
      }
      print(listCart);
    } else {
      throw Exception("Fail to get all cart");
    }
    return listCart;
  }

  @override
  Future<String> updateCartDecrement(String foodId) async{
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString("accessToken");
    final String? userId = sharedPreferences.getString("userId");
    late String message;
    final response = await https.patch(
      Uri.parse("${GlobalVariable.apiUrl}/cart/decrement"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': token ?? "",
        "x-client-id": userId ?? ""
      },
      body: jsonEncode({
        "food": foodId
      })
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    if(data['status'] == 200){
      message = data['message'];
    }else{
      throw Exception("Fail to decrement cart");
    }return message;
  }

  @override
  Future<String> updateCartIncrement(String foodId) async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString("accessToken");
    final String? userId = sharedPreferences.getString("userId");
    late String message;
    final response = await https.patch(
        Uri.parse("${GlobalVariable.apiUrl}/cart/increment"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': token ?? "",
          "x-client-id": userId ?? ""
        },
        body: jsonEncode({
          "food": foodId
        })
    );
    print("Increment ${response.body}");
    Map<String, dynamic> data = jsonDecode(response.body);
    if(data['status'] == 200){
      message = data['message'];
    }else{
      throw Exception("Fail to increment cart");
    }return message;
  }
}