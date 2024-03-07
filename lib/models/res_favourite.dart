class RestaurantFavouriteModel {
  String? id;
  String? name;
  String? image;
  String? address;
  String? rating;
  String? timeOpen;
  String? timeClose;
  String? createAt;
  String? updateAt;

  RestaurantFavouriteModel({
    this.id,
    this.name,
    this.address,
    this.image,
    this.rating,
    this.timeClose,
    this.timeOpen,
    this.createAt,
    this.updateAt,
  });

  RestaurantFavouriteModel.fromJson(Map<String, dynamic> json){
    try{
      id = json['_id'];
      name = json['name'];
      address = json['address'];
      rating = json['rating'];
      timeOpen = json['time_open'];
      timeClose = json['time_close'];
      createAt = json['createdAt'];
      updateAt = json['updatedAt'];
      image = json['image'];
    }catch(e){
      print("Fail to parse Res Favourite Model");
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['rating'] = rating;
    data['image'] = image;
    data['time_open'] = timeOpen;
    data['time_close'] = timeClose;
    data['createdAt'] = createAt;
    data['updatedAt'] = updateAt;
    return data;
  }
}
