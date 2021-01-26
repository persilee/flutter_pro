import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_flutter/models/post_model.dart';
import 'package:pro_flutter/view_model/posts_view_model.dart';
import 'package:pro_flutter/widgets/error_page.dart';
import 'package:pro_flutter/widgets/page_state.dart';
import 'package:pro_flutter/widgets/refresh.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

final postsProvider =
    StateNotifierProvider.autoDispose((ref) => PostsViewModel());

class PostsPage extends ConsumerWidget {
  final ScrollController _scrollController = ScrollController();
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context, ScopedReader wacth) {
    final postsViewModel = wacth(postsProvider);
    final postState = wacth(postsProvider.state);
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts Page'),
      ),
      body: Refresh(
        controller: _refreshController,
        onLoading: () {
          postsViewModel.getPosts();
          if (postState.pageState == PageState.noMoreDataState) {
            _refreshController.loadNoData();
          } else {
            _refreshController.loadComplete();
          }
        },
        onRefresh: () {
          context.refresh(postsProvider);
          _refreshController.refreshCompleted();
          _refreshController.footerMode.value = LoadStatus.canLoading;
        },
        content: _cteateContent(postState, context),
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
        buttonAction: () => context.refresh(postsProvider),
      );
    }

    return ListView.builder(
      itemCount: postState.posts.length,
      controller: _scrollController,
      itemBuilder: (BuildContext context, int index) {
        final Post post = postState.posts[index];
        return Container(
          child: ListTile(
            title: Text(post.title),
          ),
        );
      },
    );
  }
}
