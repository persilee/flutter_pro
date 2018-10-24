import 'package:flutter/material.dart';
import '../model/post.dart';

class ViewDemo extends StatelessWidget {
   Widget _pageItemBuilder(BuildContext context, int index) {
     return Stack(
        children: <Widget>[
          SizedBox.expand(
            child: Image.network(
              posts[index].imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 20.0,
            left: 20.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  posts[index].title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  posts[index].author,
                  style: TextStyle(fontWeight: FontWeight.w100),
                ),
              ],
            ),
          ),
        ],
     );
   }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: posts.length,
      itemBuilder:  _pageItemBuilder,
    );
  }
}

class PageViewDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView(
      // pageSnapping: false,
      // scrollDirection: Axis.vertical,
      onPageChanged: (currentPage) => debugPrint('$currentPage'),
      controller: PageController(
        initialPage: 1,
        keepPage: false,
        viewportFraction: 0.85,
      ),
      children: <Widget>[
         Container(
           color: Colors.amberAccent[100],
           alignment: Alignment(0.0, 0.0),
           child: Text('One', style: TextStyle(fontSize: 23.0, color: Colors.black),),
         ),
         Container(
           color: Colors.blueAccent[100],
           alignment: Alignment(0.0, 0.0),
           child: Text('Two', style: TextStyle(fontSize: 23.0, color: Colors.black),),
         ),
         Container(
           color: Colors.blueGrey[100],
           alignment: Alignment(0.0, 0.0),
           child: Text('Three', style: TextStyle(fontSize: 23.0, color: Colors.black),),
         ),
      ],
    );
  }
}