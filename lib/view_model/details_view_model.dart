import 'package:flutter_riverpod/all.dart';
import 'package:pro_flutter/http/api_client.dart';
import 'package:pro_flutter/http/base_dio.dart';
import 'package:pro_flutter/http/base_error.dart';
import 'package:pro_flutter/models/post_model.dart';
import 'package:pro_flutter/models/single_post_model.dart';
import 'package:pro_flutter/widgets/page_state.dart';

class DetailsState {
  final Post post;
  final PageState pageState;
  final BaseError error;

  DetailsState({this.post, this.pageState, this.error});

  DetailsState.initial()
      : post = null,
        pageState = PageState.initializedState,
        error = null;

  DetailsState copyWith({
    Post post,
    PageState pageState,
    BaseError error,
  }) {
    return DetailsState(
      post: post ?? this.post,
      pageState: pageState ?? this.pageState,
      error: error ?? this.error,
    );
  }
}

class DetailsViewModel extends StateNotifier<DetailsState> {
  DetailsViewModel(int postId, [DetailsState state])
      : super(state ?? DetailsState.initial()) {
    getPostsDetails(postId);
  }

  /**
   * 获取文章详情
   */

  Future<void> getPostsDetails(int postId) async {
    if (state.pageState == PageState.initializedState) {
      state = state.copyWith(pageState: PageState.busyState);
    }

    try {
      SinglePostModel postModel = await ApiClient().getPostsById(postId);
      if (postModel.message == 'success') {
        await Future.delayed(Duration(milliseconds: 666));
        state = state.copyWith(
            post: postModel.data, pageState: PageState.dataFetchState);
      }
    } catch (e) {
      state = state.copyWith(
          pageState: PageState.errorState,
          error: BaseDio.getInstance().getDioError(e));
    }
  }
}
