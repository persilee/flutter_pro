import 'package:flutter/material.dart';
import 'package:pro_flutter/demo/model/post.dart';

class PostDataSource extends DataTableSource {
  final List<Post> _posts = posts;
  int _selectedCount = 0;

  @override
  int get rowCount => _posts.length;

  @override
  DataRow getRow(int index) {
    final Post _post = posts[index];

    return DataRow.byIndex(index: index, cells: <DataCell>[
      DataCell(Text(_post.title)),
      DataCell(Text(_post.author)),
      DataCell(Image.network(_post.imageUrl)),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void _sort(getField(post), bool ascending) {
    _posts.sort((a, b) {
      if (!ascending) {
        final c = a;
        a = b;
        b = c;
      }

      final aValue = getField(a);
      final bValue = getField(b);

      return Comparable.compare(aValue, bValue);
    });

    notifyListeners();
  }
}

class PaginatedDataTableDemo extends StatefulWidget {
  @override
  _PaginatedDataTableDemoState createState() => _PaginatedDataTableDemoState();
}

class _PaginatedDataTableDemoState extends State<PaginatedDataTableDemo> {
  int _sortColumnIndex;
  bool _sortAscending = true;
  final PostDataSource _postsDataSource = PostDataSource();

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
            PaginatedDataTable(
              header: Text('Posts'),
              source: _postsDataSource,
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _sortAscending,
              rowsPerPage: 6,
              columns: [
                DataColumn(
                  label: Text('Title'),
                  onSort: (int columnindex, bool ascending) {
                    _postsDataSource._sort(
                        (post) => post.title.length, ascending);

                    setState(() {
                      _sortColumnIndex = columnindex;
                      _sortAscending = ascending;
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
            ),
          ],
        ),
      ),
    );
  }
}
