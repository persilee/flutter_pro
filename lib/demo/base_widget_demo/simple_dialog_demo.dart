import 'package:flutter/material.dart';
import 'dart:async';

enum Option { A, B, C }

class SimpleDialogDemo extends StatefulWidget {
  @override
  _SimpleDialogDemoState createState() => _SimpleDialogDemoState();
}

class _SimpleDialogDemoState extends State<SimpleDialogDemo> {
  String _chioce = 'Nothing';

  Future _openSimpleDialog() async {
    final option = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('SimpleDialog'),
          children: <Widget>[
            SimpleDialogOption(
              child: Text('optin A'),
              onPressed: () {
                Navigator.pop(context, Option.A);
              },
            ),
            SimpleDialogOption(
              child: Text('optin B'),
              onPressed: () {
                Navigator.pop(context, Option.B);
              },
            ),
            SimpleDialogOption(
              child: Text('optin C'),
              onPressed: () {
                Navigator.pop(context, Option.C);
              },
            ),
          ],
        );
      },
    );

    switch (option) {
      case Option.A:
        setState(() {
          _chioce = 'A';
        });
        break;
      case Option.B:
        setState(() {
          _chioce = 'B';
        });
        break;
      case Option.C:
        setState(() {
          _chioce = 'C';
        });
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SimpleDialogDemo'),
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Your choice is: $_chioce'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.insert_comment,color: Color(0xe61f1e1e),),
        backgroundColor: Colors.yellow,
        onPressed: _openSimpleDialog,
      ),
    );
  }
}
