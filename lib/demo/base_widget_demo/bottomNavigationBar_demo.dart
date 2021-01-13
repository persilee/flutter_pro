import 'package:flutter/material.dart';
import 'basic_demo.dart';
import 'components_demo.dart';
import 'layout_demo.dart';
import 'sliver_demo.dart';
import 'listview_demo.dart';

class BottomNavigationBarDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BottomNavigationBarState();
  }
}

class BottomNavigationBarState extends State<BottomNavigationBarDemo> {
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
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      fixedColor: Colors.black87,
      currentIndex: _currentIndex,
      onTap: _onTapHandler,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'My'),
      ],
    );
  }
}
