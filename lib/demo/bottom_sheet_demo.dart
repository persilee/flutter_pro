import 'package:flutter/material.dart';

class BottomSheetDemo extends StatefulWidget {
  @override
  _BottomSheetDemoState createState() => _BottomSheetDemoState();
}

class _BottomSheetDemoState extends State<BottomSheetDemo> {
  final _bottomSheetDemoState = GlobalKey<ScaffoldState>();

  _openBottomSheet() {
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

  _openModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200.0,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('Option A'),
                ),
                ListTile(
                  title: Text('Option B'),
                ),
                ListTile(
                  title: Text('Option C'),
                ),
              ],
            ),
          );
        });
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
