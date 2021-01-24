import 'package:equatable/equatable.dart';

import 'post.dart';

class PostModel extends Equatable {
  final int code;
  final Post data;
  final String message;

  const PostModel({
    this.code,
    this.data,
    this.message,
  });

  @override
  String toString() {
    return 'PostModel(code: $code, data: $data, message: $message)';
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      code: json['code'] as int,
      data: json['data'] == null
          ? null
          : Post.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'data': data?.toJson(),
      'message': message,
    };
  }

  PostModel copyWith({
    int code,
    Post data,
    String message,
  }) {
    return PostModel(
      code: code ?? this.code,
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [code, data, message];
}
