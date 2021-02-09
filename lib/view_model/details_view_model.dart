import 'package:flutter_riverpod/all.dart';
import 'package:pro_flutter/http/api_client.dart';
import 'package:pro_flutter/http/base_dio.dart';
import 'package:pro_flutter/http/base_error.dart';
import 'package:pro_flutter/models/details_params.dart';
import 'package:pro_flutter/models/post_model.dart';
import 'package:pro_flutter/models/single_post_model.dart';
import 'package:pro_flutter/widgets/page_state.dart';

class DetailsState {
  final Post post;
  final List<Post> restPosts;
  final PageState pageState;
  final BaseError error;

  DetailsState({this.post, this.restPosts, this.pageState, this.error});

  DetailsState.initial()
      : post = null,
        restPosts = [],
        pageState = PageState.initializedState,
        error = null;

  DetailsState copyWith({
    Post post,
    List<Post> restPosts,
    PageState pageState,
    BaseError error,
  }) {
    return DetailsState(
      post: post ?? this.post,
      restPosts: restPosts ?? this.restPosts,
      pageState: pageState ?? this.pageState,
      error: error ?? this.error,
    );
  }
}

class DetailsViewModel extends StateNotifier<DetailsState> {
  DetailsViewModel(DetailsParams params, [DetailsState state])
      : super(state ?? DetailsState.initial()) {
    getPostsDetails(params);
  }

  /**
   * 获取文章详情
   */

  Future<void> getPostsDetails(DetailsParams params) async {
    if (state.pageState == PageState.initializedState) {
      state = state.copyWith(pageState: PageState.busyState);
    }

    try {
      SinglePostModel singlePostModel =
          await ApiClient().getPostsById(params.postId);
      PostModel postModel = await ApiClient().getPostsByUser(params.userId);
      if (singlePostModel.message == 'success') {
        await Future.delayed(Duration(milliseconds: 666));
        state = state.copyWith(
          post: singlePostModel.data,
          restPosts: [...postModel.data.posts],
          pageState: PageState.dataFetchState,
        );
      }
    } catch (e) {
      state = state.copyWith(
          pageState: PageState.errorState,
          error: BaseDio.getInstance().getDioError(e));
    }
  }
}
