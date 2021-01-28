import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_flutter/demo/flare_demo/flare_sign_in_demo.dart';
import 'package:pro_flutter/http/base_error.dart';
import 'package:pro_flutter/models/post_model.dart';
import 'package:pro_flutter/pages/posts_page_item.dart';
import 'package:pro_flutter/view_model/posts_view_model.dart';
import 'package:pro_flutter/widgets/error_page.dart';
import 'package:pro_flutter/widgets/page_state.dart';
import 'package:pro_flutter/widgets/refresh.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

final postsProvider =
    StateNotifierProvider((ref) => PostsViewModel());

class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
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
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
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
            content: _cteateContent(postState, context),
          );
        }),
      ),
    );
  }

  Widget _cteateContent(PostState postState, BuildContext context) {
    if (postState.pageState == PageState.busyState ||
        postState.pageState == PageState.initializedState) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
          backgroundColor: Colors.yellow[100],
        ),
      );
    }

    if (postState.pageState == PageState.errorState) {
      return ErrorPage(
        title: postState.error.code?.toString(),
        desc: postState.error.message,
        buttonAction: () {
          if (postState.error is NeedLogin) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => FlareSignInDemo()));
          } else {
            context.refresh(postsProvider);
          }
        },
        buttonText: postState.error is NeedLogin ? '登录' : null,
      );
    }

    return ListView.separated(
      separatorBuilder: (context, index) {
        return Padding(padding: EdgeInsets.only(top: 12));
      },
      padding: EdgeInsets.all(12),
      reverse: false,
      itemCount: postState.posts.length,
      controller: _scrollController,
      itemBuilder: (BuildContext context, int index) {
        final Post post = postState.posts[index];
        return PostsPageItem(
          post: post,
        );
      },
    );
  }
}
