import 'package:flutter/material.dart';
import 'package:pro_flutter/demo/provider_demo/goods_list_demo.dart';
import 'package:pro_flutter/demo/provider_demo/provider_counter_demo.dart';
import 'package:pro_flutter/demo/provider_demo/reverpod_page.dart';



class ProviderDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text('Provider Demo'),
         elevation: 0.0,
       ),
      body: ListView(
        children: <Widget>[
          ListItem(
            title: 'Provider Counter Demo',
            page: ProviderCounterDemo(title: 'Provider Counter Demo'),
            icon: Icon(
              Icons.access_time,
              color: Colors.black54,
            ),
          ),
          ListItem(
            title: 'Provider Goods List Demo',
            page: GoodsListDemo(title: 'Provider Counter Demo'),
            icon: Icon(
              Icons.star,
              color: Colors.black54,
            ),
          ),
          ListItem(
            title: 'Viverpod Demo',
            page: ReverPodPage(),
            icon: Icon(
              Icons.weekend,
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
