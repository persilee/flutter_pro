import 'package:flutter/material.dart';
import 'package:pro_flutter/demo/model/post.dart';

class PostShow extends StatelessWidget {
  final Post post;

  PostShow({
    //@required为必传的参数，没有这个注解的为选传
    @required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${post.title}'),
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Image.network(
            post.imageUrl,
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.all(36.0),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${post.title}',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  '${post.author}',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 32.0,
                ),
                Text(
                  '${post.description}',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
