class TokenModel{
  String? accessToken;
  int? timeExpired;
  TokenModel({ this.accessToken, this.timeExpired});


  TokenModel.fromJson(Map<String, dynamic> json){
    try{
      accessToken = json['accessToken'];
      timeExpired = json['timeExpired'];
    }catch(e){
      print("Error parsing token model: $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['timeExpired'] = timeExpired;
    return data;
  }
}