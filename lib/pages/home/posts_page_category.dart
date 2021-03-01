import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:lottie/lottie.dart';
import 'package:pro_flutter/demo/flare_demo/flare_sign_in_demo.dart';
import 'package:pro_flutter/http/base_error.dart';
import 'package:pro_flutter/pages/common_base_page.dart';
import 'package:pro_flutter/pages/home/posts_page.dart';
import 'package:pro_flutter/pages/home/posts_page_item.dart';
import 'package:pro_flutter/utils/screen_util.dart';
import 'package:pro_flutter/view_model/login_view_model.dart';
import 'package:pro_flutter/view_model/posts_view_model.dart';
import 'package:pro_flutter/widgets/error_page.dart';
import 'package:pro_flutter/widgets/page_state.dart';
import 'package:pro_flutter/widgets/refresh.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostsPageCategory extends ConsumerWidget {

  final int categoryId;
  final ScrollController scrollController;
  final RefreshController refreshController;

  PostsPageCategory(
      {this.categoryId, this.scrollController, this.refreshController});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final postsViewModel = watch(postsProvider(categoryId));
    final postState = watch(postsProvider(categoryId).state);
    return Refresh(
      controller: refreshController,
      onLoading: () async {
        await postsViewModel.getPosts(categoryId);
        if (postState.pageState == PageState.noMoreDataState) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      },
      onRefresh: () async {
        await context
            .read(postsProvider(categoryId))
            .getPosts(categoryId, isRefresh: true);
        refreshController.refreshCompleted();
        refreshController.footerMode.value = LoadStatus.canLoading;
      },
      content: CommonBasePage(
        pageState: postState.pageState,
        baseError: postState.error,
        buttonActionCallback: () {
          context.refresh(postsProvider(categoryId));
        },
        child: ListView.separated(
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
              categoryId: categoryId,
            );
          },
        ),
      ),
    );
  }
}
