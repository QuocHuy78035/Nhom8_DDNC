import 'package:ddnangcao_project/features/favourite/controllers/favourite_controller.dart';
import 'package:ddnangcao_project/models/food.dart';
import 'package:flutter/material.dart';
import '../features/restaurant/controllers/restaurant_controler.dart';
import '../models/store.dart';
import '../utils/color_lib.dart';
import '../utils/global_variable.dart';
import '../utils/snack_bar.dart';

class RestaurantProvider extends ChangeNotifier{
  final RestaurantController restaurantController = RestaurantController();
  final FavouriteController favouriteController = FavouriteController();
  List<StoreModel> listStore = [];
  List<StoreModel> listStoreSortByRating = [];
  List<StoreModel> listStoreSortByDistance = [];
  List<FoodModel> listFood = [];
  bool isLoading = false;
  bool isFavourite = false;

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

  void findAllRestaurantSortByRating() async {
    isLoading = true;
    try {
      listStoreSortByRating = await restaurantController.findAllStoreSortByRating();
    } catch (error) {
      print("Error fetching restaurant data: $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void findAllRestaurantSortByDistance() async {
    isLoading = true;
    try {
      listStoreSortByDistance = await restaurantController.findAllStoreSortByDistance();
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

  checkFavourite(String id) async {
    isLoading = true;
    try{
      bool check = await favouriteController.checkFavourite(id, false);
      isFavourite = check;
    }catch(e){
      print("Error check Favourite provider $e");
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }

  addFavouriteRes(String id, BuildContext context) async {
    isLoading = true;
    isFavourite = true;
    try{
      String message = await favouriteController.addToFavourite(id, false);
      if (message == GlobalVariable.addFavouriteSuc) {
        ShowSnackBar()
            .showSnackBar(message, Colors.green, ColorLib.whiteColor, context);
      } else {
        ShowSnackBar().showSnackBar("Add Food to favourite failed",
            ColorLib.primaryColor, ColorLib.blackColor, context);
      }
    }catch(e){
      print("Fail to add to favourite res provider $e");
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }

  deleteFavouriteRes(String foodId, BuildContext context) async {
    isLoading = true;
    isFavourite = false;
    try {
      String message = await favouriteController.deleteFavourite(foodId, false);
      if (message == GlobalVariable.deleteFavouriteResSuc) {
        ShowSnackBar()
            .showSnackBar(message, Colors.green, ColorLib.whiteColor, context);
      } else {
        ShowSnackBar().showSnackBar("Delete Food to favourite failed",
            ColorLib.primaryColor, ColorLib.blackColor, context);
      }
    } catch (e) {
      print("Fail to delete to favourite food provider $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}