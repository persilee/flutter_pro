import 'package:flutter/material.dart';

class DrawerDemo extends StatefulWidget {
  @override
  _DrawerDemoState createState() => _DrawerDemoState();
}

class _DrawerDemoState extends State<DrawerDemo> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: < Widget > [
          UserAccountsDrawerHeader(
            accountName: Text('Persilee', style: TextStyle(fontWeight: FontWeight.bold)),
            accountEmail: Text('i@lishaoy.net',style: TextStyle(fontSize: 12.0),),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://cn.gravatar.com/avatar/ebf4749fb999f134566782c20e67a3ac?s=60&d=robohash&r=G'),
            ),
            decoration: BoxDecoration(
              color: Colors.yellow[400],
              image: DecorationImage(
                image: NetworkImage('https://cdn.lishaoy.net/image/Black-and-White-Gorilla.webp'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.yellow[400].withOpacity(0.65),
                  BlendMode.lighten
                )
              )
            ),
          ),
          ListTile(
            title: Text('Messages', textAlign: TextAlign.left,),
            leading: Icon(Icons.message, color: Colors.black38, size: 20.0,),
            onTap: () => Navigator.pop(context),
            dense: true,
          ),
          ListTile(
            title: Text('Favorite', textAlign: TextAlign.left, ),
            leading: Icon(Icons.mood, color: Colors.black38, size: 20.0, ),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            title: Text('Settings', textAlign: TextAlign.left, ),
            leading: Icon(Icons.settings, color: Colors.black38, size: 20.0, ),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}