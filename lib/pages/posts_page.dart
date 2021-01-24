import 'package:flutter/material.dart';
import 'package:pro_flutter/view_model/posts_view_model.dart';

class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    print('aaa');
    PostsViewModel().getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts Page'),
      ),
      body: ListView.builder(
        itemCount: 1,
        controller: _scrollController,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Center(
              child: Text('MVVM'),
            ),
          );
        },
      ),
    );
  }
}
