abstract class BaseError {
  final int code;
  final String message;

  BaseError({this.code, this.message});
}

class NeedLogin implements BaseError {
  @override
  int get code => 401;

  @override
  String get message => "请先登录";
}

class NeedAuth implements BaseError {
  @override
  int get code => 403;

  @override
  String get message => "非法访问，请使用正确的token";
}

class UserNotExist implements BaseError {
  @override
  int get code => 408;

  @override
  String get message => "用户不存在";
}

class UserNameEmpty implements BaseError {
  @override
  int get code => 405;

  @override
  String get message => "用户名不能为空";
}

class PwdNotMatch implements BaseError {
  @override
  int get code => 409;

  @override
  String get message => "用户密码不正确";
}

class PwdEmpty implements BaseError {
  @override
  int get code => 406;

  @override
  String get message => "用户密码不能为空";
}

class OtherError implements BaseError {

  final int statusCode;
  final String statusMessage;

  OtherError({this.statusCode, this.statusMessage});

  @override
  int get code => statusCode;

  @override
  String get message => statusMessage;

}
