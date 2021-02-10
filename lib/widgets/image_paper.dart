import 'dart:io';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pro_flutter/models/post_model.dart';
import 'package:pro_flutter/widgets/pic_swiper.dart';

class ImagePaper extends StatefulWidget {
  final Post post;
  final placeholder;
  final bool knowImageSize;
  final int index;

  const ImagePaper(
      {Key key,
      this.post,
      this.placeholder = 'assets/images/animationImage.gif',
      this.knowImageSize,
      this.index})
      : super(key: key);

  @override
  _ImagePaperState createState() => _ImagePaperState();
}

class _ImagePaperState extends State<ImagePaper>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 2200),
        lowerBound: 0.0,
        upperBound: 1.0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.post.files.isEmpty) {
      return Container();
    }
    var lists = widget.post?.files?.reversed?.toList();
    final Files imageItem = lists[widget.index];

    return ExtendedImage.network(
      imageItem.mediumImageUrl,
      fit: BoxFit.cover,
      cache: true,
      clearMemoryCacheWhenDispose: true,
      loadStateChanged: (ExtendedImageState state) {
        Widget _image;
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            _controller.reset();
            _image = Image.asset(
              widget.placeholder,
              fit: BoxFit.cover,
            );
            break;
          case LoadState.completed:
            _controller.forward();
            state.returnLoadStateChangedWidget = !widget.knowImageSize;
            _image = Hero(
              tag: imageItem.mediumImageUrl,
              child: FadeTransition(
                opacity: _controller,
                child: ExtendedRawImage(
                  image: state.extendedImageInfo?.image,
                  fit: BoxFit.cover,
                ),
              ),
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
                        post: widget.post,
                        index: widget.index,
                        pics: lists
                            .map((e) => PicSwiperItem(picUrl: e.mediumImageUrl))
                            .toList(),
                      ),
                    )
                  : TransparentCupertinoPageRoute(
                      builder: (context) => PicSwiper(
                        post: widget.post,
                        index: widget.index,
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
