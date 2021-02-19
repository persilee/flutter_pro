import 'package:dio/dio.dart';

import 'package:pro_flutter/http/base_dio.dart';
import 'package:pro_flutter/models/base_model.dart';
import 'package:pro_flutter/models/category_model.dart';
import 'package:pro_flutter/models/comments_posts_model.dart';
import 'package:pro_flutter/models/login_model.dart';
import 'package:pro_flutter/models/post_model.dart';
import 'package:pro_flutter/models/single_post_model.dart';
import 'package:pro_flutter/models/user_model.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: 'https://api.lishaoy.net')
abstract class ApiClient {
  factory ApiClient({Dio dio, String baseUrl}) {
    dio ??= BaseDio.getInstance().getDio();
    return _ApiClient(dio, baseUrl: baseUrl);
  }

  /**
   * 获取首页推荐文章
   */
  @GET('/posts')
  Future<PostModel> getPosts(
      @Query('pageIndex') String pageIndex, @Query('pageSize') String pageSize,
      {@Query('sort') String sort = 'recommend'});

  /**
   * 获取文章详情
   */
  @GET('/posts/{postId}')
  Future<SinglePostModel> getPostsById(@Path('postId') int postId,
      {@Query('notView') bool notView});

  /**
   * 登录
   */
  @POST('/login')
  Future<LoginModel> login(@Body() Login login);

  /**
   * 点赞
   */
  @POST('/posts/{postId}/like')
  Future<BaseModel> like(@Path('postId') int postId);

  /**
   * 获取分类
   */
  @GET('/category')
  Future<CategoryModel> getCategory();

  /**
   * 根据分类获取文章列表
   */
  @GET('/posts')
  Future<PostModel> getPostsByCategoryId(@Query('pageIndex') String pageIndex,
      @Query('pageSize') String pageSize, @Query('categoryId') int categoryId,
      {@Query('action') String action = 'category'});

  /**
   * 获取用户其他文章列表
   */
  @GET('/posts')
  Future<PostModel> getPostsByUser(@Query('user') int userId,
      {@Query('action') String action = 'published'});

  /**
   * 获取文章评论
   */
  @GET('/comments')
  Future<CommentsPostsModel> getPostsComments(@Query('post') int post);

  /**
   * 创建文章评论
   */
  @POST('/comments')
  Future<BaseModel> createPostsComments(@Body() Map<String, dynamic> comment);

  /**
   * 创建回复文章评论
   */
  @POST('/comments/{commentId}/reply')
  Future<BaseModel> createPostsRepComments(
      @Body() Map<String, dynamic> comment, @Path('commentId') int commentId);

/**
 * 获取用户信息
 */
  @GET('/users/{userId}')
  Future<UserModel> getUserInfo(@Path('userId') int userId);
}
