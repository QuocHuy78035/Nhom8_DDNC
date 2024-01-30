import 'package:ddnangcao_project/models/food.dart';
import 'package:flutter/cupertino.dart';
import '../features/restaurant/controllers/restaurant_controler.dart';
import '../models/store.dart';

class RestaurantProvider extends ChangeNotifier{
  final RestaurantController restaurantController = RestaurantController();
  List<StoreModel> listStore = [];
  List<FoodModel> listFood = [];
  bool isLoading = false;

  void findAllRestaurant() async {
    isLoading = true;
    try {
      listStore = await restaurantController.findAllStore();
    } catch (error) {
      print("Error fetching restaurant data: $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void getFoodByResId(String storeId) async{
    isLoading = true;
    try{
      listFood = await restaurantController.findAllFoodByStoreId(storeId);
    }catch (error) {
      print("Error fetching food by restaurantId: $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}