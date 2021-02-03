import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_flutter/demo/flare_demo/flare_sign_in_demo.dart';
import 'package:pro_flutter/http/base_error.dart';
import 'package:pro_flutter/models/post_model.dart';
import 'package:pro_flutter/pages/posts_page_item.dart';
import 'package:pro_flutter/view_model/login_view_model.dart';
import 'package:pro_flutter/view_model/posts_view_model.dart';
import 'package:pro_flutter/widgets/error_page.dart';
import 'package:pro_flutter/widgets/page_state.dart';
import 'package:pro_flutter/widgets/refresh.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:pro_flutter/widgets/custom_tabs.dart' as CustomTabBar;
import 'package:pro_flutter/widgets/custom_indicator.dart' as CustomIndicator;

final postsProvider = StateNotifierProvider((ref) => PostsViewModel());

class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> with TickerProviderStateMixin {
  ScrollController _scrollController;
  RefreshController _refreshController;
  TabController _tabController;
  bool _isShowMask = true;
  bool _isShowMaskFirst = false;
  GlobalKey _firstKey = GlobalKey();
  GlobalKey _lastKey = GlobalKey();

  @override
  void initState() {
    _scrollController = ScrollController();
    _refreshController = RefreshController();
    _tabController = TabController(
      length: 7,
      vsync: this,
      initialIndex: 1,
    );
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        //监听Widget是否绘制完毕
        WidgetsBinding.instance.addPostFrameCallback(_getTabBarBox);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _refreshController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _getTabBarBox(Duration duration) {
    double _width = MediaQuery.of(context).size.width;
    RenderBox firstRenderBox = _firstKey.currentContext.findRenderObject();
    Offset firstOffset = firstRenderBox.localToGlobal(Offset(0, 0));
    RenderBox lastRenderBox = _lastKey.currentContext.findRenderObject();
    Offset lastOffset = lastRenderBox.localToGlobal(Offset(0, 0));
    if (firstOffset.dx < 14) {
      setState(() {
        _isShowMaskFirst = true;
      });
    } else {
      setState(() {
        _isShowMaskFirst = false;
      });
    }

    if (lastOffset.dx > _width - 48) {
      setState(() {
        _isShowMask = true;
      });
    } else {
      setState(() {
        _isShowMask = false;
      });
    }
    print('firstOffset: ${firstOffset}');
    print('lastOffset: ${lastOffset}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(249, 249, 249, 1),
        padding: EdgeInsets.fromLTRB(4, 0, 4, 18),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 26),
              height: 64,
              decoration: BoxDecoration(
                color: Color.fromRGBO(249, 249, 249, 1),
                borderRadius: BorderRadius.only(
                    // bottomRight: Radius.circular(28),
                    // bottomLeft: Radius.circular(28),
                    ),
              ),
              child: Stack(
                children: [
                  _buildTabBar(context),
                  _isShowMask ? _rightMask() : Container(),
                  _isShowMaskFirst ? _leftMask() : Container(),
                ],
              ),
            ),
            Expanded(
              child: Consumer(builder: (context, watch, _) {
                final postsViewModel = watch(postsProvider);
                final postState = watch(postsProvider.state);
                return Refresh(
                  controller: _refreshController,
                  onLoading: () async {
                    await postsViewModel.getPosts();
                    if (postState.pageState == PageState.noMoreDataState) {
                      _refreshController.loadNoData();
                    } else {
                      _refreshController.loadComplete();
                    }
                  },
                  onRefresh: () async {
                    await context.read(postsProvider).getPosts(isRefresh: true);
                    _refreshController.refreshCompleted();
                    _refreshController.footerMode.value = LoadStatus.canLoading;
                  },
                  content: _createContent(postState, context),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Positioned _leftMask() {
    return Positioned(
      top: 0,
      bottom: 0,
      left: 0,
      child: Container(
        width: 36,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromRGBO(249, 249, 249, 1),
                Colors.white.withOpacity(0.2),
              ]),
        ),
      ),
    );
  }

  Positioned _rightMask() {
    return Positioned(
      top: 0,
      bottom: 0,
      right: 0,
      child: Container(
        width: 36,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                Color.fromRGBO(249, 249, 249, 1),
                Colors.white.withOpacity(0.2),
              ]),
        ),
      ),
    );
  }

  CustomTabBar.TabBar _buildTabBar(BuildContext context) {
    return CustomTabBar.TabBar(
      onTap: (index) {},
      labelPadding: EdgeInsets.fromLTRB(12, 0, 12, 0),
      controller: _tabController,
      labelStyle: TextStyle(
        color: Colors.black54.withOpacity(0.6),
        fontSize: 16,
        fontWeight: FontWeight.bold,
        fontFamily: 'FZDaLTJ',
      ),
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey.shade400,
      unselectedLabelStyle: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        fontFamily: 'FZDaLTJ',
      ),
      indicatorSize: CustomTabBar.TabBarIndicatorSize.label,
      indicatorPadding: EdgeInsets.fromLTRB(8, 6, 8, 0),
      indicatorWeight: 2.2,
      indicator: CustomIndicator.UnderlineTabIndicator(
          hPadding: 12,
          borderSide: BorderSide(
            width: 3,
            color: Theme.of(context).accentColor.withOpacity(0.8),
          ),
          insets: EdgeInsets.zero),
      isScrollable: true,
      tabs: [
        Tab(
          key: _firstKey,
          text: '关注',
        ),
        Tab(
          text: '首页推荐',
        ),
        Tab(
          text: '设计',
        ),
        Tab(
          text: '动漫',
        ),
        Tab(
          text: '摄影',
        ),
        Tab(
          text: '影视',
        ),
        Tab(
          key: _lastKey,
          text: '其他',
        ),
      ],
    );
  }

  Widget _createContent(PostState postState, BuildContext context) {
    if (postState.pageState == PageState.busyState ||
        postState.pageState == PageState.initializedState) {
      return Center(
        child: CircularProgressIndicator(
          valueColor:
              AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
          backgroundColor: Theme.of(context).highlightColor.withOpacity(0.4),
          strokeWidth: 1.2,
        ),
      );
    }

    if (postState.pageState == PageState.errorState) {
      return ErrorPage(
        title: postState.error is NeedLogin
            ? '😮 你竟然忘记登录 😮'
            : postState.error.code?.toString(),
        desc: postState.error.message,
        buttonAction: () async {
          if (postState.error is NeedLogin) {
            LoginState loginState = await Navigator.of(this.context).push(
                MaterialPageRoute(builder: (context) => FlareSignInDemo()));
            if (loginState.isLogin) {
              context.refresh(postsProvider);
            }
          } else {
            context.refresh(postsProvider);
          }
        },
        buttonText: postState.error is NeedLogin ? '登录' : null,
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return Padding(padding: EdgeInsets.only(top: 12));
      },
      padding: EdgeInsets.fromLTRB(12, 18, 12, 18),
      reverse: false,
      itemCount: postState.posts.length,
      controller: _scrollController,
      itemBuilder: (BuildContext context, int index) {
        final Post post = postState.posts[index];
        return PostsPageItem(
          post: post,
          index: index,
        );
      },
    );
  }
}
