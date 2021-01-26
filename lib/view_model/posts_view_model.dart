import 'package:flutter_riverpod/all.dart';
import 'package:pro_flutter/http/api_client.dart';
import 'package:pro_flutter/models/post_model.dart';
import 'package:pro_flutter/widgets/page_state.dart';

class PostState {
  final List<Post> posts;
  final int pageIndex;
  final PageState pageState;

  PostState({this.posts, this.pageIndex, this.pageState});

  PostState.initial()
      : posts = [],
        pageIndex = 1,
        pageState = PageState.initializedState;

  PostState copyWith({
    List<Post> posts,
    int pageIndex,
    PageState pageState,
  }) {
    return PostState(
      posts: posts ?? this.posts,
      pageIndex: pageIndex ?? this.pageIndex,
      pageState: pageState ?? this.pageState,
    );
  }
}

class PostsViewModel extends StateNotifier<PostState> {
  PostsViewModel([PostState state]) : super(state ?? PostState.initial()) {
    getPosts();
  }

  Future<void> getPosts() async {
    state = state.copyWith(pageState: PageState.busyState);
    try {
      PostModel postModel =
          await ApiClient().getPosts(state.pageIndex.toString(), '10');
      if (postModel.data.posts.isEmpty || postModel.data.posts.length < 10) {
        state = state.copyWith(pageState: PageState.noMoreDataState);
      }
      state = state.copyWith(
          posts: [...state.posts, ...postModel.data.posts],
          pageIndex: state.pageIndex + 1);
    } catch (e) {
      print(e);
      state = state.copyWith(pageState: PageState.errorState);
    }
  }
}
