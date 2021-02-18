import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_flutter/pages/profile/sliver_delegate.dart';
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
    return Scaffold(
      backgroundColor: Color.fromRGBO(249, 249, 249, 1),
      body: NestedScrollView(
        floatHeaderSlivers: false,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverPersistentHeader(
                delegate: SliverDelegate(textKey, textSize, textOffset),
                pinned: true,
              ),
            ),
          ];
        },
        body: Builder(
            builder: (BuildContext context) {
              return CustomScrollView(
                slivers: <Widget>[
                  SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: SliverFixedExtentList(
                      itemExtent: 48.0,
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return ListTile(
                            title: Text('Item $index'),
                          );
                        },
                        childCount: 100,
                      ),
                    ),
                  ),
                ],
              );
            }
        ),
      ),
    );
  }
}



