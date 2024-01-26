  class FoodDetailModel {
    String? id;
    String? name;
    String? image;
    String? storeId;
    int? price;

    FoodDetailModel({this.id, this.name, this.image, this.storeId, this.price});

    FoodDetailModel.fromJson(Map<String, dynamic> json) {
      try{
        id = json['_id'];
        name = json['name'];
        image = json['image'];
        storeId = json['store'];
        price = json['price'];
      }catch(e){
        print('fail to parse data Food Detail Model $e');
      }
    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['_id'] = id;
      data['name'] = name;
      data['image'] = image;
      data['store'] = storeId;
      data['price'] = price;
      return data;
    }
  }


class StoreCartModel {
  String? id;
  String? name;
  String? address;
  int? rating;
  String? timeOpen;
  String? timeClose;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? image;

  StoreCartModel({
    this.id,
    this.name,
    this.address,
    this.rating,
    this.timeOpen,
    this.timeClose,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.image,
  });

  StoreCartModel.fromJson(Map<String, dynamic> json) {
    try{
      id = json['_id'];
      name = json['name'];
      address = json['address'];
      rating = json['rating'];
      timeOpen = json['time_open'];
      timeClose = json['time_close'];
      createdAt = json['createdAt'];
      updatedAt = json['updatedAt'];
      v = json['__v'];
      image = json['image'];
    }catch(e){
      print("fail to parse data Store Cart Model $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['address'] = image;
    data['rating'] = rating;
    data['time_open'] = timeOpen;
    data['time_close'] = timeClose;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = v;
    data['image'] = image;
    return data;
  }
}


class FoodCartModel {
  String? id;
  FoodDetailModel? food;
  int? number;

  FoodCartModel({this.id, this.food, this.number});

  FoodCartModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    food = FoodDetailModel.fromJson(json['food']);
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['food'] = food?.toJson();
    data['number'] = number;
    return data;
  }
}


class CartModel {
  List<FoodCartModel>? foods;
  int? numberOfFoods;
  StoreCartModel? store;

  CartModel({this.foods, this.numberOfFoods, this.store});

  CartModel.fromJson(Map<String, dynamic> json) {
    try {
      foods = (json['foods'] as List)
          .map((food) => FoodCartModel.fromJson(food))
          .toList();
      store = StoreCartModel.fromJson(json['store']);
      numberOfFoods = json['numberOfFoods'];
    } catch (e) {
      print("fail to parse data Cart Model $e");
    }
  }
}