// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  PostModel({
    this.code,
    this.data,
    this.message,
  });

  int code;
  Data data;
  String message;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        code: json["code"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data.toJson(),
        "message": message,
      };
}

class Data {
  Data({
    this.total,
    this.posts,
  });

  int total;
  List<Post> posts;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        total: json["total"],
        posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
      };
}

/// id : 4
/// content : "In dolor enim cupidatat sunt. Commodo ullamco ullamco aliqua amet voluptate magna esse mollit sit laborum enim ad ea occaecat. Aliqua enim sunt et exercitation enim reprehenderit nisi aute in. Quis excepteur nulla eu est voluptate deserunt et laborum labore tempor ipsum ad sunt."
/// title : "HIM"
/// user : {"id":2,"name":"Mohamed Chahin","avatar":{"largeAvatarUrl":"https://api.lishaoy.net/avatar/2?size=large","smallAvatarUrl":"https://api.lishaoy.net/avatar/2?size=small","mediumAvatarUrl":"https://api.lishaoy.net/avatar/2?size=medium"}}
/// totalComments : null
/// files : [{"id":5,"width":1600,"height":1200,"largeImageUrl":"https://api.lishaoy.net/files/5/serve?size=large","mediumImageUrl":"https://api.lishaoy.net/files/5/serve?size=medium","thumbnailImageUrl":"https://api.lishaoy.net/files/5/serve?size=thumbnail"}]
/// tags : null
/// liked : 1
/// totalLikes : 1

class Post {
  int _id;
  String _content;
  String _title;
  String _category;
  int _views;
  String _createdAt;
  String _updatedAt;
  User _user;
  dynamic _totalComments;
  CoverImage _coverImage;
  List<Files> _files;
  dynamic _tags;
  int _liked;
  int _totalLikes;

  int get id => _id;
  String get content => _content;
  int get views => _views;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get title => _title;
  String get category => _category;
  User get user => _user;
  dynamic get totalComments => _totalComments;
  CoverImage get coverImage => _coverImage;
  List<Files> get files => _files;
  dynamic get tags => _tags;
  int get liked => _liked;
  int get totalLikes => _totalLikes;

  Post({
    int id,
    String content,
    String title,
    String category,
    int views,
    String createdAt,
    String updatedAt,
    User user,
    dynamic totalComments,
    CoverImage coverImage,
    List<Files> files,
    dynamic tags,
    int liked,
    int totalLikes}){
    _id = id;
    _content = content;
    _title = title;
    _category = category;
    _views = views;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _user = user;
    _totalComments = totalComments;
    _coverImage = coverImage;
    _files = files;
    _tags = tags;
    _liked = liked;
    _totalLikes = totalLikes;
  }

  Post.fromJson(dynamic json) {
    _id = json["id"];
    _content = json["content"];
    _title = json["title"];
    _category = json["category"];
    _views = json["views"];
    _createdAt = json["createdAt"];
    _updatedAt = json["updatedAt"];
    _user = json["user"] != null ? User.fromJson(json["user"]) : null;
    _totalComments = json["totalComments"];
    _coverImage = json["coverImage"] != null ? CoverImage.fromJson(json["coverImage"]) : null;
    if (json["files"] != null) {
      _files = [];
      json["files"].forEach((v) {
        _files.add(Files.fromJson(v));
      });
    }
    _tags = json["tags"];
    _liked = json["liked"];
    _totalLikes = json["totalLikes"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["content"] = _content;
    map["title"] = _title;
    map["category"] = category;
    map["views"] = _views;
    map["createdAt"] = _createdAt;
    map["updatedAt"] = _updatedAt;
    if (_user != null) {
      map["user"] = _user.toJson();
    }
    map["totalComments"] = _totalComments;
    if (_coverImage != null) {
      map["coverImage"] = _coverImage.toJson();
    }
    if (_files != null) {
      map["files"] = _files.map((v) => v.toJson()).toList();
    }
    map["tags"] = _tags;
    map["liked"] = _liked;
    map["totalLikes"] = _totalLikes;
    return map;
  }

}

/// id : 5
/// width : 1600
/// height : 1200
/// largeImageUrl : "https://api.lishaoy.net/files/5/serve?size=large"
/// mediumImageUrl : "https://api.lishaoy.net/files/5/serve?size=medium"
/// thumbnailImageUrl : "https://api.lishaoy.net/files/5/serve?size=thumbnail"

class Files {
  int _id;
  int _width;
  int _height;
  String _largeImageUrl;
  String _mediumImageUrl;
  String _thumbnailImageUrl;

  int get id => _id;
  int get width => _width;
  int get height => _height;
  String get largeImageUrl => _largeImageUrl;
  String get mediumImageUrl => _mediumImageUrl;
  String get thumbnailImageUrl => _thumbnailImageUrl;

  Files({
    int id,
    int width,
    int height,
    String largeImageUrl,
    String mediumImageUrl,
    String thumbnailImageUrl}){
    _id = id;
    _width = width;
    _height = height;
    _largeImageUrl = largeImageUrl;
    _mediumImageUrl = mediumImageUrl;
    _thumbnailImageUrl = thumbnailImageUrl;
  }

  Files.fromJson(dynamic json) {
    _id = json["id"];
    _width = json["width"];
    _height = json["height"];
    _largeImageUrl = json["largeImageUrl"];
    _mediumImageUrl = json["mediumImageUrl"];
    _thumbnailImageUrl = json["thumbnailImageUrl"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["width"] = _width;
    map["height"] = _height;
    map["largeImageUrl"] = _largeImageUrl;
    map["mediumImageUrl"] = _mediumImageUrl;
    map["thumbnailImageUrl"] = _thumbnailImageUrl;
    return map;
  }

}

/// id : 374
/// small : "http://localhost:3001/files/374/serve?size=thumbnail"
/// width : 800
/// height : 600
/// largeImageUrl : "http://localhost:3001/files/374/serve?size=large"
/// mediumImageUrl : "http://localhost:3001/files/374/serve?size=medium"

class CoverImage {
  int _id;
  String _small;
  int _width;
  int _height;
  String _largeImageUrl;
  String _mediumImageUrl;

  int get id => _id;
  String get small => _small;
  int get width => _width;
  int get height => _height;
  String get largeImageUrl => _largeImageUrl;
  String get mediumImageUrl => _mediumImageUrl;

  CoverImage({
    int id,
    String small,
    int width,
    int height,
    String largeImageUrl,
    String mediumImageUrl}){
    _id = id;
    _small = small;
    _width = width;
    _height = height;
    _largeImageUrl = largeImageUrl;
    _mediumImageUrl = mediumImageUrl;
  }

  CoverImage.fromJson(dynamic json) {
    _id = json["id"];
    _small = json["small"];
    _width = json["width"];
    _height = json["height"];
    _largeImageUrl = json["largeImageUrl"];
    _mediumImageUrl = json["mediumImageUrl"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["small"] = _small;
    map["width"] = _width;
    map["height"] = _height;
    map["largeImageUrl"] = _largeImageUrl;
    map["mediumImageUrl"] = _mediumImageUrl;
    return map;
  }

}

/// id : 2
/// name : "Mohamed Chahin"
/// avatar : {"largeAvatarUrl":"https://api.lishaoy.net/avatar/2?size=large","smallAvatarUrl":"https://api.lishaoy.net/avatar/2?size=small","mediumAvatarUrl":"https://api.lishaoy.net/avatar/2?size=medium"}

class User {
  int _id;
  String _name;
  Avatar _avatar;

  int get id => _id;
  String get name => _name;
  Avatar get avatar => _avatar;

  User({
    int id,
    String name,
    Avatar avatar}){
    _id = id;
    _name = name;
    _avatar = avatar;
  }

  User.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _avatar = json["avatar"] != null ? Avatar.fromJson(json["avatar"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    if (_avatar != null) {
      map["avatar"] = _avatar.toJson();
    }
    return map;
  }

}

/// largeAvatarUrl : "https://api.lishaoy.net/avatar/2?size=large"
/// smallAvatarUrl : "https://api.lishaoy.net/avatar/2?size=small"
/// mediumAvatarUrl : "https://api.lishaoy.net/avatar/2?size=medium"

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
