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

  const ImagePaper({Key key, this.post, this.knowImageSize, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (post.files.isEmpty) {
      return Container();
    }

    final double num300 = ScreenUtil.instance.setWidth(300);
    final double num400 = ScreenUtil.instance.setWidth(400);
    double height = num300;
    double width = num400;
    var lists= post?.files?.reversed?.toList();
    final Files imageItem = lists[index];
    if (knowImageSize) {
      height = imageItem.height.toDouble();
      width = imageItem.width.toDouble();
      final double n = height / width;
      if (n >= 4 / 3) {
        width = num300;
        height = num400;
      } else if (4 / 3 > n && n > 3 / 4) {
        final double maxValue = max(width, height);
        height = num400 * height / maxValue;
        width = num400 * width / maxValue;
      } else if (n <= 3 / 4) {
        width = num400;
        height = num300;
      }
    }

    return ExtendedImage.network(
      imageItem.mediumImageUrl,
      fit: BoxFit.cover,
      cache: true,
      clearMemoryCacheWhenDispose: true,
      loadStateChanged: (ExtendedImageState state) {
        Widget widget;
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            widget = Container(
              color: Colors.grey,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor:
                AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
              ),
            );
            break;
          case LoadState.completed:
            state.returnLoadStateChangedWidget = !knowImageSize;
            widget = Hero(
                tag: imageItem.mediumImageUrl,
                child: buildImage(state.extendedImageInfo.image, num300, num400));

            break;
          case LoadState.failed:
            widget = GestureDetector(
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
        if (index == 8 && post.files.length > 9) {
          widget = Stack(
            children: <Widget>[
              widget,
              Container(
                color: Colors.grey.withOpacity(0.2),
                alignment: Alignment.center,
                child: Text(
                  '+${post.files.length - 9}',
                  style: const TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              )
            ],
          );
        }

        widget = GestureDetector(
          child: widget,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PicSwiper(
                  post: post,
                  index: index,
                  pics: lists.map((e) => PicSwiperItem(picUrl: e.mediumImageUrl)).toList(),
                )));
          },
        );

        return widget;
      },
    );
  }

  Widget buildImage(ui.Image image, double num300, double num400) {
    final double n = image.height / image.width;
    if (post.files.length == 1) {
      return ExtendedRawImage(image: image, fit: BoxFit.cover);
    } else if (n >= 4 / 3) {
      Widget imageWidget = ExtendedRawImage(
          image: image,
          fit: BoxFit.cover,
          sourceRect: Rect.fromLTWH(
              0.0, 0.0, image.width.toDouble(), 4 * image.width / 3));
      if (n >= 4) {
        imageWidget = Container(
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0.0,
                right: 0.0,
                left: 0.0,
                bottom: 0.0,
                child: imageWidget,
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Container(
                  padding: const EdgeInsets.all(2.0),
                  color: Colors.grey,
                  child: const Text(
                    'long image',
                    style: TextStyle(color: Colors.white, fontSize: 10.0),
                  ),
                ),
              )
            ],
          ),
        );
      }
      return imageWidget;
    } else if (4 / 3 > n && n > 3 / 4) {
      final int maxValue = max(image.width, image.height);
      final double height = num400 * image.height / maxValue;
      final double width = num400 * image.width / maxValue;
      return ExtendedRawImage(
        image: image,
        fit: BoxFit.cover,
      );
    } else if (n <= 3 / 4) {
      final double width = 4 * image.height / 3;
      Widget imageWidget = ExtendedRawImage(
        image: image,
        fit: BoxFit.cover,
        sourceRect: Rect.fromLTWH(
            (image.width - width) / 2.0, 0.0, width, image.height.toDouble()),
      );

      if (n <= 1 / 4) {
        imageWidget = Container(
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0.0,
                right: 0.0,
                left: 0.0,
                bottom: 0.0,
                child: imageWidget,
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Container(
                  padding: const EdgeInsets.all(2.0),
                  color: Colors.grey,
                  child: const Text(
                    'long image',
                    style: TextStyle(color: Colors.white, fontSize: 10.0),
                  ),
                ),
              )
            ],
          ),
        );
      }
      return imageWidget;
    }
    return Container();
  }
}

