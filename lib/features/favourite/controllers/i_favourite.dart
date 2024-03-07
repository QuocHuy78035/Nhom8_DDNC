
import '../../../models/food_favourite.dart';
import '../../../models/res_favourite.dart';

abstract class IFavourite{
  Future<String> addToFavourite(String id, bool isFood);
  Future<List<FoodFavouriteModel>> getAllFavouriteFoodByUserId();
  Future<List<RestaurantFavouriteModel>> getAllFavouriteStoreByUserId();
  Future<String> deleteFavourite(String id, bool isFood);
  Future<bool> checkFavourite(String id, bool isFood);
}