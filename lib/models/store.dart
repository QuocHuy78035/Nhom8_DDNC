import 'category.dart';

class StoreModel{
  String? id;
  String? name;
  String? address;
  double? rating;
  List<CategoryModel>? category;
  String? timeOpen;
  String? timeClose;
  String? image;

  StoreModel({this.id, this.name, this.address, this.rating, this.timeOpen, this.timeClose, this.image, this.category});

  StoreModel.fromJson(Map<String, dynamic> json){
    try{
      category = (json['categories'] as List)
          .map((cate) => CategoryModel.fromJson(cate))
          .toList();
      id = json['_id'];
      name = json['name'];
      address = json['address'];
      category = category;
      rating = json['rating'];
      timeOpen = json['time_open'];
      timeClose = json['time_close'];
      image = json['image'];
    }
    catch (e) {
      print("Error parsing Store: $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['rating'] = rating;
    data['categories'] = category;
    data['time_open'] = timeOpen;
    data['time_close'] = timeClose;
    data['image'] = image;
    return data;
  }
}



class StoreFindByCateIdModel{
  String? id;
  String? name;
  String? address;
  int? rating;
  String? timeOpen;
  String? timeClose;
  String? image;

  StoreFindByCateIdModel({this.id, this.name, this.address, this.rating, this.timeOpen, this.timeClose, this.image});

  StoreFindByCateIdModel.fromJson(Map<String, dynamic> json){
    try{
      id = json['store']['_id'];
      name = json['store']['name'];
      address = json['store']['address'];
      rating = json['store']['rating'];
      timeOpen = json['store']['time_open'];
      timeClose = json['store']['time_close'];
      image = json['store']['image'];
    }
    catch (e) {
      print("Error parsing StoreFindByCateIdModel: $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['rating'] = rating;
    data['time_open'] = timeOpen;
    data['time_close'] = timeClose;
    data['image'] = image;
    return data;
  }
}