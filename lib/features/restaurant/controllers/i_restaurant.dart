import 'package:ddnangcao_project/models/food.dart';
import 'package:ddnangcao_project/models/store.dart';

abstract class IRestaurant{
  Future<List<StoreModel>> findAllStore();
  Future<List<StoreModel>> findAllStoreSortByRating();
  Future<List<StoreModel>> findAllStoreSortByDistance();
  Future<StoreModel> findStoreByStoreId(String storeId);
  Future<List<FoodModel>> findAllFoodByStoreId(String storeId);
}