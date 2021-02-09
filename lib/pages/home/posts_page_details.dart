import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:lottie/lottie.dart';
import 'package:pro_flutter/models/post_model.dart';
import 'package:pro_flutter/utils/status_bar_util.dart';
import 'package:pro_flutter/view_model/details_view_model.dart';
import 'package:pro_flutter/widgets/cache_image.dart';
import 'package:pro_flutter/widgets/icon_animation_widget.dart';
import 'package:pro_flutter/widgets/iconfont.dart';
import 'package:pro_flutter/widgets/image_paper.dart';
import 'package:pro_flutter/widgets/page_state.dart';
import 'package:transparent_image/transparent_image.dart';

final postsDetailsProvider = StateNotifierProvider.autoDispose
    .family<DetailsViewModel, int>((ref, postId) {
  ref.onDispose(() => StatusBarUtil.setStatusBar(Brightness.dark));
  return DetailsViewModel(postId);
});

class PostsPageDetails extends StatefulWidget {
  final int postId;

  PostsPageDetails({@required this.postId});

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
        final detailsState = watch(postsDetailsProvider(widget.postId).state);
        return _createContent(detailsState, context);
      }),
    );
  }

  Widget _createContent(DetailsState detailsState, BuildContext context) {
    final post = detailsState?.post;
    final size = MediaQuery.of(context).size;
    imageHeight = post?.coverImage != null
        ? post.coverImage.height / (post.coverImage.width / size.width)
        : 0;
    if (detailsState.pageState == PageState.busyState ||
        detailsState.pageState == PageState.initializedState) {
      return Center(
        child: Lottie.asset(
          'assets/json/loading2.json',
          width: 116,
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      );
    }

    return Container(
      height: size.height,
      child: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                Stack(
                  overflow: Overflow.visible,
                  children: [
                    _createCoverImage(post),
                    _createBackdropFilter(imageHeight, post, size),
                  ],
                ),
                _createText(post),
                _createImage(post),
              ],
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
                  color: post?.liked == 0
                      ? Colors.red.withOpacity(0.9)
                      : Colors.grey.withOpacity(0.8),
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
    var lists= post?.files?.reversed?.toList();
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
          CacheImage(url: post?.coverImage?.mediumImageUrl),
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
