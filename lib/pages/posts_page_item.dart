import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pro_flutter/models/post_model.dart';
import 'package:pro_flutter/widgets/iconfont.dart';

class PostsPageItem extends StatelessWidget {
  final Post post;

  const PostsPageItem({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6.0),
          child: Image.network(
            post.files[0].mediumImageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Icon(IconFont.if_empty),
              );
            },
          ),
        ),
        Positioned(
            bottom: 0, left: 0, right: 0, child: _bottomItem(post, context))
      ],
    );
  }

  Widget _bottomItem(Post post, BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          color: Colors.deepPurple.shade100.withOpacity(0.5),
          height: 60,
          child: Center(
            child: Text(
              post.title,
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
