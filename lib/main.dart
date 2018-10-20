import 'package:flutter/material.dart';
import './demo/listview_demo.dart';

void main() {
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
      home: Home(),
      theme: ThemeData(
        primaryColor: Colors.yellow
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Navigration',
            onPressed: () => debugPrint('Navitration Button is pressed'),
          ),
          title: Text('Lishaoy.net'),
          actions: < Widget > [
            IconButton(
              icon: Icon(Icons.search),
              tooltip: 'Search',
              onPressed: () => debugPrint('Search Button is pressed'),
            )
          ],
          elevation: 6.0,
          bottom: TabBar(
            tabs: < Widget > [
              Tab(icon: Icon(Icons.shopping_cart)),
              Tab(icon: Icon(Icons.spa)),
              Tab(icon: Icon(Icons.star)),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Icon(Icons.shopping_cart, size: 126.0, color: Colors.black12,),
            Icon(Icons.spa, size: 126.0, color: Colors.black12,),
            Icon(Icons.star, size: 126.0, color: Colors.black12,),
          ],
        )
      ),
    );
  }
}