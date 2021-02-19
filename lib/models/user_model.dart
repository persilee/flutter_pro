/// code : 200
/// data : {"id":2,"name":"Mohamed Chahin","totalPosts":21,"avatar":{"largeAvatarUrl":"http://localhost:3001/avatar/2?size=large","smallAvatarUrl":"http://localhost:3001/avatar/2?size=small","mediumAvatarUrl":"http://localhost:3001/avatar/2?size=medium"}}
/// message : "success"

class UserModel {
  int _code;
  Data _data;
  String _message;

  int get code => _code;
  Data get data => _data;
  String get message => _message;

  UserModel({
      int code, 
      Data data, 
      String message}){
    _code = code;
    _data = data;
    _message = message;
}

  UserModel.fromJson(dynamic json) {
    _code = json["code"];
    _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["code"] = _code;
    if (_data != null) {
      map["data"] = _data.toJson();
    }
    map["message"] = _message;
    return map;
  }

}

/// id : 2
/// name : "Mohamed Chahin"
/// totalPosts : 21
/// avatar : {"largeAvatarUrl":"http://localhost:3001/avatar/2?size=large","smallAvatarUrl":"http://localhost:3001/avatar/2?size=small","mediumAvatarUrl":"http://localhost:3001/avatar/2?size=medium"}

class Data {
  int _id;
  String _name;
  int _totalPosts;
  Avatar _avatar;

  int get id => _id;
  String get name => _name;
  int get totalPosts => _totalPosts;
  Avatar get avatar => _avatar;

  Data({
      int id, 
      String name, 
      int totalPosts, 
      Avatar avatar}){
    _id = id;
    _name = name;
    _totalPosts = totalPosts;
    _avatar = avatar;
}

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _totalPosts = json["totalPosts"];
    _avatar = json["avatar"] != null ? Avatar.fromJson(json["avatar"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["totalPosts"] = _totalPosts;
    if (_avatar != null) {
      map["avatar"] = _avatar.toJson();
    }
    return map;
  }

}

/// largeAvatarUrl : "http://localhost:3001/avatar/2?size=large"
/// smallAvatarUrl : "http://localhost:3001/avatar/2?size=small"
/// mediumAvatarUrl : "http://localhost:3001/avatar/2?size=medium"

class Avatar {
  String _largeAvatarUrl;
  String _smallAvatarUrl;
  String _mediumAvatarUrl;

  String get largeAvatarUrl => _largeAvatarUrl;
  String get smallAvatarUrl => _smallAvatarUrl;
  String get mediumAvatarUrl => _mediumAvatarUrl;

  Avatar({
      String largeAvatarUrl, 
      String smallAvatarUrl, 
      String mediumAvatarUrl}){
    _largeAvatarUrl = largeAvatarUrl;
    _smallAvatarUrl = smallAvatarUrl;
    _mediumAvatarUrl = mediumAvatarUrl;
}

  Avatar.fromJson(dynamic json) {
    _largeAvatarUrl = json["largeAvatarUrl"];
    _smallAvatarUrl = json["smallAvatarUrl"];
    _mediumAvatarUrl = json["mediumAvatarUrl"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["largeAvatarUrl"] = _largeAvatarUrl;
    map["smallAvatarUrl"] = _smallAvatarUrl;
    map["mediumAvatarUrl"] = _mediumAvatarUrl;
    return map;
  }

}