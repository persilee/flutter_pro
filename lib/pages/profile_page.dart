import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pro_flutter/utils/screen_util.dart';
import 'package:pro_flutter/utils/widget_util.dart';
import 'package:pro_flutter/widgets/cache_image.dart';
import 'package:pro_flutter/widgets/iconfont.dart';
import 'package:pro_flutter/widgets/per_flexible_space_bar.dart';
import 'package:sp_util/sp_util.dart';
import 'package:transparent_image/transparent_image.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final imageUrl =
      'https://img.zcool.cn/community/01c9a85c3c35daa8012090db212316.jpg@1280w_1l_2o_100sh.jpg';
  final GlobalKey textKey = GlobalKey();
  Rect textSize;
  Offset textOffset;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      textSize = WidgetUtil.getWidgetBounds(textKey.currentContext);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = SpUtil.getObject('User');
    return Listener(
      onPointerDown: (e) {
        textOffset = WidgetUtil.getWidgetLocalToGlobal(textKey.currentContext);
        setState(() {});
      },
      child: Scaffold(
        backgroundColor: Color.fromRGBO(249, 249, 249, 1),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverPersistentHeader(
                  delegate: _SliverDelegate(textKey, textSize, textOffset),
                  pinned: true,
                  floating: true,
                ),
              )
            ];
          },
          body: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
                child: Container(
                  padding: EdgeInsets.all(30),
                  height: 600,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverDelegate extends SliverPersistentHeaderDelegate {

  final GlobalKey textKey;
  Rect textSize;
  Offset textOffset;

  final imageUrl =
      'https://img.zcool.cn/community/01c9a85c3c35daa8012090db212316.jpg@1280w_1l_2o_100sh.jpg';


  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // print('shrinkOffset: ${shrinkOffset}');
    // print('overlapsContent: ${overlapsContent}');

    // print(textSize);
    // print(textOffset);
    double textWidth = textSize != null ? textSize.width : 0.0;

    double maxShrinkOffset = this.maxExtent - this.minExtent;
    double t = (shrinkOffset / maxShrinkOffset).clamp(0.0, 1.0) as double;
    double mt = ((this.minExtent/2) / ((this.maxExtent / this.minExtent) * t)).clamp(0.0, this.minExtent/2) as double;
    double minTop = mt + ScreenUtil.instance.statusBarHeight;
    double textTop = (maxShrinkOffset - shrinkOffset) / 2 + minTop ;
    double textLeft = (ScreenUtil.instance.width - textWidth) / 2;
    textLeft = textLeft - (textLeft - 60) * t;

    print((textLeft - 68) * t);
    // print(maxShrinkOffset);
    // print(mt);


    final double scaleValue = Tween<double>(begin: 1, end: 0.8).transform(t);
    final double scaleImageValue =
        Tween<double>(begin: 1, end: 0.6).transform(t);
    final imageOffsetX = Tween<double>(begin: 0, end: - (ScreenUtil.instance.width - 56*2)).transform(t);
    final imageOffsetY = Tween<double>(begin: 0, end: minTop/2).transform(t);
    final double opacity = 1.0 - Interval(0, 1).transform(t);
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          color: Theme.of(context).primaryColor,
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
                      BackdropFilter(
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(child: ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.scale(
              scale: scaleImageValue,
              child: Transform.translate(
                offset: Offset(imageOffsetX, imageOffsetY),
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
            Padding(padding: EdgeInsets.only(top: 6)),
          ],
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

  @override
  double get maxExtent => 360.0;

  @override
  double get minExtent => 88.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  _SliverDelegate(this.textKey, this.textSize, this.textOffset);
}
