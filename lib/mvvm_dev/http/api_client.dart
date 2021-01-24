import 'package:dio/dio.dart';
import 'package:pro_flutter/mvvm_dev/models/post_model.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: 'https://api.lishaoy.net')
abstract class ApiClient {
  factory ApiClient({Dio dio, String baseUrl}) {
    return _ApiClient(dio, baseUrl: baseUrl);
  }

  @GET('/posts')
  Future<PostModel> getPosts(
      @Query('pageIndex') String pageIndex, @Query('pageSize') String pageSize);
}
