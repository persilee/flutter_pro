import 'package:flutter/material.dart';
import 'package:pro_flutter/demo/model/post.dart';

import 'post_show.dart';

class CardDemo extends StatefulWidget {
  @override
  _CardDemoState createState() => _CardDemoState();
}

class _CardDemoState extends State<CardDemo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
      ),
      child: ListView.builder(
        padding: EdgeInsets.only(
          top: 26.0,
        ),
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: <Widget>[
              Card(
                elevation: 0.0,
                margin: EdgeInsets.only(
                  bottom: 26.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 3 / 2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                        child: Image.network(
                          posts[index].imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.only(
                        top: 6.0,
                        bottom: 2.0,
                        left: 16.0,
                      ),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(posts[index].imageUrl),
                      ),
                      title: Text(posts[index].title),
                      subtitle: Text(posts[index].author),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: posts[index].liked
                              ? Colors.red[300]
                              : Colors.grey[300],
                          size: 20.0,
                        ),
                        onPressed: () {
                          setState(() {
                            posts[index].liked
                                ? posts[index].liked = false
                                : posts[index].liked = true;
                          });
                        },
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PostShow(
                                  post: posts[index],
                                )));
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
