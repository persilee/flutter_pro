import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pro_flutter/demo/flare_demo/flare_sign_in_demo.dart';
import 'package:pro_flutter/http/base_error.dart';
import 'package:pro_flutter/models/post_model.dart';
import 'package:pro_flutter/pages/home/posts_page_details.dart';
import 'package:pro_flutter/pages/profile/sliver_delegate.dart';
import 'package:pro_flutter/utils/screen_util.dart';
import 'package:pro_flutter/view_model/login_view_model.dart';
import 'package:pro_flutter/view_model/profile_view_model.dart';
import 'package:pro_flutter/widgets/cache_image.dart';
import 'package:pro_flutter/widgets/error_page.dart';
import 'package:pro_flutter/widgets/page_state.dart';
import 'package:sp_util/sp_util.dart';
import 'package:transparent_image/transparent_image.dart';

final profileProvider =
    StateNotifierProvider.family<ProfileViewModel, int>((ref, userId) {
  return ProfileViewModel(userId);
});

class ProfilePage extends StatefulWidget {
  final int userId;
  final bool isCreatePage;

  ProfilePage({this.userId, this.isCreatePage = false});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey textKey = GlobalKey();
  Rect textSize;

  @override
  Widget build(BuildContext context) {
    var _userId;
    if (widget.userId != null) {
      _userId = widget.userId;
    } else {
      if(SpUtil.getObject('User') != null)
      _userId = SpUtil.getObject('User')['id'];
    }
    return Scaffold(
      backgroundColor: Color.fromRGBO(249, 249, 249, 1),
      body: Consumer(builder: (context, watch, _) {
        final profileState = watch(profileProvider(_userId).state);
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

        if (profileState.pageState == PageState.errorState) {
          return ErrorPage(
            title: profileState.error is NeedLogin
                ? '😮 你竟然忘记登录 😮'
                : profileState.error.code?.toString(),
            desc: profileState.error.message,
            buttonAction: () async {
              if (profileState.error is NeedLogin) {
                LoginState loginState = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FlareSignInDemo()));
                if (loginState.isLogin) {
                  setState(() {});
                }
              } else {
                context.refresh(profileProvider(_userId));
              }
            },
            buttonText: profileState.error is NeedLogin ? '登录' : null,
          );
        }
        return NestedScrollView(
          floatHeaderSlivers: false,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverPersistentHeader(
                  delegate:
                      SliverDelegate(context,_userId, textKey, textSize, profileState, widget.isCreatePage),
                  pinned: true,
                ),
              ),
            ];
          },
          body: Builder(builder: (BuildContext context) {
            final posts = profileState.posts;
            return CustomScrollView(
              slivers: <Widget>[
                SliverOverlapInjector(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(
                      top: 40.0, left: 16, right: 16, bottom: widget.isCreatePage ? 0 : 40),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return _createListItem(context, posts, index, _userId);
                      },
                      childCount: posts.length,
                    ),
                  ),
                ),
              ],
            );
          }),
        );
      }),
    );
  }

  GestureDetector _createListItem(BuildContext context, List<Post> posts,
      int index, _userId) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(
                builder: (context) => PostsPageDetails(
                      postId: posts[index].id,
                      userId: posts[index].user.id,
                    )))
            .then((value) {
          context
              .read(profileProvider(_userId))
              .updatePostById(posts[index].id, index);
        });
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 6),
            width: ScreenUtil.instance.width - 32,
            child: AspectRatio(
              aspectRatio: 3 / 2,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: CacheImage(
                  url: posts[index]?.coverImage?.mediumImageUrl,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 3),
            child: Text(
              posts[index]?.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            alignment: Alignment.centerLeft,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 32),
            child: Row(
              children: [
                Text(
                  posts[index]?.category,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.withOpacity(0.6),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Padding(padding: EdgeInsets.only(left: 12)),
                _createIconText(
                  posts,
                  index,
                  Icons.remove_red_eye,
                  posts[index]?.views?.toString(),
                ),
                _createIconText(
                  posts,
                  index,
                  Icons.favorite,
                  posts[index]?.totalLikes.toString(),
                ),
                _createIconText(
                  posts,
                  index,
                  Icons.mode_comment_rounded,
                  posts[index]?.totalComments.toString(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _createIconText(
      List<Post> posts, int index, IconData icon, String num) {
    return Padding(
      padding: EdgeInsets.only(right: 4),
      child: Row(
        children: [
          Icon(
            icon,
            size: 12,
            color: Colors.grey.withOpacity(0.4),
          ),
          Padding(padding: EdgeInsets.only(right: 1)),
          Text(
            num,
            style: GoogleFonts.farro(
              fontSize: 11,
              color: Colors.grey.withOpacity(0.4),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
