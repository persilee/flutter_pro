import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_flutter/models/post_model.dart';
import 'package:pro_flutter/pages/home/posts_page.dart';
import 'package:pro_flutter/pages/home/posts_page_details.dart';
import 'package:pro_flutter/pages/profile/profile_page.dart';
import 'package:pro_flutter/utils/date_util.dart';
import 'package:pro_flutter/utils/timeline_util.dart';
import 'package:pro_flutter/widgets/cache_image.dart';
import 'package:pro_flutter/widgets/icon_animation_widget.dart';
import 'package:sp_util/sp_util.dart';
import 'package:transparent_image/transparent_image.dart';

final colorProvider = StateProvider((ref) => 0);

class PostsPageItem extends ConsumerWidget {
  final int categoryId;
  final Post post;
  final int index;

  PostsPageItem(
      {Key key,this.categoryId , this.post, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return post.files.length > 0
        ? Container(
      padding: EdgeInsets.only(top: 12),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PostsPageDetails(
                                postId: post.id,
                                userId: post.user.id,
                              ))).then((value) {
                        context
                            .read(postsProvider(categoryId))
                            .updatePostById(post.id, index);
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16.0),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset.fromDirection(1.6),
                        ),
                      ]),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _createImage(),
                          _createTitle(),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 56.0,
                  height: 260.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _createAvatar(context),
                      _createViews(context),
                      _createLikes(context),
                      _createComments(context),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Container();
  }

  ClipRRect _createTitle() {
    double _radius = 20.0;

    /// 照片是6，9张时，每行显示3个
    final _isThreeRow = [3, 2].contains(post.files.length / 3);

    /// 照片是2，4张时，每行显示2个
    final _isTwoRow = [2, 1].contains(post.files.length / 2);

    /// 控制圆角显示
    if (post?.category == '摄影' && (_isThreeRow || _isTwoRow)) {
      _radius = 0;
    }

    /// 时间格式化
    String timeline = TimelineUtil.format(
        DateUtil.getDateMsByTimeStr(post.createdAt),
        locTimeMs: DateTime.now().millisecondsSinceEpoch,
        locale: 'zh',
        dayFormat: DayFormat.Simple);
    return ClipRRect(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(_radius)),
      child: Container(
        color: Colors.white,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(
          right: 16,
          left: 16,
          top: 12,
          bottom: 12,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post?.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'SourceHanSans',
              ),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              softWrap: true,
            ),
            Padding(padding: EdgeInsets.only(top: 3)),
            Row(
              children: [
                Text(
                  post?.user?.name,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'SourceHanSans'),
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: true,
                ),
                categoryId < 0
                    ? Text(
                        '  •  ${post?.category}',
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                            fontStyle: FontStyle.normal,
                            fontFamily: 'SourceHanSans'),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: true,
                      )
                    : Container(),
                Spacer(),
                Text(
                  timeline,
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'SourceHanSans'),
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: true,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _createComments(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Icon(
            Icons.mode_comment,
            size: 24,
            color: Colors.grey.withOpacity(0.4),
          ),
          Text(
            post?.totalComments != null ? post.totalComments.toString() : '0',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.withOpacity(0.4),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      onTap: () {},
    );
  }

  Widget _createViews(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.remove_red_eye,
          size: 24,
          color: Colors.grey.withOpacity(0.4),
        ),
        Text(
          post?.views.toString(),
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.withOpacity(0.4),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _createLikes(BuildContext context) {
    final user = SpUtil.getObject('User');
    var isLogin = user != null ? true : false;
    return Column(
      children: [
        IconAnimationWidget(
          icon: Container(
            decoration: BoxDecoration(
                boxShadow: isLogin && post?.liked != 0
                    ? [
                        BoxShadow(
                          color: Colors.red.shade400.withOpacity(0.1),
                          blurRadius: 8.0,
                          spreadRadius: 2,
                        )
                      ]
                    : null),
            child: Icon(
              Icons.favorite,
              size: 24,
              color: isLogin && post?.liked != 0
                  ? Colors.red.withOpacity(0.8)
                  : Colors.grey.withOpacity(0.6),
            ),
          ),
          clickCallback: () async {
            await context.read(postsProvider(categoryId)).clickLike(post.id, index);
          },
        ),
        Text(
          post.totalLikes.toString(),
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.withOpacity(0.6),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _createAvatar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProfilePage(
              userId: post.user.id,
              isCreatePage: true,
            )));
      },
      child: Container(
        padding: EdgeInsets.all(1.8),
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor, width: 2.0),
            borderRadius: BorderRadius.circular(60.0)),
        child: ClipOval(
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: post?.user?.avatar?.mediumAvatarUrl,
            fit: BoxFit.cover,
            width: 36.0,
          ),
        ),
      ),
    );
  }

  Widget _gridItemBuilder(BuildContext context, int index) {
    return CacheImage(url: post.files[index].thumbnailImageUrl);
  }

  Widget _createImage() {
    Files _files = post?.files[0];

    /// 根据图片宽高显示横、竖展示图片
    double _aspectRatio = 3 / 2;
    if (_files.width < _files?.height) {
      _aspectRatio = 3 / 4;
    }

    /// 照片是6，9张时，每行显示3个
    final _isThreeRow = [3, 2].contains(post.files.length / 3);

    /// 照片是2，4张时，每行显示2个
    final _isTwoRow = [2, 1].contains(post.files.length / 2);

    /// 当分类是摄影时，显示网格布局
    if (post?.category == '摄影' && (_isThreeRow || _isTwoRow)) {
      return Container(
        child: GridView.builder(
          padding: EdgeInsets.all(0),
          shrinkWrap: true,
          itemCount: post?.files?.length,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _isThreeRow ? 3 : 2,
            crossAxisSpacing: 6.0,
            mainAxisSpacing: 6.0,
          ),
          itemBuilder: _gridItemBuilder,
        ),
      );
    }
    return AspectRatio(
      aspectRatio: _aspectRatio,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        child: CacheImage(
          url: _files?.mediumImageUrl,
        ),
      ),
    );
  }
}
