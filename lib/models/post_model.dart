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

class Post {
  Post({
    this.id,
    this.content,
    this.title,
    this.user,
    this.totalComments,
    this.files,
    this.tags,
    this.totalLikes,
  });

  int id;
  String content;
  String title;
  User user;
  dynamic totalComments;
  List<FileElement> files;
  dynamic tags;
  int totalLikes;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        content: json["content"],
        title: json["title"],
        user: User.fromJson(json["user"]),
        totalComments: json["totalComments"],
        files: List<FileElement>.from(
            json["files"].map((x) => FileElement.fromJson(x))),
        tags: json["tags"],
        totalLikes: json["totalLikes"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "title": title,
        "user": user.toJson(),
        "totalComments": totalComments,
        "files": List<dynamic>.from(files.map((x) => x.toJson())),
        "tags": tags,
        "totalLikes": totalLikes,
      };
}

class FileElement {
  FileElement({
    this.id,
    this.width,
    this.height,
    this.largeImageUrl,
    this.mediumImageUrl,
    this.thumbnailImageUrl,
  });

  int id;
  int width;
  int height;
  String largeImageUrl;
  String mediumImageUrl;
  String thumbnailImageUrl;

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        id: json["id"],
        width: json["width"],
        height: json["height"],
        largeImageUrl: json["largeImageUrl"],
        mediumImageUrl: json["mediumImageUrl"],
        thumbnailImageUrl: json["thumbnailImageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "width": width,
        "height": height,
        "largeImageUrl": largeImageUrl,
        "mediumImageUrl": mediumImageUrl,
        "thumbnailImageUrl": thumbnailImageUrl,
      };
}

class User {
  User({
    this.id,
    this.name,
    this.avatar,
  });

  int id;
  Name name;
  Avatar avatar;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: nameValues.map[json["name"]],
        avatar: Avatar.fromJson(json["avatar"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "avatar": avatar.toJson(),
      };
}

class Avatar {
  Avatar({
    this.largeAvatarUrl,
    this.smallAvatarUrl,
    this.mediumAvatarUrl,
  });

  String largeAvatarUrl;
  String smallAvatarUrl;
  String mediumAvatarUrl;

  factory Avatar.fromJson(Map<String, dynamic> json) => Avatar(
        largeAvatarUrl: json["largeAvatarUrl"],
        smallAvatarUrl: json["smallAvatarUrl"],
        mediumAvatarUrl: json["mediumAvatarUrl"],
      );

  Map<String, dynamic> toJson() => {
        "largeAvatarUrl": largeAvatarUrl,
        "smallAvatarUrl": smallAvatarUrl,
        "mediumAvatarUrl": mediumAvatarUrl,
      };
}

enum Name { MOHAMED_CHAHIN }

final nameValues = EnumValues({"Mohamed Chahin": Name.MOHAMED_CHAHIN});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
