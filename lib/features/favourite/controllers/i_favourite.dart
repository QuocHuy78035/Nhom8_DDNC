

import '../../../models/food_favourite.dart';

abstract class IFavourite{
  Future<String> addToFavourite(String foodId);
  Future<List<FoodFavouriteModel>> getAllFavouriteFoodByUserId();
  Future<String> deleteFavourite(String foodId);
  Future<bool> checkFavourite(String foodId);
}