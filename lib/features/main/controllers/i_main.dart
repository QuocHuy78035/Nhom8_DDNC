import 'package:ddnangcao_project/models/category.dart';
import 'package:ddnangcao_project/models/food.dart';

import '../../../models/store.dart';


abstract class IMain{
  Future<List<CategoryModel>> findAllCate();
  Future<List<FoodModel>> findAllFoodByCateId(String cateId);
  Future<List<StoreFindByCateIdModel>> findAllStoreByCateId(String cateId);
  Future<List<FoodModel>> findAllFoodByStoreIdAndCateId(String storeId, String cateId);
}
