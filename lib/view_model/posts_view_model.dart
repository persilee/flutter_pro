import 'package:flutter_riverpod/all.dart';
import 'package:pro_flutter/http/api_client.dart';
import 'package:pro_flutter/http/base_dio.dart';
import 'package:pro_flutter/http/base_error.dart';
import 'package:pro_flutter/models/post_model.dart';
import 'package:pro_flutter/widgets/page_state.dart';

class PostState {
  final List<Post> posts;
  final int pageIndex;
  final PageState pageState;
  final BaseError error;

  PostState({this.posts, this.pageIndex, this.pageState, this.error});

  PostState.initial()
      : posts = [],
        pageIndex = 1,
        pageState = PageState.initializedState,
        error = null;

  PostState copyWith({
    List<Post> posts,
    int pageIndex,
    PageState pageState,
    BaseError error,
  }) {
    return PostState(
      posts: posts ?? this.posts,
      pageIndex: pageIndex ?? this.pageIndex,
      pageState: pageState ?? this.pageState,
      error: error ?? this.error,
    );
  }
}

class PostsViewModel extends StateNotifier<PostState> {
  PostsViewModel([PostState state]) : super(state ?? PostState.initial()) {
    getPosts();
  }

  refreshPosts() {
    state = state.copyWith(
        posts: [],
        pageIndex: 1,
        pageState: PageState.refreshState,
        error: null);
    getPosts();
  }

  Future<void> getPosts() async {
    print(state.pageState);
    if (state.pageState == PageState.initializedState) {
      state = state.copyWith(pageState: PageState.busyState);
    }
    try {
      PostModel postModel =
          await ApiClient().getPosts(state.pageIndex.toString(), '10');
      state = state.copyWith(
          posts: [...state.posts, ...postModel.data.posts],
          pageIndex: state.pageIndex + 1,
          pageState: PageState.dataFetchState);
      if (postModel.data.posts.isEmpty || postModel.data.posts.length < 10) {
        state = state.copyWith(pageState: PageState.noMoreDataState);
      }
    } catch (e) {
      state = state.copyWith(
          pageState: PageState.errorState,
          error: BaseDio.getInstance().getDioError(e));
    }
  }
}
