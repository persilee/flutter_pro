import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pro_flutter/utils/screen_util.dart';
import 'package:transparent_image/transparent_image.dart';

class SliverDelegate extends SliverPersistentHeaderDelegate {

  GlobalKey textKey;
  Rect textSize;
  Offset textOffset;

  final imageUrl =
      'https://img.zcool.cn/community/01c9a85c3c35daa8012090db212316.jpg@1280w_1l_2o_100sh.jpg';


  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {

    double textWidth = textSize != null ? textSize.width : 0.0;
    double maxShrinkOffset = this.maxExtent - this.minExtent;
    double t = (shrinkOffset / maxShrinkOffset).clamp(0.0, 1.0) as double;
    double mt = Tween<double>(begin: 44.0, end: 14.0).transform(t);
    double minTop = mt + ScreenUtil.instance.statusBarHeight;
    double textTop = (maxShrinkOffset - shrinkOffset) / 3.6 + minTop ;
    double textLeft = (ScreenUtil.instance.width - textWidth) / 2;
    textLeft = textLeft - (textLeft - 60) * t;
    double imt = Tween<double>(begin: 0.0, end: 10).transform(t);
    double imageTop = minTop - imt;

    double imageLeft = textLeft - (textLeft - 6) * t;

    double scaleImageValue =
    Tween<double>(begin: 1, end: 0.6).transform(t);
    double opacity = 1.0 - Interval(0, 1).transform(t);
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).accentColor,
                Theme.of(context).highlightColor
              ],
              tileMode: TileMode.mirror,
              begin: Alignment.centerLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Opacity(
            opacity: opacity,
            child: Stack(
              children: [
                LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return FadeInImage.memoryNetwork(
                    height: constraints.maxHeight,
                    width: ScreenUtil.instance.width,
                    placeholder: kTransparentImage,
                    fit: BoxFit.cover,
                    image: imageUrl,
                  );
                }),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(249, 249, 249, 1).withOpacity(0),
                        Color.fromRGBO(249, 249, 249, 1).withOpacity(1),
                      ],
                      stops: [0, 1],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 6.6,
                            sigmaY: 6.6,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                              Color.fromRGBO(249, 249, 249, 1).withOpacity(0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 76,
                  child: Container(
                    width: ScreenUtil.instance.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _createNumTag('36', '作品'),
                        _createNumTag('666', '粉丝'),
                        _createNumTag('326', '关注'),
                      ],
                    ),
                  ),),
              ],
            ),
          ),
        ),
        Positioned(
          right: 6,
          top: 32,
          child: IconButton(
            icon: Icon(Icons.settings, color: Colors.black87,size: 18,),
            onPressed: (){},
          ),
        ),
        Positioned(
          top: imageTop,
          left: imageLeft,
          child: Transform.scale(
            scale: scaleImageValue,
            child: ClipOval(
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: imageUrl,
                fit: BoxFit.cover,
                width: 56.0,
                height: 56.0,
              ),
            ),
          ),
        ),
        Positioned(
          top: textTop,
          left: textLeft,
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Text(
                  'persile',
                  key: textKey,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SourceHanSans',
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                );
              }
          ),
        ),
      ],
    );
  }

  Column _createNumTag(String value, String name) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 16
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontFamily: 'SourceHanSans',
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  double get maxExtent => 300.0;

  @override
  double get minExtent => 96.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  SliverDelegate(this.textKey, this.textSize, this.textOffset);
}