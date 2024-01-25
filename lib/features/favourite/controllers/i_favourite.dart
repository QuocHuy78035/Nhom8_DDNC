

import '../../../models/food_favourite.dart';

abstract class IFavourite{
  Future<String> addToFavourite(String foodId);
  Future<List<FoodFavouriteModel>> getAllFavouriteFoodByUserId(String userId);
  Future<String> deleteFavourite(String foodId);
}