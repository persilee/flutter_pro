import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui show Image;
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pro_flutter/models/post_model.dart';
import 'package:pro_flutter/utils/screen_util.dart';
import 'package:pro_flutter/widgets/pic_swiper.dart';

class ImagePaper extends StatelessWidget {
  final Post post;
  final bool knowImageSize;
  final int index;

  const ImagePaper({Key key, this.post, this.knowImageSize, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (post.files.isEmpty) {
      return Container();
    }
    var lists = post?.files?.reversed?.toList();
    final Files imageItem = lists[index];

    return ExtendedImage.network(
      imageItem.mediumImageUrl,
      fit: BoxFit.cover,
      cache: true,
      clearMemoryCacheWhenDispose: true,
      loadStateChanged: (ExtendedImageState state) {
        Widget _image;
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            _image = Container(
              color: Colors.grey,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ),
            );
            break;
          case LoadState.completed:
            state.returnLoadStateChangedWidget = !knowImageSize;
            _image = Hero(
              tag: imageItem.mediumImageUrl,
              child: ExtendedRawImage(
                  image: state.extendedImageInfo.image, fit: BoxFit.cover),
            );

            break;
          case LoadState.failed:
            _image = GestureDetector(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Lottie.asset(
                    'assets/json/error2.json',
                    width: 66,
                    height: 66,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                  Positioned(
                    bottom: 6.0,
                    left: 0.0,
                    right: 0.0,
                    child: Text(
                      '图片加载失败，点击重试',
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              onTap: () {
                state.reLoadImage();
              },
            );
            break;
        }

        _image = GestureDetector(
          child: _image,
          onTap: () {
            Navigator.push(
              context,
              Platform.isAndroid
                  ? TransparentMaterialPageRoute(
                      builder: (context) => PicSwiper(
                        post: post,
                        index: index,
                        pics: lists
                            .map((e) => PicSwiperItem(picUrl: e.mediumImageUrl))
                            .toList(),
                      ),
                    )
                  : TransparentCupertinoPageRoute(
                      builder: (context) => PicSwiper(
                        post: post,
                        index: index,
                        pics: lists
                            .map((e) => PicSwiperItem(picUrl: e.mediumImageUrl))
                            .toList(),
                      ),
                    ),
            );
          },
        );
        return _image;
      },
    );
  }
}
