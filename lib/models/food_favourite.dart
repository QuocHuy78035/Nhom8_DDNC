

class FoodFavouriteModel{
  String? id;
  String? name;
  String? category;
  String? store;
  int? price;
  int? rating;
  String? image;
  int? left;
  int? sold;
  String? createdAt;
  String? updatedAt;

  FoodFavouriteModel({
    this.id,
    this.name,
    this.category,
    this.store,
    this.price,
    this.rating,
    this.image,
    this.left,
    this.sold,
    this.createdAt,
    this.updatedAt
  });

  FoodFavouriteModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json['_id'];
      name = json['name'];
      category = json['category'];
      store = json['store'];
      price = json['price'];
      rating = json['rating'];
      image = json['image'];
      left = json['left'];
      sold = json['sold'];
      createdAt = json['createdAt'];
      updatedAt = json['updatedAt'];
    } catch (e) {
      print("Error parsing FoodModel: $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['category'] = category;
    data['store'] = store;
    data['price'] = price;
    data['rating'] = rating;
    data['image'] = image;
    data['left'] = left;
    data['sold'] = sold;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}