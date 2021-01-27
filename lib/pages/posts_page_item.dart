import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_flutter/models/post_model.dart';
import 'package:pro_flutter/widgets/iconfont.dart';
import 'package:transparent_image/transparent_image.dart';

final colorProvider = StateProvider((ref) => 0);

class PostsPageItem extends ConsumerWidget {
  final Post post;

  const PostsPageItem({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var colorState = watch(colorProvider).state;
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Card(
          color: Colors.transparent,
          elevation: 0.0,
          margin: EdgeInsets.only(
            bottom: 16.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _createImage(),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      _createAvatar(),
                      Padding(padding: EdgeInsets.only(right: 10)),
                      _createTitle(size, context),
                    ],
                  ),
                  Row(
                    children: [
                      _createLikes(),
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                      ),
                      _createComments(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  GestureDetector _createComments() {
    return GestureDetector(
      child: Row(
        children: [
          Icon(
            Icons.mode_comment,
            size: 16,
            color: Colors.grey.withOpacity(0.6),
          ),
          Padding(
            padding: EdgeInsets.only(right: 2.0),
          ),
          Text(
            post.totalComments != null ? post.totalComments.toString() : '0',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.withOpacity(0.6),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      onTap: () {},
    );
  }

  GestureDetector _createLikes() {
    return GestureDetector(
      child: Row(
        children: [
          Icon(
            Icons.favorite,
            size: 16,
            color: Colors.grey.withOpacity(0.6),
          ),
          Padding(
            padding: EdgeInsets.only(right: 2.0),
          ),
          Text(
            post.totalLikes.toString(),
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.withOpacity(0.6),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      onTap: () {},
    );
  }

  Container _createTitle(Size size, BuildContext context) {
    return Container(
      width: size.width / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.title,
            style: Theme.of(context).textTheme.subtitle2,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            softWrap: true,
          ),
          Text(
            post.user.name,
            style: TextStyle(fontSize: 13, color: Colors.black54),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            softWrap: true,
          ),
        ],
      ),
    );
  }

  ClipOval _createAvatar() {
    return ClipOval(
      child: Image.network(
        post.user.avatar.mediumAvatarUrl,
        fit: BoxFit.cover,
        width: 26.0,
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: Icon(IconFont.if_empty),
          );
        },
      ),
    );
  }

  AspectRatio _createImage() {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.0),
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: post.files[0].mediumImageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }
}
