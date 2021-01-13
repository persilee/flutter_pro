import 'package:flutter/material.dart';

class BaseStatefulDemo extends StatefulWidget {
  @override
  _BaseStatefulDemoState createState() => _BaseStatefulDemoState();
}

class _BaseStatefulDemoState extends State<BaseStatefulDemo> {
  List<String> _pageData;

  bool get _fetchingData => _pageData == null;

  @override
  void initState() {
    _getListData(hasError: false, hasData: true)
        .then((data) => setState(() {
              if (data.length == 0) {
                data.add('No data fount');
              }
              _pageData = data;
            }))
        .catchError((error) => setState(() {
              _pageData = [error];
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Base Stateful Demo'),
      ),
      body: _fetchingData
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                backgroundColor: Colors.yellow[100],
              ),
            )
          : ListView.builder(
              itemCount: _pageData.length,
              itemBuilder: (buildContext, index) {
                return getListDataUi(index);
              },
            ),
    );
  }

  Widget getListDataUi(int index) {
    return Column(
                children: <Widget>[
                  ListTile(
                    title: Text(_pageData[index]),
                  ),
                  Divider(),
                ],
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
