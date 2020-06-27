import 'package:flutter/material.dart';
import 'package:pro_flutter/demo/base_widget_demo/components_demo.dart';
import 'package:pro_flutter/demo/provider_demo/provider_demo.dart';



class RouterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          ListItem(
            title: 'Base Widget Demo',
            page: ComponentsDome(),
            icon: Icon(
              Icons.apps,
              color: Colors.black54,
            ),
          ),
          ListItem(
            title: 'Provider Demo',
            page: ProviderDemo(),
            icon: Icon(
              Icons.cached,
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
