import 'package:flutter/material.dart';

class FormsDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: Colors.black,
        ),
        child: Container(
          padding: EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RegisterForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final registerFormKey = GlobalKey<FormState>();
  String uname, pwd;

  void submitRegisterForm () {
    registerFormKey.currentState.save();
    registerFormKey.currentState.validate();
    debugPrint('uname: ${ uname }');
    debugPrint('pwd: ${ pwd }');
  }

  String validatorUname (value) {
    if (value.isEmpty) {
      return 'uname is required';
    }

    return null;
  }
  String validatorPwd (value) {
    if (value.isEmpty) {
      return 'pwd is required';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: registerFormKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: 'uname',
              helperText: '',
            ),
            onSaved: (value) {
              uname = value;
            },
            validator: validatorUname,
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'pwd',
              helperText: ''
            ),
            onSaved: (value) {
              pwd = value;
            },
            validator: validatorPwd,
          ),
          SizedBox(height: 14.0,),
          Container(
            width: double.infinity,
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text('register', style: TextStyle(color: Colors.white,),),
              elevation: 0.0,
              onPressed: submitRegisterForm,
            ),
          ),
        ],
      ),
    );
  }
}

class TextFeildDemo extends StatefulWidget {
  _TextFeildDemoState createState() => _TextFeildDemoState();
}

class _TextFeildDemoState extends State<TextFeildDemo> {
  final textEdtingController = TextEditingController();

  @override
    void dispose() {
      textEdtingController.dispose();
      super.dispose();
    }

  @override
    void initState() {
      super.initState();
      // textEdtingController.text = 'Hi~';
      textEdtingController.addListener(
        () {
          debugPrint('listener: ${textEdtingController.text}');
        }
      );

    }

  @override
  Widget build(BuildContext context) {
    return TextField(
      // onChanged: (value) {
      //   debugPrint('input: $value'); 
      // },
      controller: textEdtingController,
      onSubmitted: (value) {
        debugPrint('submit: $value');
      },
      decoration: InputDecoration(
        icon: Icon(Icons.art_track),
        labelText: 'name',
        hintText: 'Enter your name',
        // border: InputBorder.none,
        border: OutlineInputBorder(),
        filled: true,
      ),
    );
  }
}

class ThemeDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
    );
  }
}