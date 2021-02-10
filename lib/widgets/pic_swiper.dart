import 'dart:async';
import 'dart:math';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pro_flutter/models/post_model.dart';

typedef DoubleClickAnimationListener = void Function();

class PicSwiper extends StatefulWidget {
  const PicSwiper({
    this.index,
    this.pics,
    this.post,
  });
  final int index;
  final List<PicSwiperItem> pics;
  final Post post;
  @override
  _PicSwiperState createState() => _PicSwiperState();
}

class _PicSwiperState extends State<PicSwiper> with TickerProviderStateMixin {
  final StreamController<int> rebuildIndex = StreamController<int>.broadcast();
  final StreamController<bool> rebuildSwiper =
  StreamController<bool>.broadcast();
  AnimationController _doubleClickAnimationController;
  AnimationController _slideEndAnimationController;
  Animation<double> _doubleClickAnimation;
  DoubleClickAnimationListener _doubleClickAnimationListener;
  List<double> doubleTapScales = <double>[1.0, 2.0];
  GlobalKey<ExtendedImageSlidePageState> slidePagekey =
  GlobalKey<ExtendedImageSlidePageState>();
  int _currentIndex = 0;
  bool _showSwiper = true;
  Rect imageDRect;

  double initScale({Size imageSize, Size size, double initialScale}) {
    final double n1 = imageSize.height / imageSize.width;
    final double n2 = size.height / size.width;
    if (n1 > n2) {
      final FittedSizes fittedSizes =
      applyBoxFit(BoxFit.contain, imageSize, size);
      //final Size sourceSize = fittedSizes.source;
      final Size destinationSize = fittedSizes.destination;
      return size.width / destinationSize.width;
    } else if (n1 / n2 < 1 / 4) {
      final FittedSizes fittedSizes =
      applyBoxFit(BoxFit.contain, imageSize, size);
      //final Size sourceSize = fittedSizes.source;
      final Size destinationSize = fittedSizes.destination;
      return size.height / destinationSize.height;
    }

    return initialScale;
  }

  @override
  void initState() {
    _currentIndex = widget.index;
    _doubleClickAnimationController = AnimationController(
        duration: const Duration(milliseconds: 150), vsync: this);

    _slideEndAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _slideEndAnimationController.addListener(() {

    });
    super.initState();
  }

  @override
  void dispose() {
    rebuildIndex.close();
    rebuildSwiper.close();
    _doubleClickAnimationController.dispose();
    _slideEndAnimationController.dispose();
    clearGestureDetailsCache();
    //cancelToken?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    imageDRect = Offset.zero & size;
    Widget result = Material(

      /// if you use ExtendedImageSlidePage and slideType =SlideType.onlyImage,
      /// make sure your page is transparent background
        color: Colors.transparent,
        shadowColor: Colors.transparent,
        child: SafeArea(
          top: false,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              ExtendedImageGesturePageView.builder(
                controller: PageController(
                  initialPage: widget.index,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final String item = widget.pics[index].picUrl;

                  Widget image = ExtendedImage.network(
                    item,
                    fit: BoxFit.contain,
                    enableSlideOutPage: true,
                    mode: ExtendedImageMode.gesture,
                    heroBuilderForSlidingPage: (Widget result) {
                      if (index < min(9, widget.pics.length)) {
                        return Hero(
                          tag: item,
                          child: result,
                          flightShuttleBuilder: (BuildContext flightContext,
                              Animation<double> animation,
                              HeroFlightDirection flightDirection,
                              BuildContext fromHeroContext,
                              BuildContext toHeroContext) {
                            final Hero hero =
                            (flightDirection == HeroFlightDirection.pop
                                ? fromHeroContext.widget
                                : toHeroContext.widget) as Hero;
                            return hero.child;
                          },
                        );
                      } else {
                        return result;
                      }
                    },
                    initGestureConfigHandler: (ExtendedImageState state) {
                      double initialScale = 1.0;

                      if (state.extendedImageInfo != null &&
                          state.extendedImageInfo.image != null) {
                        initialScale = initScale(
                            size: size,
                            initialScale: initialScale,
                            imageSize: Size(
                                state.extendedImageInfo.image.width.toDouble(),
                                state.extendedImageInfo.image.height.toDouble()));
                      }
                      return GestureConfig(
                          inPageView: true,
                          initialScale: initialScale,
                          maxScale: max(initialScale, 5.0),
                          animationMaxScale: max(initialScale, 5.0),
                          initialAlignment: InitialAlignment.center,
                          //you can cache gesture state even though page view page change.
                          //remember call clearGestureDetailsCache() method at the right time.(for example,this page dispose)
                          cacheGesture: false);
                    },
                    onDoubleTap: (ExtendedImageGestureState state) {
                      ///you can use define pointerDownPosition as you can,
                      ///default value is double tap pointer down postion.
                      final Offset pointerDownPosition =
                          state.pointerDownPosition;
                      final double begin = state.gestureDetails.totalScale;
                      double end;

                      //remove old
                      _doubleClickAnimation
                          ?.removeListener(_doubleClickAnimationListener);

                      //stop pre
                      _doubleClickAnimationController.stop();

                      //reset to use
                      _doubleClickAnimationController.reset();

                      if (begin == doubleTapScales[0]) {
                        end = doubleTapScales[1];
                      } else {
                        end = doubleTapScales[0];
                      }

                      _doubleClickAnimationListener = () {
                        //print(_animation.value);
                        state.handleDoubleTap(
                            scale: _doubleClickAnimation.value,
                            doubleTapPosition: pointerDownPosition);
                      };
                      _doubleClickAnimation = _doubleClickAnimationController
                          .drive(Tween<double>(begin: begin, end: end));

                      _doubleClickAnimation
                          .addListener(_doubleClickAnimationListener);

                      _doubleClickAnimationController.forward();
                    },
                    loadStateChanged: (ExtendedImageState state) {
                      if (state.extendedImageLoadState == LoadState.completed) {
                        return ExtendedImageGesture(
                          state,
                          canScaleImage: (_) => true,
                          imageBuilder: (Widget image) {
                            return Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: image,
                                ),
                              ],
                            );
                          },
                        );
                      }
                      return null;
                    },
                  );
                  image = GestureDetector(
                    child: image,
                    onTap: () {
                      // if (translateY != 0) {
                      //   translateY = 0;
                      //   rebuildDetail.sink.add(translateY);
                      // }
                      // else
                      {
                        slidePagekey.currentState.popPage();
                        Navigator.pop(context);
                      }
                    },
                  );

                  return image;
                },
                itemCount: widget.pics.length,
                onPageChanged: (int index) {
                  _currentIndex = index;
                  rebuildIndex.add(index);
                  _showSwiper = true;
                  rebuildSwiper.add(_showSwiper);
                },
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                //move page only when scale is not more than 1.0
                // canMovePage: (GestureDetails gestureDetails) {
                //   //gestureDetails.totalScale <= 1.0
                //   //return translateY == 0.0;

                // }
                //physics: ClampingScrollPhysics(),
              ),
              StreamBuilder<bool>(
                builder: (BuildContext c, AsyncSnapshot<bool> d) {
                  if (d.data == null || !d.data) {
                    return Container();
                  }

                  return Positioned(
                    bottom: 60.0,
                    left: 0.0,
                    right: 0.0,
                    child:
                    MySwiperPlugin(widget.pics, _currentIndex, rebuildIndex),
                  );
                },
                initialData: true,
                stream: rebuildSwiper.stream,
              ),
            ],
          ),
        ));

    result = ExtendedImageSlidePage(
      key: slidePagekey,
      child: result,
      slideAxis: SlideAxis.both,
      slideType: SlideType.onlyImage,
      slideScaleHandler: (
          Offset offset, {
            ExtendedImageSlidePageState state,
          }) {

        return null;
      },
      slideOffsetHandler: (
          Offset offset, {
            ExtendedImageSlidePageState state,
          }) {
        return null;
      },
      slideEndHandler: (
          Offset offset, {
            ExtendedImageSlidePageState state,
            ScaleEndDetails details,
          }) {

        return null;
      },
      onSlidingPage: (ExtendedImageSlidePageState state) {
        ///you can change other widgets' state on page as you want
        ///base on offset/isSliding etc
        //var offset= state.offset;
        final bool showSwiper = !state.isSliding;
        if (showSwiper != _showSwiper) {
          // do not setState directly here, the image state will change,
          // you should only notify the widgets which are needed to change
          // setState(() {
          // _showSwiper = showSwiper;
          // });

          _showSwiper = showSwiper;
          rebuildSwiper.add(_showSwiper);
        }
      },
    );

    return result;
  }
}

class MySwiperPlugin extends StatelessWidget {
  const MySwiperPlugin(this.pics, this.index, this.reBuild);
  final List<PicSwiperItem> pics;
  final int index;
  final StreamController<int> reBuild;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      builder: (BuildContext context, AsyncSnapshot<int> data) {
        return DefaultTextStyle(
          style: TextStyle(color: Colors.black87),
          child: Container(
            height: 50.0,
            width: double.infinity,
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 10.0,
                ),
                Text(
                  '${data.data + 1}',
                ),
                Text(
                  ' / ${pics.length}',
                ),
              ],
            ),
          ),
        );
      },
      initialData: index,
      stream: reBuild.stream,
    );
  }
}

class PicSwiperItem {
  PicSwiperItem({
    @required this.picUrl,
    this.des = '',
  });
  final String picUrl;
  final String des;
}