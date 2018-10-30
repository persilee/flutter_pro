import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './demo/drawer_demo.dart';
import './demo/bottomNavigationBar_demo.dart';
import './demo/navigator_demo.dart';
import './demo/forms_demo.dart';
import './demo/components_demo.dart';
import './demo/basic_demo.dart';
import './demo/layout_demo.dart';
import './demo/view_demo.dart';
import './demo/sliver_demo.dart';
import './demo/listview_demo.dart';

void main() {
  debugPaintSizeEnabled = true;
  runApp(
    App()
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: Home(),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/about': (context) => Page(title: 'About', ),
        '/form': (context) => FormsDemo(),
        '/components': (context) => ComponentsDome(),
      },
      theme: ThemeData(
        primaryColor: Colors.yellow,
        highlightColor: Color.fromRGBO(255, 255, 255, 0.6),
        splashColor: Colors.white70,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State < HomePage > {
  int _currentIndex = 0;
  
  void _onTapHandler(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text('Lishaoy.net'),
          actions: < Widget > [
            IconButton(
              icon: Icon(Icons.search),
              tooltip: 'Search',
              onPressed: () => debugPrint('Search Button is pressed'),
            )
          ],
          elevation: 0.0,
          bottom: _getBottom(),
        ),
        body: _getPages(),
        drawer: DrawerDemo(),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.black87,
          currentIndex: _currentIndex,
          onTap: _onTapHandler,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(_currentIndex == 0 ? "assets/images/home.png" : "assets/images/off_home.png",height: 27.0,),
              title: Text('Home')
            ),
            BottomNavigationBarItem(
              icon: Image.asset(_currentIndex == 1 ? "assets/images/history.png" : "assets/images/off_history.png",height: 28.0,),
              title: Text('History')
            ),
            BottomNavigationBarItem(
              icon: Image.asset(_currentIndex == 2 ? "assets/images/Listview.png" : "assets/images/off_Listview.png",height: 28.0,),
              title: Text('List')
            ),
            BottomNavigationBarItem(
              icon: Image.asset(_currentIndex == 3 ? "assets/images/wode.png" : "assets/images/off_wode.png",height: 30.0,),
              title: Text('My')
            ),
          ],
        ),
      ),
    );
  }
  
  PreferredSizeWidget _getBottom() {
    if(_currentIndex == 0) {
      return TabBar(
            isScrollable: false,
            unselectedLabelColor: Colors.black38,
            indicatorColor: Colors.black54,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 1.0,
            tabs: < Widget > [
              Tab(icon: Icon(Icons.shopping_cart)),
              Tab(icon: Icon(Icons.spa)),
              Tab(icon: Icon(Icons.star)),
              Tab(icon: Icon(Icons.apps)),
            ],
          );
    }else{
      return null;
    }
  }

  Widget _getPages() {
    switch (_currentIndex) {
      case 0:
        return TabBarView(
          children: < Widget > [
            ListViewDemo(),
            // Icon(Icons.spa, size: 126.0, color: Colors.black12,),
            BasicDemo(),
            // Icon(Icons.star, size: 126.0, color: Colors.black12,),
            LayoutDemo(),
            ViewDemo(),
          ],
        );
        break;
      case 1:
        return ComponentsDome();
        break;
      case 2:
        return SliverDemo();
        break;
      default:
        return null;
        break;
    }
  }
}