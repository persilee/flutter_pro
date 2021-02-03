import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_flutter/demo/flare_demo/flare_sign_in_demo.dart';
import 'package:pro_flutter/http/base_error.dart';
import 'package:pro_flutter/models/category_model.dart';
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

  @override
  void initState() {
    _scrollController = ScrollController();
    _refreshController = RefreshController();
    _tabController = TabController(
      length: 0,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _refreshController.dispose();
    _tabController.dispose();
    super.dispose();
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
              child: _buildTabBar(context),
            ),
            Expanded(
              child: CustomTabBar.TabBarView(
                controller: _tabController,
                children: [

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget temp() {
    return Consumer(builder: (context, watch, _) {
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
    });
  }

  Widget _buildTabBar(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final postState = watch(postsProvider.state);
      if (postState.categories.isNotEmpty) {
        _tabController = TabController(
          length: 2 + postState.categories.length,
          vsync: this,
          initialIndex: 1,
        );
      }
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
        tabs: _createTabs(postState),
      );
    });
  }

  List<Widget> _createTabs(PostState postState) {
    return postState.categories.isNotEmpty && _tabController.length > 0
        ? [
            Tab(
              text: '关注',
            ),
            Tab(
              text: '首页推荐',
            ),
            ...postState.categories
                .map((category) => Tab(
                      text: category.name,
                    ))
                .toList(),
          ]
        : [];
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
