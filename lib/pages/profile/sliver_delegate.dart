import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_flutter/demo/base_widget_demo/my_page.dart';
import 'package:pro_flutter/pages/profile/profile_page.dart';
import 'package:pro_flutter/utils/screen_util.dart';
import 'package:pro_flutter/utils/widget_util.dart';
import 'package:pro_flutter/view_model/profile_view_model.dart';
import 'package:pro_flutter/widgets/gradient_button.dart';
import 'package:pro_flutter/widgets/iconfont.dart';
import 'package:transparent_image/transparent_image.dart';

class SliverDelegate extends SliverPersistentHeaderDelegate {
  BuildContext context;
  int userId;
  GlobalKey textKey;
  Rect textSize;
  ProfileState profileState;
  bool isCreatePage;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double textWidth = textSize != null ? textSize.width : 0.0;
    double maxShrinkOffset = this.maxExtent - this.minExtent;
    double t = (shrinkOffset / maxShrinkOffset).clamp(0.0, 1.0) as double;
    double mt = Tween<double>(begin: 66.0, end: 16.0).transform(t);
    double ctt = Tween<double>(begin: 0, end: 32).transform(t);
    double minTop = mt + ScreenUtil.instance.statusBarHeight;
    double textTop = (maxShrinkOffset - shrinkOffset) / 3 + minTop;
    double textLeft = (ScreenUtil.instance.width - textWidth) / 2;
    textLeft = textLeft - (textLeft - 60) * t; // left
    double cTextLeft = textLeft + ctt; // center
    double imt = Tween<double>(begin: 0.0, end: 12).transform(t);
    double imageTop = minTop - imt;
    double imageLeft = (ScreenUtil.instance.width - 56) / 2;
    imageLeft = imageLeft - (imageLeft - 6) * t; // left
    double cImageLeft = imageLeft + ctt; // center
    double scaleImageValue = Tween<double>(begin: 1, end: 0.6).transform(t);
    double opacity = 1.0 - Interval(0, 1).transform(t);

    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.vertical(bottom: Radius.circular(26)),
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
                    image: profileState.user.data.avatar.largeAvatarUrl,
                  );
                }),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(249, 249, 249, 1).withOpacity(0),
                        Color.fromRGBO(249, 249, 249, 1).withOpacity(1),
                      ],
                      stops: [0, 0.96],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 16,
                            sigmaY: 16,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(249, 249, 249, 1)
                                  .withOpacity(0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 26,
                  child: Container(
                    width: ScreenUtil.instance.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _createNumTag(
                            profileState.user.data.totalPosts.toString(), '作品'),
                        _createNumTag(
                            profileState.user.data.totalLikes.toString(), '赞过'),
                        _createNumTag('666', '粉丝'),
                        _createNumTag('36', '关注'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 6,
          top: 32,
          child: !isCreatePage
              ? IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.black87,
                    size: 18,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MyPage()));
                  },
                )
              : IconButton(
                  icon: Icon(
                    IconFont.icon_follow,
                    color: Colors.black87,
                    size: 18,
                  ),
                  onPressed: () {},
                ),
        ),
        Positioned(
          left: 6,
          top: 32,
          child: isCreatePage
              ? IconButton(
                  icon: Icon(
                    IconFont.icon_back,
                    color: Colors.black87,
                    size: 17,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              : Container(),
        ),
        Positioned(
          top: imageTop,
          left: isCreatePage ? cImageLeft : imageLeft,
          child: Transform.scale(
            scale: scaleImageValue,
            child: ClipOval(
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: profileState.user.data.avatar.mediumAvatarUrl,
                fit: BoxFit.cover,
                width: 56.0,
                height: 56.0,
              ),
            ),
          ),
        ),
        Positioned(
          top: textTop,
          left: isCreatePage ? cTextLeft : textLeft,
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return Text(
              profileState.user.data.name,
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
          }),
        ),
      ],
    );
  }

  Column _createNumTag(String value, String name) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.farro(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
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
  double get maxExtent => 300;

  @override
  double get minExtent => 86.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  SliverDelegate(this.context, this.userId, this.textKey, this.textSize,
      this.profileState, this.isCreatePage) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (textSize == null) {
        textSize = WidgetUtil.getWidgetBounds(textKey.currentContext);
        context.read(profileProvider(userId)).getTextRect(textSize);
      }
    });
  }
}
