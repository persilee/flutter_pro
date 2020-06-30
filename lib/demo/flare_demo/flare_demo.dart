import 'package:flutter/material.dart';
import 'package:pro_flutter/demo/flare_demo/flare_button_demo.dart';
import 'package:pro_flutter/demo/flare_demo/flare_sign_in_demo.dart';

import 'flare_sidebar_menu_demo.dart';

class FlareDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text('Flare Demo'),
         elevation: 0.0,
       ),
      body: ListView(
        children: <Widget>[
          ListItem(
            title: 'Sign In Demo',
            page: FlareSignInDemo(),
            icon: Icon(
              Icons.av_timer,
              color: Colors.black54,
            ),
          ),
          ListItem(
            title: 'Button Demo',
            page: FlareButtonDemo(),
            icon: Icon(
              Icons.edit_attributes,
              color: Colors.black54,
            ),
          ),
          ListItem(
            title: 'Sidebar Menu Demo',
            page: FlareSidebarMenuDemo(),
            icon: Icon(
              Icons.menu,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String title;
  final Widget page;
  final Widget icon;

  ListItem({
    this.title,
    this.page,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(title),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => page),
            );
          },
          leading: icon,
          contentPadding: EdgeInsets.only(left: 16.0, right: 6.0),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: Colors.black45,
            size: 22.0,
          ),
        ),
        Divider(),
      ],
    );
  }
}
