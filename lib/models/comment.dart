class CommentModel {
  List<String>? imageUrl;
  String? id;
  UserComment? user;
  String? foodId;
  String? storeId;
  String? comment;
  String? rating;
  int? numberOfLikes;
  String? createdAt;
  String? updatedAt;
  List<dynamic>? usersLiked;

  CommentModel({
    required this.imageUrl,
    required this.id,
    required this.user,
    required this.foodId,
    required this.storeId,
    required this.comment,
    required this.rating,
    required this.numberOfLikes,
    required this.createdAt,
    required this.updatedAt,
    required this.usersLiked
  });

  CommentModel.fromJson(Map<String, dynamic> json){
    try{
      imageUrl = List<String>.from(json['imageURL'] ?? []);
      id = json['_id'];
      user = UserComment.fromJson(json['user']);
      foodId = json['store'];
      storeId = json['food'];
      comment = json['comment'];
      rating = json['rating'];
      numberOfLikes = json['numberOfLikes'];
      createdAt = json['createdAt'];
      updatedAt = json['updatedAt'];
      usersLiked = json['usersLiked'];
    }catch(e){
      print("Error parsing comment Model: $e");
    }
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageURL'] = imageUrl;
    data['_id'] = id;
    data['user'] = user;
    data['store'] = storeId;
    data['food'] = foodId;
    data['comment'] = comment;
    data['rating'] = rating;
    data['numberOfLikes'] = numberOfLikes;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['usersLiked'] = usersLiked;
    return data;
  }
}

class UserComment {
  String? avt;
  String? id;
  String? name;

  UserComment({required this.avt, required this.id, required this.name});

  UserComment.fromJson(Map<String, dynamic> json) {
    try {
      avt = json['avt'];
      id = json['_id'];
      name = json['name'];
    } catch (e) {
      print("Error parsing user comment Model: $e");
    }
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avt'] = avt;
    data['_id'] = id;
    data['name'] = name;
    return data;
  }
}
