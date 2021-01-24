import 'package:flutter/material.dart';
import 'package:pro_flutter/demo/model/post.dart';

class DataTableDemo extends StatefulWidget {
  @override
  _DataTableDemoState createState() => _DataTableDemoState();
}

class _DataTableDemoState extends State<DataTableDemo> {
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DataTableDemo'),
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.all(18.0),
        child: ListView(
          children: <Widget>[
            DataTable(
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _sortAscending,
              columns: [
                DataColumn(
                  label: Text('Title'),
                  onSort: (int index, bool ascending) {
                    setState(() {
                      _sortColumnIndex = index;
                      _sortAscending = ascending;

                      posts.sort((a, b) {
                        if (!ascending) {
                          final c = a;
                          a = b;
                          b = c;
                        }

                        return a.title.length.compareTo(b.title.length);
                      });
                    });
                  },
                ),
                DataColumn(
                  label: Text('Author '),
                ),
                DataColumn(
                  label: Text('Image '),
                ),
              ],
              rows: posts
                  .map((post) => DataRow(
                          selected: post.liked,
                          onSelectChanged: (bool value) {
                            setState(() {
                              post.liked = value;
                            });
                          },
                          cells: [
                            DataCell(Text(post.title)),
                            DataCell(Text(post.author)),
                            DataCell(Image.network(post.imageUrl)),
                          ]))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
