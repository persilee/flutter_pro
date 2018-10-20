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
        primaryColor: Colors.yellow,
        highlightColor: Color.fromRGBO(255, 255, 255, 0.6),
        splashColor: Colors.white70,
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
            unselectedLabelColor: Colors.black38,
            indicatorColor: Colors.black54,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 1.0,
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
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('Persilee', style: TextStyle(fontWeight: FontWeight.bold)),
                accountEmail: Text('i@lishaoy.net'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage('https://cn.gravatar.com/avatar/ebf4749fb999f134566782c20e67a3ac?s=60&d=robohash&r=G'),
                ),
                decoration: BoxDecoration(
                  color: Colors.yellow[400],
                  image: DecorationImage(
                    image: NetworkImage('https://resources.ninghao.org/images/childhood-in-a-picture.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.yellow[400].withOpacity(0.65), 
                      BlendMode.lighten
                    )
                  )
                ),
              ),
              ListTile(
                title: Text('Messages', textAlign: TextAlign.right,),
                trailing: Icon(Icons.message, color: Colors.black12, size: 20.0,),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                title: Text('Favorite', textAlign: TextAlign.right,),
                trailing: Icon(Icons.mood, color: Colors.black12, size: 20.0,),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                title: Text('Settings', textAlign: TextAlign.right,),
                trailing: Icon(Icons.settings, color: Colors.black12, size: 20.0,),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}