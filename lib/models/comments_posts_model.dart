/// code : 200
/// data : {"total":3,"comments":[{"id":2,"content":"哈哈 : )","repComment":{"content":"这个卷心菜好酷~ 🥬 ","userName":"persilee"},"createdAt":"2021-02-09T21:02:22.000Z","updatedAt":"2021-02-10T21:02:22.000Z","user":{"id":6,"name":"翠花小拍","avatar":{"largeAvatarUrl":"https://api.lishaoy.net/avatar/6?size=large","smallAvatarUrl":"https://api.lishaoy.net/avatar/6?size=small","mediumAvatarUrl":"https://api.lishaoy.net/avatar/6?size=medium"}},"postInfo":{"id":82,"title":"创意摄影#2"},"totalReplies":0}]}
/// message : "success"

class CommentsPostsModel {
  int _code;
  Data _data;
  String _message;

  int get code => _code;
  Data get data => _data;
  String get message => _message;

  CommentsPostsModel({
      int code, 
      Data data, 
      String message}){
    _code = code;
    _data = data;
    _message = message;
}

  CommentsPostsModel.fromJson(dynamic json) {
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

/// total : 3
/// comments : [{"id":2,"content":"哈哈 : )","repComment":{"content":"这个卷心菜好酷~ 🥬 ","userName":"persilee"},"createdAt":"2021-02-09T21:02:22.000Z","updatedAt":"2021-02-10T21:02:22.000Z","user":{"id":6,"name":"翠花小拍","avatar":{"largeAvatarUrl":"https://api.lishaoy.net/avatar/6?size=large","smallAvatarUrl":"https://api.lishaoy.net/avatar/6?size=small","mediumAvatarUrl":"https://api.lishaoy.net/avatar/6?size=medium"}},"postInfo":{"id":82,"title":"创意摄影#2"},"totalReplies":0}]

class Data {
  int _total;
  List<Comments> _comments;

  int get total => _total;
  List<Comments> get comments => _comments;

  Data({
      int total, 
      List<Comments> comments}){
    _total = total;
    _comments = comments;
}

  Data.fromJson(dynamic json) {
    _total = json["total"];
    if (json["comments"] != null) {
      _comments = [];
      json["comments"].forEach((v) {
        _comments.add(Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["total"] = _total;
    if (_comments != null) {
      map["comments"] = _comments.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 2
/// content : "哈哈 : )"
/// repComment : {"content":"这个卷心菜好酷~ 🥬 ","userName":"persilee"}
/// createdAt : "2021-02-09T21:02:22.000Z"
/// updatedAt : "2021-02-10T21:02:22.000Z"
/// user : {"id":6,"name":"翠花小拍","avatar":{"largeAvatarUrl":"https://api.lishaoy.net/avatar/6?size=large","smallAvatarUrl":"https://api.lishaoy.net/avatar/6?size=small","mediumAvatarUrl":"https://api.lishaoy.net/avatar/6?size=medium"}}
/// postInfo : {"id":82,"title":"创意摄影#2"}
/// totalReplies : 0

class Comments {
  int _id;
  String _content;
  RepComment _repComment;
  String _createdAt;
  String _updatedAt;
  User _user;
  PostInfo _postInfo;
  int _totalReplies;

  int get id => _id;
  String get content => _content;
  RepComment get repComment => _repComment;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  User get user => _user;
  PostInfo get postInfo => _postInfo;
  int get totalReplies => _totalReplies;

  Comments({
      int id, 
      String content, 
      RepComment repComment, 
      String createdAt, 
      String updatedAt, 
      User user, 
      PostInfo postInfo, 
      int totalReplies}){
    _id = id;
    _content = content;
    _repComment = repComment;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _user = user;
    _postInfo = postInfo;
    _totalReplies = totalReplies;
}

  Comments.fromJson(dynamic json) {
    _id = json["id"];
    _content = json["content"];
    _repComment = json["repComment"] != null ? RepComment.fromJson(json["repComment"]) : null;
    _createdAt = json["createdAt"];
    _updatedAt = json["updatedAt"];
    _user = json["user"] != null ? User.fromJson(json["user"]) : null;
    _postInfo = json["postInfo"] != null ? PostInfo.fromJson(json["postInfo"]) : null;
    _totalReplies = json["totalReplies"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["content"] = _content;
    if (_repComment != null) {
      map["repComment"] = _repComment.toJson();
    }
    map["createdAt"] = _createdAt;
    map["updatedAt"] = _updatedAt;
    if (_user != null) {
      map["user"] = _user.toJson();
    }
    if (_postInfo != null) {
      map["postInfo"] = _postInfo.toJson();
    }
    map["totalReplies"] = _totalReplies;
    return map;
  }

}

/// id : 82
/// title : "创意摄影#2"

class PostInfo {
  int _id;
  String _title;

  int get id => _id;
  String get title => _title;

  PostInfo({
      int id, 
      String title}){
    _id = id;
    _title = title;
}

  PostInfo.fromJson(dynamic json) {
    _id = json["id"];
    _title = json["title"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["title"] = _title;
    return map;
  }

}

/// id : 6
/// name : "翠花小拍"
/// avatar : {"largeAvatarUrl":"https://api.lishaoy.net/avatar/6?size=large","smallAvatarUrl":"https://api.lishaoy.net/avatar/6?size=small","mediumAvatarUrl":"https://api.lishaoy.net/avatar/6?size=medium"}

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

/// largeAvatarUrl : "https://api.lishaoy.net/avatar/6?size=large"
/// smallAvatarUrl : "https://api.lishaoy.net/avatar/6?size=small"
/// mediumAvatarUrl : "https://api.lishaoy.net/avatar/6?size=medium"

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

/// content : "这个卷心菜好酷~ 🥬 "
/// userName : "persilee"

class RepComment {
  String _content;
  String _userName;

  String get content => _content;
  String get userName => _userName;

  RepComment({
      String content, 
      String userName}){
    _content = content;
    _userName = userName;
}

  RepComment.fromJson(dynamic json) {
    _content = json["content"];
    _userName = json["userName"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["content"] = _content;
    map["userName"] = _userName;
    return map;
  }

}