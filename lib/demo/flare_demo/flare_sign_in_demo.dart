import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_flutter/demo/flare_demo/flare_sign_in_controller.dart';
import 'package:pro_flutter/demo/flare_demo/signin_button.dart';
import 'package:pro_flutter/demo/flare_demo/tracking_text_input.dart';
import 'package:pro_flutter/http/base_error.dart';
import 'package:pro_flutter/view_model/login_view_model.dart';

final loginProvider = StateNotifierProvider.autoDispose((ref) => LoginViewModel());

class FlareSignInDemo extends StatefulWidget {
  @override
  _FlareSignInDemoState createState() => _FlareSignInDemoState();
}

class _FlareSignInDemoState extends State<FlareSignInDemo> {
  FlareSignInController _signInController;
  bool isEmptyUser = false;
  bool isEmptyPwd = false;

  @override
  void initState() {
    _signInController = FlareSignInController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: Colors.black54,
        ),
        child: Consumer(
          builder: (context, watch, _) {
            final loginModel = watch(loginProvider);
            final loginState = watch(loginProvider.state);
            return Container(
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              stops: [
                            0.0,
                            1.0
                          ],
                              colors: [
                            Color.fromRGBO(255, 193, 7, .6),
                            Color.fromRGBO(255, 235, 59, .6),
                          ])),
                    ),
                  ),
                  Positioned.fill(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 160,
                          padding: EdgeInsets.only(left: 16.0, right: 16.0),
                          child: FlareActor(
                            'assets/Teddy.flr',
                            shouldClip: false,
                            alignment: Alignment.bottomCenter,
                            fit: BoxFit.contain,
                            controller: _signInController,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(25.0)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Form(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    TrackingTextInput(
                                      label: 'Email',
                                      hint: 'email address',
                                      onCaretMoved: (Offset caret) {
                                        _signInController.lookAt(caret);
                                      },
                                      onTextChanged: (String value) {
                                        _signInController.setName(value);
                                      },
                                      autovalidateMode: loginState.error is UserNotExist || loginState.error is UserNameEmpty ? AutovalidateMode.always : AutovalidateMode.disabled,
                                      validator: (value) {
                                        if(value.isEmpty) {
                                          return 'Email 不能为空';
                                        } else if (loginState.error is UserNotExist) {
                                          return loginState.error?.message;
                                        }
                                        return '';
                                      },
                                    ),
                                    TrackingTextInput(
                                      label: 'Password',
                                      hint: 'Try bears',
                                      isObscured: true,
                                      onCaretMoved: (Offset caret) {
                                        _signInController.coverEyes(caret != null);
                                        _signInController.lookAt(null);
                                      },
                                      onTextChanged: (String value) {
                                        _signInController.setPassword(value);
                                      },
                                      autovalidateMode: loginState.error is PwdNotMatch || loginState.error is PwdEmpty ? AutovalidateMode.always : AutovalidateMode.disabled,
                                      validator: (value) {
                                        if(value.isEmpty) {
                                          return '密码不能为空';
                                        } else if (loginState.error is PwdNotMatch) {
                                          return loginState.error?.message;
                                        }
                                        return '';
                                      },
                                    ),
                                    SigninButton(
                                      child: Text(
                                        'Sign In',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () =>
                                          _signInController.submitPassword(context),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
