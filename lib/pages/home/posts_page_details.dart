import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:lottie/lottie.dart';
import 'package:pro_flutter/models/comments_posts_model.dart';
import 'package:pro_flutter/models/details_params.dart';
import 'package:pro_flutter/models/post_model.dart';
import 'package:pro_flutter/utils/date_util.dart';
import 'package:pro_flutter/utils/screen_util.dart';
import 'package:pro_flutter/utils/status_bar_util.dart';
import 'package:pro_flutter/utils/timeline_util.dart';
import 'package:pro_flutter/view_model/details_view_model.dart';
import 'package:pro_flutter/widgets/cache_image.dart';
import 'package:pro_flutter/widgets/icon_animation_widget.dart';
import 'package:pro_flutter/widgets/iconfont.dart';
import 'package:pro_flutter/widgets/image_paper.dart';
import 'package:pro_flutter/widgets/over_scroll_behavior.dart';
import 'package:pro_flutter/widgets/page_state.dart';
import 'package:transparent_image/transparent_image.dart';

final postsDetailsProvider = StateNotifierProvider.autoDispose
    .family<DetailsViewModel, DetailsParams>((ref, params) {
  ref.onDispose(() => StatusBarUtil.setStatusBar(Brightness.dark));
  return DetailsViewModel(params);
});

class PostsPageDetails extends StatefulWidget {
  final int postId;
  final int userId;

  PostsPageDetails({@required this.postId, @required this.userId});

  @override
  _PostsPageDetailsState createState() => _PostsPageDetailsState();
}

class _PostsPageDetailsState extends State<PostsPageDetails>
    with WidgetsBindingObserver {
  double imageHeight;
  bool isShowBottomBar = true;
  Duration duration = Duration(milliseconds: 360);
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels > imageHeight - 56) {
        setState(() {
          isShowBottomBar = false;
        });
      } else {
        setState(() {
          isShowBottomBar = true;
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatusBarUtil.setStatusBar(Brightness.light);

    return Scaffold(
      body: Consumer(builder: (context, watch, _) {
        final detailsState = watch(postsDetailsProvider(
                DetailsParams(userId: widget.userId, postId: widget.postId))
            .state);
        return _createContent(detailsState, context);
      }),
    );
  }

  Widget _createContent(DetailsState detailsState, BuildContext context) {
    if (detailsState.pageState == PageState.busyState ||
        detailsState.pageState == PageState.initializedState) {
      return Center(
        child: Lottie.asset(
          'assets/json/loading2.json',
          width: 126,
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      );
    }

    final size = MediaQuery.of(context).size;

    /// 当前文章数据
    final post = detailsState?.post;

    /// 其他文章数据
    final restPosts = detailsState?.restPosts;

    /// 评论数据
    final comments = detailsState?.comments;

    /// 如果当前文章在其他作品中，就过滤掉当前作品
    var postIndex = -1;
    restPosts.forEach((element) {
      if (element.id == post.id) {
        postIndex = restPosts.indexOf(element);
      }
    });
    if (postIndex >= 0) {
      restPosts.removeAt(postIndex);
    }

    /// 在图片未加载出之前，计算出图片的高度
    imageHeight = post?.coverImage != null
        ? post.coverImage.height / (post.coverImage.width / size.width)
        : 0;

    return Container(
      height: size.height,
      child: Stack(
        children: [
          ScrollConfiguration(
            /// 取消滑动越界水波纹
            behavior: OverScrollBehavior(),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  Stack(
                    overflow: Overflow.visible,
                    children: [
                      /// 创建封面图片
                      _createCoverImage(post),

                      /// 创建高斯模糊渐变效果遮罩
                      _createBackdropFilter(imageHeight, post, size),
                    ],
                  ),

                  /// 创建文本区域(标题、描述等)
                  _createText(post),

                  /// 创建图片区域
                  _createImage(post),

                  /// 其他作品标题
                  restPosts.isNotEmpty ? _createRestTitle() : Container(),

                  /// 其他作品内容
                  restPosts.isNotEmpty
                      ? _createRestImage(restPosts)
                      : Container(),

                  /// 创建评论标题
                  _createCommentTitle(post),

                  /// 暂无评论缺省页
                  post.totalComments == null
                      ? _createNoComment()
                      : _createComment(comments),
                  Container(
                    height: 36,
                  ),
                ],
              ),
            ),
          ),
          isShowBottomBar
              ? _createAppBar(size, context, isShowBottomBar)
              : _createLightAppBar(size, context, post),
          _createBottomBar(size, post),
        ],
      ),
    );
  }

  Container _createComment(List<Comments> comments) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          ...comments.map((comment) {
            /// 时间格式化
            String timeline = TimelineUtil.format(
                DateUtil.getDateMsByTimeStr(comment.createdAt),
                locTimeMs: DateTime.now().millisecondsSinceEpoch,
                locale: 'zh',
                dayFormat: DayFormat.Common);
            return Container(
              padding: EdgeInsets.only(bottom: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40.0,
                    child: Row(
                      children: [
                        ClipOval(
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: comment.user.avatar.mediumAvatarUrl,
                            fit: BoxFit.cover,
                            width: 38.0,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(right: 6)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              comment.user.name,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'SourceHanSans',
                              ),
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              timeline,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'SourceHanSans',
                              ),
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 12, left: 44),
                    child: Text(
                      comment.content,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'SourceHanSans',
                      ),
                      textAlign: TextAlign.start,
                      softWrap: true,
                    ),
                  ),
                  comment.repComment != null ?
                  Container(
                    padding: EdgeInsets.only(top: 12, right: 10),
                    child: Row(
                      children: [
                        SizedBox(width: 44,),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(top: 16, left: 10, bottom: 16,),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.grey.withOpacity(0.12),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  '@${comment.repComment.userName}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SourceHanSans',
                                  ),
                                  textAlign: TextAlign.start,
                                  softWrap: true,
                                ),
                                Padding(padding: EdgeInsets.only(right: 6)),
                                Text(
                                  comment.repComment.content,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SourceHanSans',
                                  ),
                                  textAlign: TextAlign.start,
                                  softWrap: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ) : Container(),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Column _createNoComment() {
    return Column(
      children: [
        Container(
          height: 36,
          padding: EdgeInsets.only(bottom: 26),
          // width: ScreenUtil.instance.width * 0.36,
          // child: Image.asset('assets/images/noComment.png', fit: BoxFit.cover,),
        ),
        Text(
          '暂无评论',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade400,
            letterSpacing: 3.6,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Container _createCommentTitle(Post post) {
    return Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Text(
            post.totalComments != null ? post.totalComments.toString() : '0',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
              fontFamily: 'SourceHanSans',
            ),
            textAlign: TextAlign.start,
          ),
          Padding(padding: EdgeInsets.only(right: 4)),
          Text(
            '条评论',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
              fontFamily: 'SourceHanSans',
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }

  Container _createRestImage(List<Post> restPosts) {
    return Container(
      height: 156,
      child: ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) {
            return Padding(padding: EdgeInsets.only(right: 10));
          },
          padding: EdgeInsets.all(10),
          itemCount: restPosts.length,
          itemBuilder: (BuildContext context, int index) {
            return AspectRatio(
              aspectRatio: 3 / 2,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => PostsPageDetails(
                            postId: restPosts[index].id,
                            userId: restPosts[index].user.id,
                          )));
                },
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 9.0,
                        spreadRadius: 0.6,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: CacheImage(
                      url: restPosts[index].coverImage.mediumImageUrl,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Container _createRestTitle() {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
      alignment: Alignment.centerLeft,
      child: Text(
        '其他作品',
        style: TextStyle(
          fontSize: 16,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
          fontFamily: 'SourceHanSans',
        ),
        textAlign: TextAlign.start,
      ),
    );
  }

  Positioned _createBottomBar(Size size, Post post) {
    return Positioned(
      bottom: 20,
      child: Container(
        padding: EdgeInsets.only(left: 26, right: 26),
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87.withOpacity(0.1),
                      blurRadius: 8.0,
                      spreadRadius: 1,
                    ),
                  ],
                  color: Color.fromRGBO(249, 249, 249, 1),
                  border: Border.all(
                      color: Colors.white.withOpacity(0.6), width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(36)),
                ),
                child: Icon(
                  IconFont.icon_fenxiang,
                  size: 22,
                  color: Colors.black87,
                ),
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black87.withOpacity(0.1),
                    blurRadius: 8.0,
                    spreadRadius: 1,
                  ),
                ],
                color: Color.fromRGBO(249, 249, 249, 1),
                border: Border.all(
                    color: Colors.white.withOpacity(0.6), width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(36)),
              ),
              child: Icon(
                IconFont.icon_message,
                size: 22,
                color: Colors.black87,
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 10)),
            IconAnimationWidget(
              icon: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87.withOpacity(0.1),
                      blurRadius: 8.0,
                      spreadRadius: 1,
                    ),
                  ],
                  color: Color.fromRGBO(249, 249, 249, 1),
                  border: Border.all(
                      color: Colors.white.withOpacity(0.6), width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(36)),
                ),
                child: Icon(
                  Icons.favorite,
                  size: 22,
                  color: Colors.red.withOpacity(0.9),
                ),
              ),
              clickCallback: () async {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _createImage(Post post) {
    var lists = post?.files?.reversed?.toList();
    return post.files.length > 1
        ? Column(
            children: lists?.map((file) {
              if (post?.files?.first == file) {
                return ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(36)),
                  child: Container(
                    child: ImagePaper(
                      index: lists?.indexOf(file),
                      post: post,
                      knowImageSize: false,
                    ),
                  ),
                );
              } else if (post?.files?.last == file) {
                return ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
                  child: Container(
                    child: ImagePaper(
                      index: lists?.indexOf(file),
                      post: post,
                      knowImageSize: false,
                    ),
                  ),
                );
              } else {
                return Container(
                  child: ImagePaper(
                    index: lists?.indexOf(file),
                    post: post,
                    knowImageSize: false,
                  ),
                );
              }
            })?.toList(),
          )
        : Container();
  }

  Container _createText(Post post) {
    return Container(
      padding: EdgeInsets.only(right: 16, left: 16),
      child: Column(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: post?.user?.avatar?.mediumAvatarUrl,
                    fit: BoxFit.cover,
                    width: 56.0,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 6)),
                Text(
                  post?.user?.name,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontFamily: 'SourceHanSans',
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: true,
                ),
                Padding(padding: EdgeInsets.only(top: 6)),
                Text(
                  post?.title,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'SourceHanSans',
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: true,
                ),
                Container(
                  padding: EdgeInsets.only(top: 16, bottom: 26),
                  child: Text(
                    post?.content,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                      fontFamily: 'SourceHanSans',
                    ),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _createBackdropFilter(num imageHeight, Post post, Size size) {
    return Positioned(
      left: 0,
      right: 0,
      top: imageHeight - 66,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(249, 249, 249, 1).withOpacity(0),
              Color.fromRGBO(249, 249, 249, 1).withOpacity(1),
            ],
            stops: [0.2, 0.76],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 0,
                  sigmaY: 3.6,
                ),
                child: Container(
                  height: 68,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(249, 249, 249, 1).withOpacity(0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _createCoverImage(Post post) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(32)),
      ),
      child: Stack(
        children: [
          CacheImage(
              url: post?.coverImage != null
                  ? post?.coverImage?.mediumImageUrl
                  : post?.files[0]?.mediumImageUrl),
          Container(
            height: 166,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.15),
                  Colors.black.withOpacity(0),
                ],
                stops: [0.0, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Positioned _createAppBar(
      Size size, BuildContext context, bool isShowBottomBar) {
    return Positioned(
      top: 20,
      child: AnimatedContainer(
        duration: duration,
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              iconSize: 17,
              color: Colors.white,
              icon: Icon(IconFont.icon_back),
              onPressed: () => Navigator.pop(context),
            ),
            IconButton(
              iconSize: 16,
              color: Colors.white,
              icon: Icon(IconFont.icon_moreif),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Positioned _createLightAppBar(Size size, BuildContext context, Post post) {
    StatusBarUtil.setStatusBar(Brightness.dark, color: Colors.white);
    return Positioned(
      top: 0,
      child: SafeArea(
        child: AnimatedContainer(
          duration: duration,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black87.withOpacity(0.1),
                blurRadius: 8.0,
                spreadRadius: 1,
              ),
            ],
            color: Colors.white,
          ),
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                iconSize: 17,
                color: Colors.black87,
                icon: Icon(IconFont.icon_back),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: post?.user?.avatar?.mediumAvatarUrl,
                        fit: BoxFit.cover,
                        width: 26.0,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(right: 8)),
                    Text(
                      post?.user?.name,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontFamily: 'SourceHanSans',
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: true,
                    ),
                  ],
                ),
              ),
              IconButton(
                iconSize: 16,
                color: Colors.black87,
                icon: Icon(IconFont.icon_moreif),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
