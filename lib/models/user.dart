class UserModel {
  String? id;
  String? name;
  String? email;
  String? accessToken;
  String? refreshToken;

  UserModel({this.id, this.name, this.email, this.accessToken, this.refreshToken});

  UserModel.fromJson(Map<String, dynamic> json) {
    try{
      id = json['_id'] ;
      name = json['name'];
      email = json['email'];
      accessToken = json['accessToken'];
      refreshToken = json['refreshToken'];
    }catch(e){
      print("Error parsing user model: $e");

    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    return data;
  }

//cho sqlite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      accessToken: map['accessToken'],
      refreshToken: map['refreshToken'],
    );
  }
}