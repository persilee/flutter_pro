import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:pro_flutter/http/api_client.dart';
import 'package:pro_flutter/http/base_dio.dart';
import 'package:pro_flutter/http/base_error.dart';
import 'package:pro_flutter/models/post_model.dart';
import 'package:pro_flutter/models/single_post_model.dart';
import 'package:pro_flutter/models/user_model.dart';
import 'package:pro_flutter/widgets/page_state.dart';

class ProfileState {
  final UserModel user;
  final List<Post> posts;
  final Rect textSize;
  final PageState pageState;
  final BaseError error;

  ProfileState({this.user, this.posts, this.textSize, this.pageState, this.error});

  ProfileState.initial()
      : user = null,
        posts = [],
        textSize = null,
        pageState = PageState.initializedState,
        error = null;

  ProfileState copyWith({
    UserModel user,
    List<Post> posts,
    Rect textSize,
    PageState pageState,
    BaseError error,
  }) {
    return ProfileState(
      user: user ?? this.user,
      posts: posts ?? this.posts,
      textSize: textSize ?? this.textSize,
      pageState: pageState ?? this.pageState,
      error: error ?? this.error,
    );
  }
}

class ProfileViewModel extends StateNotifier<ProfileState> {
  ProfileViewModel(int userId, [ProfileState state])
      : super(state ?? ProfileState.initial()){
    if(userId !=0) getUserInfo(userId);
  }

  /**
   * 获取字体大小
   */
  void getTextRect(Rect text) {
    state = state.copyWith(
      textSize: text,
    );
    print(state.textSize);
  }

  /**
   * 获取用户信息
   */
  Future<void> getUserInfo(int userId) async {
    if (state.pageState == PageState.initializedState) {
      state = state.copyWith(pageState: PageState.busyState);
    }

    try {
      UserModel user = await ApiClient().getUserInfo(userId);
      PostModel postModel = await ApiClient().getPostsByUser(userId);
      if(user.message == 'success' && postModel.message == 'success') {
            state = state.copyWith(
              user: user,
              posts: [...postModel.data.posts],
              pageState: PageState.dataFetchState,
            );
          }
    } catch (e) {
      state = state.copyWith(
          pageState: PageState.errorState,
          error: BaseDio.getInstance().getDioError(e));
    }
  }

  /**
   * 根据id 更新这条数据
   */
  Future<void> updatePostById(int postId, int index) async {
    try {
      SinglePostModel postModel =
      await ApiClient().getPostsById(postId, notView: true);
      state.posts.setRange(index, index + 1, [postModel.data]);
      state = state.copyWith(posts: [...state.posts]);
    } catch (e) {
      state = state.copyWith(
          pageState: PageState.errorState,
          error: BaseDio.getInstance().getDioError(e));
    }
  }
}
