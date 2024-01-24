import 'package:ddnangcao_project/models/category.dart';
import 'package:ddnangcao_project/models/food.dart';


abstract class IMain{
  Future<List<CategoryModel>> findAllCate();
  Future<List<FoodModel>> findAllFoodByCateId(String cateId);
}
