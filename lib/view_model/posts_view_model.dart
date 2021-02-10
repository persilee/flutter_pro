import 'dart:async';

import 'package:flutter_riverpod/all.dart';
import 'package:pro_flutter/http/api_client.dart';
import 'package:pro_flutter/http/base_dio.dart';
import 'package:pro_flutter/http/base_error.dart';
import 'package:pro_flutter/models/base_model.dart';
import 'package:pro_flutter/models/category_model.dart';
import 'package:pro_flutter/models/post_model.dart';
import 'package:pro_flutter/models/single_post_model.dart';
import 'package:pro_flutter/widgets/page_state.dart';

/// 存储页面状态和数据状态（如，缺省页、错误页、加载中...）
class PostState {
  final List<Post> posts;
  final List<Category> categories;
  final int pageIndex;
  final PageState pageState; // 页面状态类
  final BaseError error; // 根据后端返回的错误的错误类

  PostState(
      {this.posts,
      this.categories,
      this.pageIndex,
      this.pageState,
      this.error});

  PostState.initial()
      : posts = [],
        categories = [],
        pageIndex = 1,
        pageState = PageState.initializedState,
        error = null;

  PostState copyWith({
    List<Post> posts,
    List<Category> categories,
    int pageIndex,
    PageState pageState,
    BaseError error,
  }) {
    return PostState(
      posts: posts ?? this.posts,
      categories: categories ?? this.categories,
      pageIndex: pageIndex ?? this.pageIndex,
      pageState: pageState ?? this.pageState,
      error: error ?? this.error,
    );
  }
}

/**
 * 获取分类tab数据
 */
class CategoryTabViewModel extends StateNotifier<PostState> {
  CategoryTabViewModel([PostState state])
      : super(state ?? PostState.initial()) {
    getCategory();
  }

  /**
   * 获取分类列表
   */
  Future<void> getCategory() async {
    try {
      CategoryModel categoryModel = await ApiClient().getCategory();
      if (categoryModel.message == 'success') {
        state = state.copyWith(categories: [...categoryModel.data]);
      }
    } catch (e) {
      state = state.copyWith(
          pageState: PageState.errorState,
          error: BaseDio.getInstance().getDioError(e));
    }
  }
}

/**
 * 获取分类数据，首页和关注页数据不属于任何分类，
 * 需要根据需求自定义查询需要的数据。
 */
class PostsViewModel extends StateNotifier<PostState> {
  PostsViewModel(int categoryId, [PostState state]) : super(state ?? PostState.initial()) {
    getPosts(categoryId);
  }

  void initPostState() {
    state = state.copyWith(
      posts: [],
      pageIndex: 1,
      pageState: PageState.initializedState,
      error: null,
    );
  }

  /**
   * 点赞
   */
  Future<void> clickLike(int postId, int index) async {
    try {
      BaseModel data = await ApiClient().like(postId);
      if (data.message == 'success') {
        SinglePostModel postModel =
            await ApiClient().getPostsById(postId, notView: true);

        /// 点赞成功后，更新点赞这条数据
        state.posts.setRange(index, index + 1, [postModel.data]);
        state = state.copyWith(posts: [...state.posts]);
      }
    } catch (e) {
      state = state.copyWith(
          pageState: PageState.errorState,
          error: BaseDio.getInstance().getDioError(e));
    }
  }

  /**
   * 获取文章列表
   */
  Future<void> getPosts(int categoryId, {bool isRefresh = false}) async {
    if (state.pageState == PageState.initializedState) {
      state = state.copyWith(pageState: PageState.busyState);
    }
    try {
      if (isRefresh) {
        PostModel postModel;
        if(categoryId == -2) {
          state = state.copyWith(pageState: PageState.emptyDataState);
          return;
        } else if (categoryId == -1) {
          postModel = await ApiClient().getPosts('1', '10');
        } else {
          postModel =
              await ApiClient().getPostsByCategoryId('1', '10', categoryId);
        }
        if (postModel.data.posts.isEmpty && state.pageIndex == 1) {
          state = state.copyWith(pageState: PageState.emptyDataState);
        } else {
          initPostState();
          state = state.copyWith(
            posts: [...postModel.data.posts],
            pageState: PageState.refreshState,
            pageIndex: 2,
          );
        }
      } else {
        PostModel postModel;
        if(categoryId == -2) {
          state = state.copyWith(pageState: PageState.emptyDataState);
          return;
        } else if (categoryId == -1) {
          postModel =
              await ApiClient().getPosts(state.pageIndex.toString(), '10');
        } else {
          postModel = await ApiClient().getPostsByCategoryId(
              state.pageIndex.toString(), '10', categoryId);
        }
        if (postModel.data.posts.isEmpty && state.pageIndex == 1) {
          state = state.copyWith(pageState: PageState.emptyDataState);
        } else {
          state = state.copyWith(
              posts: [...state.posts, ...postModel.data.posts],
              pageIndex: state.pageIndex + 1,
              pageState: PageState.dataFetchState);
          if (postModel.data.posts.isEmpty ||
              postModel.data.posts.length < 10) {
            state = state.copyWith(pageState: PageState.noMoreDataState);
          }
        }
      }
    } catch (e) {
      state = state.copyWith(
          pageState: PageState.errorState,
          error: BaseDio.getInstance().getDioError(e));
    }
  }
}
