import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pro_flutter/pages/profile/sliver_delegate.dart';
import 'package:pro_flutter/utils/screen_util.dart';
import 'package:pro_flutter/utils/widget_util.dart';
import 'package:pro_flutter/view_model/profile_view_model.dart';
import 'package:pro_flutter/widgets/cache_image.dart';
import 'package:pro_flutter/widgets/iconfont.dart';
import 'package:pro_flutter/widgets/page_state.dart';
import 'package:pro_flutter/widgets/per_flexible_space_bar.dart';
import 'package:sp_util/sp_util.dart';
import 'package:transparent_image/transparent_image.dart';

final profileProvider = StateNotifierProvider.autoDispose
    .family<ProfileViewModel, int>((ref, userId) {
  return ProfileViewModel(userId);
});

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final imageUrl =
      'https://img.zcool.cn/community/01c9a85c3c35daa8012090db212316.jpg@1280w_1l_2o_100sh.jpg';
  final GlobalKey textKey = GlobalKey();
  Rect textSize;

  @override
  Widget build(BuildContext context) {
    final user = SpUtil.getObject('User');
    return Scaffold(
      backgroundColor: Color.fromRGBO(249, 249, 249, 1),
      body: Consumer(
        builder: (context, watch, _) {
          final profileState = watch(profileProvider(user['id']).state);
          textSize = profileState.textSize;
          if (profileState.pageState == PageState.busyState ||
              profileState.pageState == PageState.initializedState) {
            return Center(
              child: Lottie.asset(
                'assets/json/loading2.json',
                width: 126,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            );
          }
          return NestedScrollView(
            floatHeaderSlivers: false,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverPersistentHeader(
                    delegate: SliverDelegate(context, textKey, textSize, profileState),
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
          );
        }
      ),
    );
  }
}



