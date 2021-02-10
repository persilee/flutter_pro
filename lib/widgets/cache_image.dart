import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CacheImage extends StatefulWidget {
  final url;
  final placeholder;
  final width;
  final height;

  const CacheImage({Key key, @required this.url, this.placeholder = 'assets/images/animationImage.gif', this.width, this.height}) : super(key: key);

  @override
  _CacheImageState createState() => _CacheImageState();
}

class _CacheImageState extends State<CacheImage>
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
    return LayoutBuilder(
      builder: (context, constraints) {
        return ExtendedImage.network(
          widget.url,
          width: widget.width ?? null,
          height: widget.height ?? null,
          fit: BoxFit.cover,
          cache: true,
          enableLoadState: true,
          loadStateChanged: (ExtendedImageState state) {
            switch (state.extendedImageLoadState) {
              case LoadState.loading:
                _controller.reset();
                return Image.asset(
                  widget.placeholder,
                  fit: BoxFit.cover,
                );
                break;
              case LoadState.completed:
                _controller.forward();
                return FadeTransition(
                  opacity: _controller,
                  child: ExtendedRawImage(
                    image: state.extendedImageInfo?.image,
                    fit: BoxFit.cover,
                  ),
                );
                break;
              case LoadState.failed:
                _controller.reset();
                state.imageProvider.evict();
                return GestureDetector(
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

            return Container();
          },
        );
      }
    );
  }
}
