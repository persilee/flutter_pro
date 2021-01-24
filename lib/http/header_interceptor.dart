import 'package:dio/dio.dart';
import 'package:sp_util/sp_util.dart';

class HeaderInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options) async {
    String headers = await SpUtil.getString('authorization');
    options.headers.addAll({'authorization': headers});

    return options;
  }
}
