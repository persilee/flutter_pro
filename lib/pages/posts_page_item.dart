import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_flutter/models/post_model.dart';
import 'package:pro_flutter/pages/posts_page.dart';
import 'package:pro_flutter/widgets/iconfont.dart';
import 'package:pro_flutter/widgets/icon_animation_widget.dart';
import 'package:transparent_image/transparent_image.dart';

final colorProvider = StateProvider((ref) => 0);

class PostsPageItem extends ConsumerWidget {
  final Post post;
  final int index;

  const PostsPageItem({Key key, this.post, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var colorState = watch(colorProvider).state;
    var size = MediaQuery.of(context).size;
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: Offset.fromDirection(1.6),
                ),]
              ),
              child: Column(
                children: [
                  _createImage(),
                  _createTitle(),
                ],
              ),
            ),
          ),
          Container(
            width: 56.0,
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
    );
  }

  ClipRRect _createTitle() {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      child: Container(
        height: 56,
        color: Colors.white,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(right: 16, left: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post?.title,
              style:
                  GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w500),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: true,
            ),
            Padding(padding: EdgeInsets.only(top: 2)),
            Text(
              post?.user?.name,
              style: GoogleFonts.lato(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                  fontStyle: FontStyle.normal),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: true,
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
    return Column(
      children: [
        IconAnimationWidget(
          icon: Container(
            decoration: BoxDecoration(
              boxShadow: post?.liked == 0 ? null : [BoxShadow(
                color: Colors.red.shade400.withOpacity(0.15),
                blurRadius: 8.0,
                spreadRadius: 1,
              )]
            ),
            child: Icon(
              Icons.favorite,
              size: 24,
              color: post?.liked == 0
                  ? Colors.grey.withOpacity(0.6)
                  : Colors.red.withOpacity(0.8),
            ),
          ),
          clickCallback: () async {
            await context.read(postsProvider).clickLike(post.id, index);
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
    return Container(
      padding: EdgeInsets.all(1.8),
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor, width: 2.0),
          borderRadius: BorderRadius.circular(60.0)),
      child: ClipOval(
        child: Image.network(
          post?.user?.avatar?.mediumAvatarUrl,
          fit: BoxFit.cover,
          width: 36.0,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Icon(IconFont.icon_empty),
            );
          },
        ),
      ),
    );
  }

  AspectRatio _createImage() {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: post?.files[0]?.mediumImageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }
}
