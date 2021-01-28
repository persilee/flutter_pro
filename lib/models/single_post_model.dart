import 'package:pro_flutter/models/post_model.dart';

/// code : 200
/// data : {"id":4,"content":"In dolor enim cupidatat sunt. Commodo ullamco ullamco aliqua amet voluptate magna esse mollit sit laborum enim ad ea occaecat. Aliqua enim sunt et exercitation enim reprehenderit nisi aute in. Quis excepteur nulla eu est voluptate deserunt et laborum labore tempor ipsum ad sunt.","title":"HIM","user":{"id":2,"name":"Mohamed Chahin","avatar":{"largeAvatarUrl":"https://api.lishaoy.net/avatar/2?size=large","smallAvatarUrl":"https://api.lishaoy.net/avatar/2?size=small","mediumAvatarUrl":"https://api.lishaoy.net/avatar/2?size=medium"}},"totalComments":null,"files":[{"id":5,"width":1600,"height":1200,"largeImageUrl":"https://api.lishaoy.net/files/5/serve?size=large","mediumImageUrl":"https://api.lishaoy.net/files/5/serve?size=medium","thumbnailImageUrl":"https://api.lishaoy.net/files/5/serve?size=thumbnail"}],"tags":null,"liked":1,"totalLikes":1}
/// message : "success"

class SinglePostModel {
  int _code;
  Post _data;
  String _message;

  int get code => _code;
  Post get data => _data;
  String get message => _message;

  SinglePostModel({
      int code, 
      Post data,
      String message}){
    _code = code;
    _data = data;
    _message = message;
}

  SinglePostModel.fromJson(dynamic json) {
    _code = json["code"];
    _data = json["data"] != null ? Post.fromJson(json["data"]) : null;
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