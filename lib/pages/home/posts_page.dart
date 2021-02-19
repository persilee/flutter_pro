import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:pro_flutter/models/category_model.dart';
import 'package:pro_flutter/pages/home/posts_page_category.dart';
import 'package:pro_flutter/utils/screen_util.dart';
import 'package:pro_flutter/view_model/posts_view_model.dart';
import 'package:pro_flutter/widgets/custom_tabs.dart' as CustomTabBar;
import 'package:pro_flutter/widgets/custom_indicator.dart' as CustomIndicator;
import 'package:pull_to_refresh/pull_to_refresh.dart';

final categoryTabProvider =
    StateNotifierProvider((ref) => CategoryTabViewModel());
final postsProvider = StateNotifierProvider.family<PostsViewModel, int>(
    (ref, categoryId) => PostsViewModel(categoryId));

class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  List<Tab> _tabs = [];

  ScrollController _scrollController;
  RefreshController _refreshController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _refreshController = RefreshController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer(builder: (context, watch, _) {
      List<Category> categories = watch(categoryTabProvider.state).categories;
      _initTabs(categories);
      return DefaultTabController(
        length: _tabs.length,
        initialIndex: 1,
        child: Builder(
          builder: (BuildContext context) {
            final TabController tabController =
                DefaultTabController.of(context);
            tabController.addListener(() {
              if (!tabController.indexIsChanging) {
                if (_refreshController.footerStatus == LoadStatus.noMore) {
                  _refreshController.footerMode.value = LoadStatus.canLoading;
                }
              }
            });
            return Scaffold(
              body: Container(
                color: Color.fromRGBO(249, 249, 249, 1),
                padding: EdgeInsets.fromLTRB(4, ScreenUtil.instance.statusBarHeight, 4, 18),
                child: Column(
                  children: [
                    Container(
                      height: 46,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(249, 249, 249, 1),
                        borderRadius: BorderRadius.only(
                            // bottomRight: Radius.circular(28),
                            // bottomLeft: Radius.circular(28),
                            ),
                      ),
                      child: _tabs.isNotEmpty
                          ? _buildTabBar(context)
                          : Container(),
                    ),
                    Expanded(
                      child: _tabs.isNotEmpty
                          ? CustomTabBar.TabBarView(
                              children: _createTabPage(categories),
                            )
                          : Container(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }

  List<Widget> _createTabPage(List<Category> categories) {
    categories = [
      Category(name: '关注', id: -2),
      Category(name: '首页推荐', id: -1),
      ...categories
    ];
    return categories
        .map((category) => PostsPageCategory(
              categoryId: category.id,
              scrollController: _scrollController,
              refreshController: _refreshController,
            ))
        .toList();
  }

  void _initTabs(List<Category> categories) {
    if (categories.isNotEmpty) {
      _tabs = [
        Tab(
          text: '关注',
        ),
        Tab(
          text: '首页推荐',
        ),
        ...categories
            .map((category) => Tab(
                  text: category.name,
                ))
            .toList(),
      ];
    }
  }

  Widget _buildTabBar(BuildContext context) {
    return CustomTabBar.TabBar(
      onTap: (index) {},
      labelPadding: EdgeInsets.fromLTRB(12, 0, 12, 0),
      labelStyle: TextStyle(
        color: Colors.black54.withOpacity(0.6),
        fontSize: 18,
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
          hPadding: 15,
          borderSide: BorderSide(
            width: 3,
            color: Theme.of(context).accentColor.withOpacity(0.8),
          ),
          insets: EdgeInsets.zero),
      isScrollable: true,
      tabs: _tabs ?? [],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
