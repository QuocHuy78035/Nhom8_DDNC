import 'dart:convert';
import 'package:ddnangcao_project/models/category.dart';
import 'package:ddnangcao_project/models/food.dart';
import 'package:ddnangcao_project/models/store.dart';
import 'package:ddnangcao_project/utils/global_variable.dart';
import 'package:http/http.dart' as https;
import 'i_main.dart';

class MainController implements IMain {
  @override
  Future<List<CategoryModel>> findAllCate() async {
    List<CategoryModel> listCate = [];
    final response = await https.get(
      Uri.parse("${GlobalVariable.apiUrl}/category"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> listCateResponse = data['metadata'];
      for (var cate in listCateResponse) {
        listCate.add(CategoryModel.fromJson(cate));
      }
    } else {
      throw Exception("Fail to get category");
    }
    return listCate;
  }

  @override
  Future<List<FoodModel>> findAllFoodByCateId(String cateId) async {
    List<FoodModel> listFood = [];
    final response = await https.get(
      Uri.parse("${GlobalVariable.apiUrl}/food?category=$cateId"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> listFoodResponse = data['metadata'];

      for (var food in listFoodResponse) {
        listFood.add(FoodModel.fromJson(food));
      }
    } else {
      throw Exception("Fail to get food");
    }
    return listFood;
  }

  @override
  Future<List<StoreFindByCateIdModel>> findAllStoreByCateId(String cateId) async {
    List<StoreFindByCateIdModel> listStore = [];
    final response = await https.get(
      Uri.parse("${GlobalVariable.apiUrl}/food?category=$cateId"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> listStoreResponse = data['metadata'];
      for (var food in listStoreResponse) {
        listStore.add(StoreFindByCateIdModel.fromJson(food));
      }
    } else {
      throw Exception("Fail to get food");
    }
    return listStore;
  }

  @override
  Future<List<FoodModel>> findAllFoodByStoreIdAndCateId(String storeId, String cateId) async{
    final List<FoodModel> listFood = [];
    final response = await https.get(
      Uri.parse("${GlobalVariable.apiUrl}/food?store=$storeId&category=$cateId"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      }
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    if(data['status'] == 200){
      List<dynamic> listResponse = data['metadata'];
      for (var food in listResponse) {
        listFood.add(FoodModel.fromJson(food));
      }
    }else{
      throw Exception("Fail to get food by cateId and storeId");
    }return listFood;
  }
}
