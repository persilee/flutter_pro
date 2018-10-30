import 'package:flutter/material.dart';
import 'dart:async';

enum Action { ok, cancel }

class AlertDialogDemo extends StatefulWidget {
  @override
  _AlertDialogDemoState createState() => _AlertDialogDemoState();
}

class _AlertDialogDemoState extends State<AlertDialogDemo> {
  String _chioce = 'Nothing';

  Future _openAlertDialog() async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog '),
          content: Text('Are you sure ?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context, Action.cancel);
              },
            ),
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.pop(context, Action.ok);
              },
            ),
          ],
        );
      },
    );

    switch (action) {
      case Action.cancel:
        setState(() {
          _chioce = 'Cancel';
        });
        break;
      case Action.ok:
        setState(() {
          _chioce = 'Ok';
        });
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AlertDialogDemo'),
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Your choice is: $_chioce .'),
            SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton.icon(
                  icon: Icon(Icons.insert_emoticon),
                  label: Text('Open Alert Dialog'),
                  onPressed: _openAlertDialog,
                  splashColor: Colors.grey[200],
                  elevation: 6.0,
                  shape: StadiumBorder(),
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
