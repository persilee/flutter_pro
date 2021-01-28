import 'package:flutter_riverpod/all.dart';
import 'package:pro_flutter/http/api_client.dart';
import 'package:pro_flutter/http/base_dio.dart';
import 'package:pro_flutter/http/base_error.dart';
import 'package:pro_flutter/models/login_model.dart';
import 'package:pro_flutter/widgets/page_state.dart';
import 'package:sp_util/sp_util.dart';

class LoginState {
  final Login login;
  final bool isLogin;
  final PageState pageState;
  final BaseError error;

  LoginState({this.login, this.isLogin, this.pageState, this.error});

  LoginState.initial()
      : login = Login(),
        isLogin = false,
        pageState = PageState.initializedState,
        error = null;

  LoginState copyWith({
    Login login,
    bool isLogin,
    PageState pageState,
    BaseError error,
  }) {
    return LoginState(
        login: login ?? this.login,
        isLogin: isLogin ?? this.isLogin,
        pageState: pageState ?? this.pageState,
        error: error ?? this.error);
  }
}

class LoginViewModel extends StateNotifier<LoginState> {
  LoginViewModel([LoginState state]) : super(state ?? LoginState.initial());

  Future<void> login(String name, String pwd) async {

    state = state.copyWith(login: Login(name: name, password: pwd));

    try {
      LoginModel model = await ApiClient().login(state.login);
      if (model.message == 'success') {
        SpUtil.putObject('User', model.data);
        SpUtil.putString('Authorization', 'Bearer ${model.data.token}');
        state = state.copyWith(isLogin: true, error: null);
      }
    } catch (e) {
      state = state.copyWith(
        pageState: PageState.errorState,
        error: BaseDio.getInstance().getDioError(e),
      );
    }
  }
}
