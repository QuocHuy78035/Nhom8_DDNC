import 'dart:convert';
import 'package:ddnangcao_project/models/food.dart';
import 'package:ddnangcao_project/models/store.dart';
import 'package:http/http.dart' as https;
import '../../../../utils/global_variable.dart';
import 'i_restaurant.dart';

class RestaurantController implements IRestaurant{
  @override
  Future<List<StoreModel>> findAllStore() async{
    List<StoreModel> listStore = [];
    final response = await https.get(
      Uri.parse("${GlobalVariable.apiUrl}/store"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> listStoreResponse = data['metadata'];
      for (var store in listStoreResponse) {
        listStore.add(StoreModel.fromJson(store));
      }
    } else {
      throw Exception("Fail to get store");
    }
    return listStore;
  }

  @override
  Future<StoreModel> findStoreByStoreId(String storeId) async{
    StoreModel store;
    final response = await https.get(
      Uri.parse("${GlobalVariable.apiUrl}/store/$storeId"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if(response.statusCode == 200){
      final Map<String, dynamic> data = jsonDecode(response.body);
      store = data['metadata'];
    }else{
      throw Exception("Fail to get store by storeId");
    }
    return store;
  }

  @override
  Future<List<FoodModel>> findAllFoodByStoreId(String storeId) async{
    List<FoodModel> listFood = [];
    final response = await https.get(
      Uri.parse("${GlobalVariable.apiUrl}/food?store=$storeId"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(storeId);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> listFoodResponse = data['metadata'];
      print("ListFoodRP $listFoodResponse");
      for (var food in listFoodResponse) {
        listFood.add(FoodModel.fromJson(food));
      }
      print(listFood.length);
      print("Get all food Suc");
    } else {
      throw Exception("Fail to get food");
    }
    return listFood;
  }
}