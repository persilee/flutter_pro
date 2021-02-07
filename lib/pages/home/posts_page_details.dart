import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:pro_flutter/models/post_model.dart';
import 'package:pro_flutter/utils/status_bar_util.dart';
import 'package:pro_flutter/view_model/details_view_model.dart';
import 'package:pro_flutter/widgets/icon_animation_widget.dart';
import 'package:pro_flutter/widgets/iconfont.dart';
import 'package:pro_flutter/widgets/page_state.dart';
import 'package:transparent_image/transparent_image.dart';

final postsDetailsProvider = StateNotifierProvider.autoDispose
    .family<DetailsViewModel, int>((ref, postId) {
  ref.onDispose(() => StatusBarUtil.setStatusBar(Brightness.dark));
  return DetailsViewModel(postId);
});

class PostsPageDetails extends ConsumerWidget {
  final int postId;
  final ScrollController _scrollController = ScrollController();

  PostsPageDetails({@required this.postId});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    StatusBarUtil.setStatusBar(Brightness.light);
    final detailsState = watch(postsDetailsProvider(postId).state);
    return Scaffold(
      body: _createContent(detailsState, context),
    );
  }

  Widget _createContent(DetailsState detailsState, BuildContext context) {
    final post = detailsState?.post;
    final size = MediaQuery.of(context).size;
    final imageHeight = post?.coverImage != null
        ? post.coverImage.height / (post.coverImage.width / size.width)
        : 0;

    if (detailsState.pageState == PageState.busyState ||
        detailsState.pageState == PageState.initializedState) {
      return Center(
        child: CircularProgressIndicator(
          valueColor:
              AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
          backgroundColor: Theme.of(context).highlightColor.withOpacity(0.4),
          strokeWidth: 2,
        ),
      );
    }

    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Stack(
                overflow: Overflow.visible,
                children: [
                  _createCoverImage(post),
                  _createAppBar(size, context),
                  _createBackdropFilter(imageHeight, post, size),
                ],
              ),
              _createText(post),
              _createImage(post),
            ],
          ),
        ),
        Positioned(
          bottom: 20,
          child: Container(
            padding: EdgeInsets.only(left: 26, right: 26),
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                    border: Border.all(color: Colors.white.withOpacity(0.6), width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(36)),
                  ),
                  child: Icon(
                    IconFont.icon_fenxiang,
                    size: 22,
                    color: Colors.black87,
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
                    border: Border.all(color: Colors.white.withOpacity(0.6), width: 1.0),
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
                      border: Border.all(color: Colors.white.withOpacity(0.6), width: 1.0),
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
        ),
      ],
    );
  }

  Widget _createImage(Post post) {
    return post.files.length > 1
        ? Column(
            children: post?.files?.reversed?.map((file) {
              print(post?.files?.indexOf(file));
              print(post?.files?.first == file);
              if (post?.files?.first == file) {
                return ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(36)),
                  child: Container(
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/animationImage.gif',
                      image: file?.mediumImageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                );
              } else if (post?.files?.last == file) {
                return ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
                  child: Container(
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/animationImage.gif',
                      image: file?.mediumImageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                );
              } else {
                return Container(
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/animationImage.gif',
                    image: file?.mediumImageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
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

  Positioned _createBackdropFilter(num imageHeight, Post post, Size size) {
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
                  color: Color.fromRGBO(249, 249, 249, 1).withOpacity(0),
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
          FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: post?.coverImage?.mediumImageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
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

  Positioned _createAppBar(Size size, BuildContext context) {
    return Positioned(
      top: 20,
      child: Container(
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              iconSize: 17,
              color: Colors.white,
              icon: Icon(Icons.arrow_back_ios_rounded),
              onPressed: () => Navigator.pop(context),
            ),
            IconButton(
              iconSize: 18,
              color: Colors.white,
              icon: Icon(Icons.more_vert_rounded),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
