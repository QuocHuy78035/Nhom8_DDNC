import 'dart:convert';
import 'package:ddnangcao_project/features/favourite/controllers/i_favourite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as https;
import '../../../models/food_favourite.dart';
import '../../../utils/global_variable.dart';

class FavouriteController implements IFavourite{
  @override
  Future<String> addToFavourite(String foodId) async {
    late String message;
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString("accessToken");
    final String? userId = sharedPreferences.getString("userId");
    final response = await https.post(
      Uri.parse("${GlobalVariable.apiUrl}/user/addToFavorite"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': token ?? "",
        "x-client-id": userId ?? ""
      },
      body: jsonEncode(
        {"food": foodId},
      ),
    );
    final Map<String, dynamic> data = jsonDecode(response.body);
    if(data['status'] == 201){
      message = data['message'];
    }else{
      throw Exception('Fail to add to favourite');
    }return message;
  }

  @override
  Future<List<FoodFavouriteModel>> getAllFavouriteFoodByUserId(String userId) async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<FoodFavouriteModel> listFoodFavourite = [];
    final String? token = sharedPreferences.getString("accessToken");
    final String? userId = sharedPreferences.getString("userId");
    final response = await https.get(
      Uri.parse("${GlobalVariable.apiUrl}/user/favorite"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': token ?? "",
        "x-client-id": userId ?? ""
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> listFoodResponse = data['metadata'];

      for (var food in listFoodResponse) {
        print("Food $food");
        listFoodFavourite.add(FoodFavouriteModel.fromJson(food));
      }
      print("Get all food Suc");
    } else {
      throw Exception("Fail to get food");
    }
    return listFoodFavourite;
  }
  
  @override
  Future<String> deleteFavourite(String foodId) async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString("accessToken");
    final String? userId = sharedPreferences.getString("userId");
    late String message;
    final response = await https.delete(
      Uri.parse("${GlobalVariable.apiUrl}/user/favorite/$foodId"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': token ?? "",
        "x-client-id": userId ?? ""
      }
    );
    if(response.statusCode == 200){
      Map<String, dynamic> data = jsonDecode(response.body);
      message = data['message'];
    }else{
      throw Exception("Fail to delete favourite food");
    }return message;
  }
}