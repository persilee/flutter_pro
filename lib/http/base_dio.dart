import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:pro_flutter/http/base_error.dart';
import 'package:pro_flutter/http/header_interceptor.dart';
import 'package:pro_flutter/models/base_model.dart';

class BaseDio {
  BaseDio._();

  static BaseDio _instance;

  static BaseDio getInstance() {
    _instance ??= BaseDio._();

    return _instance;
  }

  Dio getDio() {
    final Dio dio = Dio();
    dio.options = BaseOptions(receiveTimeout: 66000, connectTimeout: 66000);
    dio.interceptors.add(HeaderInterceptor());
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    ));

    return dio;
  }

  BaseError getDioError(Object obj) {
    switch (obj.runtimeType) {
      case DioError:
        if ((obj as DioError).type == DioErrorType.RESPONSE) {
          final response = (obj as DioError).response;
          if (response.statusCode == 401) {
            return NeedLogin();
          } else if (response.statusCode == 403) {
            return NeedAuth();
          } else if (response.statusCode == 408) {
            return UserNotExist();
          } else if (response.statusCode == 409) {
            return PwdNotMatch();
          } else if (response.statusCode == 405) {
            return UserNameEmpty();
          } else if (response.statusCode == 406) {
            return PwdEmpty();
          } else {
            return OtherError(
              statusCode: response.statusCode,
              statusMessage: response.statusMessage,
            );
          }
        }
    }

    return OtherError();
  }
}
