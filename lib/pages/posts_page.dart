import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_flutter/models/post_model.dart';
import 'package:pro_flutter/view_model/posts_view_model.dart';
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
        onLoading: () async {
          postsViewModel.getPosts();
          if (postState.pageState == PageState.noMoreDataState) {
            _refreshController.loadNoData();
          } else {
            _refreshController.loadComplete();
          }
        },
        onRefresh: () async {
          // List<Post> lists =
          //     await context.read(postsProvider).getPosts(isRefresh: true);
          // if (lists != null) {
          //   _refreshController.refreshCompleted();
          //   _refreshController.footerMode.value = LoadStatus.canLoading;
          // } else {
          //   _refreshController.refreshFailed();
          // }
        },
        content: ListView.builder(
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
        ),
      ),
    );
  }

  Widget cteateContent(AsyncValue<List<Post>> respons) {
    return respons.when(
      data: (_) => ListView.builder(
        itemCount: _.length,
        controller: _scrollController,
        itemBuilder: (BuildContext context, int index) {
          final Post post = _[index];
          return Container(
            child: ListTile(
              title: Text(post.title),
            ),
          );
        },
      ),
      loading: () => Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
          backgroundColor: Colors.yellow[100],
        ),
      ),
      error: (e, _) => Text(
        e.toString(),
      ),
    );
  }
}
