import 'dart:convert';

import 'package:ddnangcao_project/features/search/controllers/i_search.dart';
import 'package:ddnangcao_project/models/food.dart';
import 'package:ddnangcao_project/utils/global_variable.dart';
import 'package:http/http.dart' as https;

class SearchFoodController implements ISearch {
  @override
  Future<List<FoodModel>> searchFood(String searchValue) async{
    List<FoodModel> listFood = [];
    final response = await https.get(
      Uri.parse("${GlobalVariable.apiUrl}/food?search=$searchValue"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'search' : searchValue
      }
    );
    print("Search ${response.body}");
    Map<String, dynamic> data = jsonDecode(response.body);
    if(data['status'] == 200){
      List<dynamic> listResponse = data['metadata'];
      for(var food in listResponse){
        listFood.add(FoodModel.fromJson(food));
      }
    }else{
      throw Exception("Fail to search Food");
    }return listFood;
  }
}