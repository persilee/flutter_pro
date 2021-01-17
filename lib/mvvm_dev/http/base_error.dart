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

class OtherError implements BaseError {

  final int statusCode;
  final String statusMessage;

  OtherError({this.statusCode, this.statusMessage});

  @override
  int get code => statusCode;

  @override
  String get message => statusMessage;

}
