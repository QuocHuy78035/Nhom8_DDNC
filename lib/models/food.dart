import 'package:ddnangcao_project/models/category.dart';
import 'package:ddnangcao_project/models/store.dart';

class FoodModel{
  String? id;
  String? name;
  CategoryModel? category;
  StoreModel? store;
  int? price;
  int? rating;
  String? image;

  FoodModel({
    this.id,
    this.name,
    this.category,
    this.store,
    this.price,
    this.rating,
    this.image,
  });

  FoodModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json['_id'];
      name = json['name'];
      category = CategoryModel.fromJson(json['category']);
      store = StoreModel.fromJson(json['store']);
      price = json['price'];
      rating = json['rating'];
      image = json['image'];
    } catch (e) {
      print("Error parsing FoodModel: $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['category'] = category?.toJson();
    data['store'] = store?.toJson();
    data['price'] = price;
    data['rating'] = rating;
    data['image'] = image;
    return data;
  }
}