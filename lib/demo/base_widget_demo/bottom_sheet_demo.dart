import 'dart:async';
import 'package:flutter/material.dart';

class BottomSheetDemo extends StatefulWidget {
  @override
  _BottomSheetDemoState createState() => _BottomSheetDemoState();
}

class _BottomSheetDemoState extends State<BottomSheetDemo> {
  final _bottomSheetDemoState = GlobalKey<ScaffoldState>();
  String _choice = 'Nothing';

  void _openBottomSheet() {
    _bottomSheetDemoState.currentState
        .showBottomSheet((BuildContext context) => BottomAppBar(
              child: Container(
                height: 100.0,
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.mic),
                    SizedBox(
                      width: 16.0,
                    ),
                    Text('--/--'),
                    Expanded(
                      child: Text(
                        'This is bottomSheet',
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  Future _openModalBottomSheet() async {
    final option = await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200.0,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('Option A'),
                  onTap: () {
                    Navigator.pop(context, 'A');
                  },
                ),
                ListTile(
                  title: Text('Option B'),
                  onTap: () {
                    Navigator.pop(context, 'B');
                  },
                ),
                ListTile(
                  title: Text('Option C'),
                  onTap: () {
                    Navigator.pop(context, 'C');
                  },
                ),
              ],
            ),
          );
        });

    switch (option) {
      case 'A':
        setState(() {
          _choice = 'A';
        });
        break;
      case 'B':
        setState(() {
          _choice = 'B';
        });
        break;
      case 'C':
        setState(() {
          _choice = 'C';
        });
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _bottomSheetDemoState,
      appBar: AppBar(
        title: Text('BottomSheetDemo'),
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You choice is : $_choice'),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.missed_video_call),
                  label: Text('BottomSheet'),
                  onPressed: _openBottomSheet,
                  splashColor: Colors.grey[200],
                ),
                FlatButton.icon(
                  icon: Icon(Icons.more_horiz),
                  label: Text('ModalBottomSheet'),
                  onPressed: _openModalBottomSheet,
                  splashColor: Colors.grey[200],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
