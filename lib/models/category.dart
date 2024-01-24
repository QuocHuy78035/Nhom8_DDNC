class CategoryModel{
  String? cateId;
  String? cateName;
  String? image;

  CategoryModel({this.cateId, this.cateName});

  CategoryModel.fromJson(Map<String, dynamic> json){
    cateId = json['_id'];
    cateName = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = cateId;
    data['name'] = cateName;
    data['image'] = image;
    return data;
  }
}