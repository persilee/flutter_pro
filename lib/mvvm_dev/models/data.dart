import 'package:equatable/equatable.dart';

import 'files.dart';
import 'user.dart';

class Data extends Equatable {
  final int id;
  final String content;
  final String title;
  final List<User> user;
  final String totalComments;
  final List<Files> files;
  final String tags;
  final int totalLikes;

  const Data({
    this.id,
    this.content,
    this.title,
    this.user,
    this.totalComments,
    this.files,
    this.tags,
    this.totalLikes,
  });

  @override
  String toString() {
    return 'Data(id: $id, content: $content, title: $title, user: $user, totalComments: $totalComments, files: $files, tags: $tags, totalLikes: $totalLikes)';
  }

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'] as int,
      content: json['content'] as String,
      title: json['title'] as String,
      user: (json['user'] as List<User>)?.map((e) {
        return e == null ? null : User.fromJson(e as Map<String, dynamic>);
      })?.toList(),
      totalComments: json['totalComments'] as String,
      files: (json['files'] as List<Files>)?.map((e) {
        return e == null ? null : Files.fromJson(e as Map<String, dynamic>);
      })?.toList(),
      tags: json['tags'] as String,
      totalLikes: json['totalLikes'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'title': title,
      'user': user?.map((e) => e?.toJson())?.toList(),
      'totalComments': totalComments,
      'files': files?.map((e) => e?.toJson())?.toList(),
      'tags': tags,
      'totalLikes': totalLikes,
    };
  }

  Data copyWith({
    int id,
    String content,
    String title,
    List<User> user,
    String totalComments,
    List<Files> files,
    String tags,
    int totalLikes,
  }) {
    return Data(
      id: id ?? this.id,
      content: content ?? this.content,
      title: title ?? this.title,
      user: user ?? this.user,
      totalComments: totalComments ?? this.totalComments,
      files: files ?? this.files,
      tags: tags ?? this.tags,
      totalLikes: totalLikes ?? this.totalLikes,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      content,
      title,
      user,
      totalComments,
      files,
      tags,
      totalLikes,
    ];
  }
}
