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
              TextFeildDemo(),
            ],
          ),
        ),
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