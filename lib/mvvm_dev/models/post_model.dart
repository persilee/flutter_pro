import 'package:equatable/equatable.dart';

import 'data.dart';

class PostModel extends Equatable {
  final int code;
  final Data data;
  final String message;

  const PostModel({
    this.code,
    this.data,
    this.message,
  });

  @override
  String toString() {
    return 'BaseModel(code: $code, data: $data, message: $message)';
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      code: json['code'] as int,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
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
    Data data,
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
