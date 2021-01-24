import 'package:equatable/equatable.dart';

import 'login.dart';

class LoginModel extends Equatable {
  final int code;
  final Login data;
  final String message;

  const LoginModel({
    this.code,
    this.data,
    this.message,
  });

  @override
  String toString() {
    return 'LoginModel(code: $code, data: $data, message: $message)';
  }

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      code: json['code'] as int,
      data: json['data'] == null
          ? null
          : Login.fromJson(json['data'] as Map<String, dynamic>),
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

  LoginModel copyWith({
    int code,
    Login data,
    String message,
  }) {
    return LoginModel(
      code: code ?? this.code,
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [code, data, message];
}
