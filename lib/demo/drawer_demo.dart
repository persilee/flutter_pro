import 'package:flutter/material.dart';

class DrawerDemo extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Drawer(
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
        );
    }
}