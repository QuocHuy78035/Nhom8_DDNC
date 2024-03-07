import 'package:ddnangcao_project/models/res_favourite.dart';
import 'package:flutter/material.dart';
import '../features/favourite/controllers/favourite_controller.dart';
import '../models/food_favourite.dart';
import '../utils/color_lib.dart';
import '../utils/global_variable.dart';
import '../utils/snack_bar.dart';

class FavouriteProvider extends ChangeNotifier{
  bool isLoading = false;
  List<FoodFavouriteModel> listFavouriteFood = [];
  List<RestaurantFavouriteModel> listFavouriteRes = [];

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

  getAllFavouriteRes() async {
    isLoading = true;
    try{
      listFavouriteRes = await favouriteController.getAllFavouriteStoreByUserId();
    }catch(e){
      print("Fail to get all favourite store favourite_provider");
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }

  deleteFavourite(String id, int index, BuildContext context, bool isFood) async {
    isLoading = true;
    try{
      String message = await favouriteController.deleteFavourite(id, isFood);
      if (message == GlobalVariable.deleteFavouriteSuc) {
        listFavouriteFood.removeAt(index);
        ShowSnackBar()
            .showSnackBar(message, Colors.green, ColorLib.whiteColor, context);
      }else if(message == GlobalVariable.deleteFavouriteResSuc){
        listFavouriteRes.removeAt(index);
        ShowSnackBar()
            .showSnackBar(message, Colors.green, ColorLib.whiteColor, context);
      }else{
        print("False delete favourite");
      }
    }catch(e){
      print("Fail to delete favourite_provider $e");
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }
}