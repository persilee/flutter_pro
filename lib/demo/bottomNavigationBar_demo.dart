import 'package:flutter/material.dart';
import '../demo/basic_demo.dart';
import '../demo/layout_demo.dart';
import '../demo/view_demo.dart';
import '../demo/sliver_demo.dart';
import '../demo/listview_demo.dart';
import '../demo/components_demo.dart';

class BottomNavigationBarDemo extends StatefulWidget {
  @override
  State < StatefulWidget > createState() {
    // TODO: implement createState
    return BottomNavigationBarState();
  }
}

class BottomNavigationBarState extends State < BottomNavigationBarDemo > {
  int _currentIndex = 0;
  Widget getPages() {
    print(_currentIndex);
    switch (_currentIndex) {
      case 0:
        return TabBarView(
          children: <Widget>[
            ListViewDemo(),
            // Icon(Icons.spa, size: 126.0, color: Colors.black12,),
            BasicDemo(),
            // Icon(Icons.star, size: 126.0, color: Colors.black12,),
            LayoutDemo(),
            SliverDemo(),
          ],
        );
        break;
      case 1:
        return Container(
          child: ComponentsDome(),
        );
        break;
      case 2:
        return null;
        break;
      default:
        return null;
        break;
    }
  }
  void _onTapHandler(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      fixedColor: Colors.black87,
      currentIndex: _currentIndex,
      onTap: _onTapHandler,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          title: Text('Explore')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          title: Text('History')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          title: Text('List')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text('My')
        ),
      ],
    );
  }
}