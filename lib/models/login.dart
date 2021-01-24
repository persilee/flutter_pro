import 'package:equatable/equatable.dart';

class Login extends Equatable {
  final int id;
  final String name;
  final String token;

  const Login({
    this.id,
    this.name,
    this.token,
  });

  @override
  String toString() {
    return 'Login(id: $id, name: $name, token: $token)';
  }

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      id: json['id'] as int,
      name: json['name'] as String,
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'token': token,
    };
  }

  Login copyWith({
    int id,
    String name,
    String token,
  }) {
    return Login(
      id: id ?? this.id,
      name: name ?? this.name,
      token: token ?? this.token,
    );
  }

  @override
  List<Object> get props => [id, name, token];
}
