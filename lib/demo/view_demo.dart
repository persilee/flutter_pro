import 'package:flutter/material.dart';

class ViewDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageViewDemo();
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