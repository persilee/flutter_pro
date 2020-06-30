import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:pro_flutter/demo/flare_demo/flare_sign_in_controller.dart';
import 'package:pro_flutter/demo/flare_demo/signin_button.dart';
import 'package:pro_flutter/demo/flare_demo/tracking_text_input.dart';

class FlareSignInDemo extends StatefulWidget {
  @override
  _FlareSignInDemoState createState() => _FlareSignInDemoState();
}

class _FlareSignInDemoState extends State<FlareSignInDemo> {
  FlareSignInController _signInController;

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
        child: Container(
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
                      height: 260,
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
                          padding: EdgeInsets.all(30.0),
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
                                ),
                                SigninButton(
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () =>
                                      _signInController.submitPassword(),
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
        ),
      ),
    );
  }
}
