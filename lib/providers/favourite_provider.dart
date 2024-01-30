import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../features/favourite/controllers/favourite_controller.dart';
import '../models/food_favourite.dart';
import '../utils/color_lib.dart';
import '../utils/global_variable.dart';
import '../utils/snack_bar.dart';

class FavouriteProvider extends ChangeNotifier{
  bool isLoading = false;
  List<FoodFavouriteModel> listFavouriteFood = [];
  final FavouriteController favouriteController = FavouriteController();

  getAllFavouriteFood() async {
    isLoading = true;
    try{
      listFavouriteFood = await favouriteController.getAllFavouriteFoodByUserId();
    }catch(e){
      print("Fail to get all favourite food favourite_provider");
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }


  deleteFavourite(String foodId, int index, BuildContext context) async {
    isLoading = true;
    try{
      String message = await favouriteController.deleteFavourite(foodId);
      if (message == GlobalVariable.deleteFavouriteSuc) {
        // setState(() {
        //   listFavouriteFood.removeAt(index);
        // });
        listFavouriteFood.removeAt(index);
        ShowSnackBar()
            .showSnackBar(message, Colors.green, ColorLib.whiteColor, context);
      }
    }catch(e){
      print("Fail to delete favourite favourite_provider $e");
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }
}