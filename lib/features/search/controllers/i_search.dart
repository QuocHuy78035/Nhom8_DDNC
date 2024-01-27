import '../../../models/food.dart';

abstract class ISearch{
  Future<List<FoodModel>> searchFood(String searchValue);
}