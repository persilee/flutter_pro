import 'package:dio/dio.dart';
import 'package:pro_flutter/http/base_dio.dart';
import 'package:pro_flutter/models/base_model.dart';
import 'package:pro_flutter/models/login_model.dart';
import 'package:pro_flutter/models/post_model.dart';
import 'package:pro_flutter/models/single_post_model.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: 'https://api.lishaoy.net')
abstract class ApiClient {
  factory ApiClient({Dio dio, String baseUrl}) {
    dio ??= BaseDio.getInstance().getDio();
    return _ApiClient(dio, baseUrl: baseUrl);
  }

  @GET('/posts')
  Future<PostModel> getPosts(
      @Query('pageIndex') String pageIndex, @Query('pageSize') String pageSize);

  @GET('/posts/{postId}')
  Future<SinglePostModel> getPostsById(@Path('postId') int postId,
      {@Body() Map<String, dynamic> map});

  @POST('/login')
  Future<LoginModel> login(@Body() Login login);

  @POST('/posts/{postId}/like')
  Future<BaseModel> like(@Path('postId') int postId);
}
