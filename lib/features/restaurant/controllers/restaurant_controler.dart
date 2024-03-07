import 'dart:convert';
import 'package:ddnangcao_project/api_service.dart';
import 'package:ddnangcao_project/models/food.dart';
import 'package:ddnangcao_project/models/store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'i_restaurant.dart';

class RestaurantController implements IRestaurant{
  final ApiServiceImpl apiServiceImpl = ApiServiceImpl();
  @override
  Future<List<StoreModel>> findAllStore() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final double? latitude = sharedPreferences.getDouble("latitude");
    final double? longitude = sharedPreferences.getDouble("longitude");
    List<StoreModel> listStore = [];
    final response = await apiServiceImpl.get(url: "store?coordinate=$latitude,$longitude");
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
  Future<List<StoreModel>> findAllStoreSortByRating() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final double? latitude = sharedPreferences.getDouble("latitude");
    final double? longitude = sharedPreferences.getDouble("longitude");
    List<StoreModel> listStore = [];
    final response = await apiServiceImpl.get(url: "store?coordinate=$latitude,$longitude&sort=rating");
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
    final response = await apiServiceImpl.get(url: "store/$storeId");
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
    final response = await apiServiceImpl.get(url: "food?store=$storeId");
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> listFoodResponse = data['metadata'];
      for (var food in listFoodResponse) {
        listFood.add(FoodModel.fromJson(food));
      }
    } else {
      throw Exception("Fail to get food");
    }
    return listFood;
  }

  @override
  Future<List<StoreModel>> findAllStoreSortByDistance() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final double? latitude = sharedPreferences.getDouble("latitude");
    final double? longitude = sharedPreferences.getDouble("longitude");
    List<StoreModel> listStore = [];
    final response = await apiServiceImpl.get(url: "store?coordinate=$latitude,$longitude&sort=distance");
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> listStoreResponse = data['metadata'];
      for (var store in listStoreResponse) {
        listStore.add(StoreModel.fromJson(store));
      }
    } else {
      throw Exception("Fail to get store sort by distance");
    }
    return listStore;
  }
}