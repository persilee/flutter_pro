import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:pro_flutter/demo/flare_demo/flare_sign_in_demo.dart';
import 'package:pro_flutter/demo/model/post.dart';
import 'package:pro_flutter/http/base_error.dart';
import 'package:pro_flutter/models/post_model.dart';
import 'package:pro_flutter/pages/home/posts_page.dart';
import 'package:pro_flutter/pages/home/posts_page_item.dart';
import 'package:pro_flutter/view_model/login_view_model.dart';
import 'package:pro_flutter/view_model/posts_view_model.dart';
import 'package:pro_flutter/widgets/error_page.dart';
import 'package:pro_flutter/widgets/page_state.dart';
import 'package:pro_flutter/widgets/refresh.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

final postsProvider = StateNotifierProvider((ref) => PostsViewModel());

class PostsPageRecommend extends ConsumerWidget {

  final ScrollController scrollController;
  final RefreshController refreshController;

  PostsPageRecommend({this.scrollController, this.refreshController});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final postsViewModel = watch(postsProvider);
    final postState = watch(postsProvider.state);
    return Refresh(
      controller: refreshController,
      onLoading: () async {
        await postsViewModel.getPosts();
        if (postState.pageState == PageState.noMoreDataState) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      },
      onRefresh: () async {
        await context.read(postsProvider).getPosts(isRefresh: true);
        refreshController.refreshCompleted();
        refreshController.footerMode.value = LoadStatus.canLoading;
      },
      content: _createContent(postState, context),
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
          strokeWidth: 2,
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
            LoginState loginState = await Navigator.of(context).push(
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
      controller: scrollController,
      itemBuilder: (BuildContext context, int index) {
        return PostsPageItem(
          post: postState.posts[index],
          index: index,
        );
      },
    );
  }
}
