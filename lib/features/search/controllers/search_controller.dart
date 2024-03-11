import 'dart:convert';
import 'package:ddnangcao_project/api_service.dart';
import 'package:ddnangcao_project/features/search/controllers/i_search.dart';
import 'package:ddnangcao_project/models/food.dart';

class SearchFoodController implements ISearch {
  @override
  Future<List<FoodModel>> searchFood(String searchValue) async{
    final ApiServiceImpl apiServiceImpl = ApiServiceImpl();
    List<FoodModel> listFood = [];
    final response = await apiServiceImpl.get(url: "food?search=$searchValue");
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