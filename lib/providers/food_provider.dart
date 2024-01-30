import 'package:ddnangcao_project/features/add_to_cart/controllers/add_to_cart_controller.dart';
import 'package:ddnangcao_project/features/favourite/controllers/favourite_controller.dart';
import 'package:ddnangcao_project/features/main/controllers/main_controller.dart';
import 'package:flutter/material.dart';

import '../models/food.dart';
import '../utils/color_lib.dart';
import '../utils/global_variable.dart';
import '../utils/snack_bar.dart';

class FoodProvider extends ChangeNotifier{
  final FavouriteController favouriteController = FavouriteController();
  final AddToCartController addToCartController = AddToCartController();
  final MainController mainController = MainController();
  bool isFavourite = false;
  bool isLoading = false;
  List<FoodModel> listFood = [];


  checkFavourite(String foodId) async {
    isLoading = true;
    try{
      bool check = await favouriteController.checkFavourite(foodId);
      isFavourite = check;
    }catch(e){
      print("Error check Favourite provider $e");
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }

  addToCart(String foodId, int value, BuildContext context) async {
    isLoading = true;
    try{
      String message = await addToCartController.addToCart(foodId, value);
      if (message == GlobalVariable.addToCartSuc) {
        ShowSnackBar()
            .showSnackBar(message, Colors.green, ColorLib.whiteColor, context);
      } else if (message == "Food has added to cart already!") {
        ShowSnackBar().showSnackBar(
            message, ColorLib.primaryColor, ColorLib.whiteColor, context);
      } else {
        ShowSnackBar().showSnackBar("Add Food to Cart failed",
            ColorLib.primaryColor, ColorLib.blackColor, context);
      }
    }catch(e){
      print("Fail to add to cart Provider $e");
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }

  addFavouriteFood(String foodId, BuildContext context) async {
    isLoading = true;
    isFavourite = true;
    try{
      String message = await favouriteController.addToFavourite(foodId);
      if (message == GlobalVariable.addFavouriteFoodSuc) {
        ShowSnackBar()
            .showSnackBar(message, Colors.green, ColorLib.whiteColor, context);
      } else {
        ShowSnackBar().showSnackBar("Add Food to favourite failed",
            ColorLib.primaryColor, ColorLib.blackColor, context);
      }
    }catch(e){
      print("Fail to add to favourite food provider $e");
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }


  deleteFavouriteFood(String foodId, BuildContext context) async {
    isLoading = true;
    isFavourite = false;
    try{
      String message = await favouriteController.deleteFavourite(foodId);
      if (message == GlobalVariable.deleteFavouriteSuc) {
        ShowSnackBar()
            .showSnackBar(message, Colors.green, ColorLib.whiteColor, context);
      } else {
        ShowSnackBar().showSnackBar("Delete Food to favourite failed",
            ColorLib.primaryColor, ColorLib.blackColor, context);
      }
    }catch(e){
      print("Fail to delete to favourite food provider $e");
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }

  getFoodByStoreIdAndCateId(String storeId, String cateId) async {
    isLoading = true;
    try{
      listFood = await mainController.findAllFoodByStoreIdAndCateId(storeId, cateId);
    }catch(e){
      print("Fail to get food by storeId and cateId $e");
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }
}