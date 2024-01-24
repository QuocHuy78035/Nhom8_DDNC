class StoreModel{
  String? id;
  String? name;
  String? address;
  int? rating;
  String? timeOpen;
  String? timeClose;
  String? image;

  StoreModel({this.id, this.name, this.address, this.rating, this.timeOpen, this.timeClose, this.image});

  StoreModel.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    name = json['name'];
    address = json['address'];
    rating = json['rating'];
    timeOpen = json['time_open'];
    timeClose = json['time_close'];
    image = json['image'];
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