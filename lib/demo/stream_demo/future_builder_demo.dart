import 'package:flutter/material.dart';

class FutureBuilderDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Future Builder Demo'),
      ),
      body: FutureBuilder(
        future: _getListData(),
        builder: (buildContext, snapshot) {
          if (snapshot.hasError) {
            return _getInfoMessage(snapshot.error);
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                backgroundColor: Colors.yellow[100],
              ),
            );
          }
          var listData = snapshot.data;
          if (listData.length == 0) {
            return _getInfoMessage('No data found');
          }

          return ListView.builder(
            itemCount: listData.length,
            itemBuilder: (buildContext, index) {
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text(listData[index]),
                  ),
                  Divider(),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _getInfoMessage(String msg) {
    return Center(
      child: Text(msg),
    );
  }

  Future<List<String>> _getListData(
      {bool hasError = false, bool hasData = true}) async {
    await Future.delayed(Duration(seconds: 1));

    if (hasError) {
      return Future.error('获取数据出现问题，请再试一次');
    }

    if (!hasData) {
      return List<String>();
    }

    return List<String>.generate(10, (index) => '$index content');
  }
}
