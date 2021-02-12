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
import 'package:pro_flutter/widgets/gradient_button.dart';
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

final scrollStateProvider = StateProvider((ref) {});

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
  String inputText;
  double appBarAlpha = 0;
  bool isShowBottomBar = true;
  bool isShowBottomInputBar = false;

  Duration duration = Duration(milliseconds: 360);
  ScrollController _scrollController;
  TextEditingController _editingController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _editingController = TextEditingController();
    _scrollController.addListener(() {
      _watchScroll();
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _editingController.dispose();
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
                  post.totalComments == 0
                      ? _createNoComment()
                      : _createComment(comments),
                  Container(
                    height: 36,
                  ),
                ],
              ),
            ),
          ),

          /// 浮动的顶部appbar
          _createAppBar(size, context, post),

          /// 浮动的底部操作bar
          _createBottomBar(size, post),

          /// 全屏的透明层，用于点击显示或隐藏输入框和键盘
          _createIsShowInputBarLayer(context),

          /// 浮动的输入框
          _createBottomInputBar(),
        ],
      ),
    );
  }

  Widget _createBottomInputBar() {
    return isShowBottomInputBar
        ? Positioned(
            bottom: 0,
            child: Container(
              height: 46,
              padding: EdgeInsets.fromLTRB(14, 2, 6, 2),
              width: ScreenUtil.instance.width,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _editingController,
                      onChanged: (value) {
                        inputText = value;
                      },
                      autofocus: true,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.w300,
                      ),
                      //输入文本的样式
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '说点什么...',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 14),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                    ),
                    child: GradientButton(
                      width: 66,
                      borderRadius: 4.0,
                      child: Text(
                        '发送',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.86),
                        ),
                      ),
                      onPressed: () {
                        if (inputText.isNotEmpty) {
                          inputText = '';
                          _editingController.clear();
                          setState(() {
                            isShowBottomInputBar = false;
                          });
                        }
                        print(inputText);
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container(
            width: 0,
            height: 0,
          );
  }

  StatelessWidget _createIsShowInputBarLayer(BuildContext context) {
    return isShowBottomInputBar
        ? GestureDetector(
            onTapDown: (e) {
              _hideKeyword(context);
            },
            onHorizontalDragStart: (e) {
              _hideKeyword(context);
            },
            child: Container(
              color: Colors.transparent,
            ),
          )
        : Container(
            width: 0,
            height: 0,
          );
  }

  void _hideKeyword(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus.unfocus();
    }
    setState(() {
      isShowBottomInputBar = false;
    });
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
                  /// 评论用户头像和用户名称
                  _createCommentUserInfo(comment, timeline),

                  /// 评论内容
                  _createCommentContent(comment),

                  /// 评论回复
                  _createCommentReply(comment),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Container _createCommentReply(Comments comment) {
    return comment.repComment != null
        ? Container(
            padding: EdgeInsets.only(top: 12, right: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 44,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                      top: 16,
                      left: 10,
                      bottom: 16,
                    ),
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
          )
        : Container();
  }

  Container _createCommentContent(Comments comment) {
    return Container(
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
    );
  }

  Container _createCommentUserInfo(Comments comment, String timeline) {
    return Container(
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
    );
  }

  Column _createNoComment() {
    return Column(
      children: [
        Container(
          height: 16,
          padding: EdgeInsets.only(bottom: 36),
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
        Padding(padding: EdgeInsets.only(bottom: 16)),
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

  Widget _createBottomBar(Size size, Post post) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 360),
      bottom: isShowBottomInputBar ? -36 : 20,
      child: Container(
        padding: EdgeInsets.only(left: 26, right: 26),
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            /// 分享按钮
            _createBottomBarShareButton(),
            Spacer(),

            /// 消息按钮
            createBottomBarMessageButton(),
            Padding(padding: EdgeInsets.only(right: 10)),

            /// 点赞按钮
            createBottomBarLikedButton(),
          ],
        ),
      ),
    );
  }

  IconAnimationWidget createBottomBarLikedButton() {
    return IconAnimationWidget(
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
          border: Border.all(color: Colors.white.withOpacity(0.6), width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(36)),
        ),
        child: Icon(
          Icons.favorite,
          size: 22,
          color: Colors.red.withOpacity(0.9),
        ),
      ),
      clickCallback: () async {},
    );
  }

  Widget createBottomBarMessageButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isShowBottomInputBar = true;
        });
      },
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
          border: Border.all(color: Colors.white.withOpacity(0.6), width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(36)),
        ),
        child: Icon(
          IconFont.icon_message,
          size: 22,
          color: Colors.black87,
        ),
      ),
    );
  }

  GestureDetector _createBottomBarShareButton() {
    return GestureDetector(
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
          border: Border.all(color: Colors.white.withOpacity(0.6), width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(36)),
        ),
        child: Icon(
          IconFont.icon_fenxiang,
          size: 22,
          color: Colors.black87,
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

  Positioned _createAppBar(Size size, BuildContext context, Post post) {
    /// 设置状态栏颜色
    if (!isShowBottomBar) {
      StatusBarUtil.setStatusBar(Brightness.dark, color: Colors.white);
    } else {
      StatusBarUtil.setStatusBar(Brightness.light, color: Colors.transparent);
    }

    /// 设置按钮的颜色从白色到黑色变化
    final whiteToBlack = Color.fromARGB(255, ((1 - appBarAlpha) * 255).toInt(),
        ((1 - appBarAlpha) * 255).toInt(), ((1 - appBarAlpha) * 255).toInt());
    return Positioned(
      top: 0,
      child: Container(
        padding: EdgeInsets.only(top: ScreenUtil.instance.statusBarHeight),
        decoration: BoxDecoration(
          boxShadow: !isShowBottomBar
              ? [
                  BoxShadow(
                    color: Colors.black87.withOpacity(0.1),
                    blurRadius: 8.0,
                    spreadRadius: 1,
                  ),
                ]
              : null,
          color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255),
        ),
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              iconSize: 17,
              color: whiteToBlack,
              icon: Icon(IconFont.icon_back),
              onPressed: () => Navigator.pop(context),
            ),
            Expanded(
              child: Opacity(
                opacity: appBarAlpha,
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
            ),
            IconButton(
              iconSize: 16,
              color: whiteToBlack,
              icon: Icon(IconFont.icon_moreif),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  void _watchScroll() {
    if (_scrollController.position.pixels > imageHeight - 56) {
      setState(() {
        isShowBottomBar = false;
      });
    } else {
      setState(() {
        isShowBottomBar = true;
      });
    }
    double alpha = _scrollController.position.pixels / imageHeight;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }
}
