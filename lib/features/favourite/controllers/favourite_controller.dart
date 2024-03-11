import 'dart:convert';
import 'package:ddnangcao_project/api_service.dart';
import 'package:ddnangcao_project/features/favourite/controllers/i_favourite.dart';
import 'package:ddnangcao_project/models/res_favourite.dart';
import '../../../models/food_favourite.dart';

class FavouriteController implements IFavourite {
  ApiServiceImpl apiServiceImpl = ApiServiceImpl();

  @override
  Future<String> addToFavourite(String id, bool isFood) async {
    late String message;
    String url;
    Map<String, dynamic> param;
    if(isFood == true){
      url = "user/favoriteFood";
      param = {"food":id};
    }else{
      url = "user/favoriteStore";
      param = {"store":id};
    }
    final response = await apiServiceImpl.post(
      url: url,
      params: param,
    );
    final Map<String, dynamic> data = jsonDecode(response.body);
    if (data['status'] == 201) {
      message = data['message'];
    } else {
      throw Exception('Fail to add to favourite');
    }
    return message;
  }

  @override
  Future<List<FoodFavouriteModel>> getAllFavouriteFoodByUserId() async {
    List<FoodFavouriteModel> listFoodFavourite = [];
    final response = await apiServiceImpl.get(url: "user/favoriteFood");
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> listFoodResponse = data['metadata'];
      for (var food in listFoodResponse) {
        listFoodFavourite.add(FoodFavouriteModel.fromJson(food));
      }
    } else {
      throw Exception("Fail to get food");
    }
    return listFoodFavourite;
  }

  @override
  Future<String> deleteFavourite(String id, bool isFood) async {
    late String message;
    String url;
    if(isFood == true){
      url = "user/favoriteFood";
    }else{
      url = "user/favoriteStore";
    }
    final response = await apiServiceImpl.delete(url: '$url/$id');
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      message = data['message'];
    } else {
      throw Exception("Fail to delete favourite food");
    }
    return message;
  }

  @override
  Future<bool> checkFavourite(String id, bool isFood) async {
    late bool isFavourite;
    String url;
    if(isFood == true){
      url = "user/favoriteFood";
    }else{
      url = "user/favoriteStore";
    }
    final response = await apiServiceImpl.get(url: "$url/checkIsFavorite/$id");
    Map<String, dynamic> data = jsonDecode(response.body);
    if (data['status'] == 200) {
      isFavourite = data['metadata']['result'];
    } else {
      throw Exception("Fail to Check Favourite food");
    }
    return isFavourite;
  }

  @override
  Future<List<RestaurantFavouriteModel>> getAllFavouriteStoreByUserId() async{
    List<RestaurantFavouriteModel> listResFavourite = [];
    final response = await apiServiceImpl.get(url: "user/favoriteStore");
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> listStoreResponse = data['metadata'];
      for (var store in listStoreResponse) {
        listResFavourite.add(RestaurantFavouriteModel.fromJson(store));
      }
    } else {
      throw Exception("Fail to get store favourite");
    }
    return listResFavourite;
  }
}
