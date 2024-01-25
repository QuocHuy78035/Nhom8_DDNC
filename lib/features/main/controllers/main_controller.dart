import 'dart:convert';
import 'package:ddnangcao_project/models/category.dart';
import 'package:ddnangcao_project/models/food.dart';
import 'package:ddnangcao_project/utils/global_variable.dart';
import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';
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
      print("Get all Cate Suc");
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
        print("Food $food");
        listFood.add(FoodModel.fromJson(food));
        print('add');
      }
      print(listFood.length);
      print("Get all food Suc");
    } else {
      throw Exception("Fail to get food");
    }
    return listFood;
  }

}
