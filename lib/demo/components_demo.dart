import 'package:flutter/material.dart';
import '../demo/button_demo.dart';
import '../demo/floating_action_button_demo.dart';
class ComponentsDome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ComponentsDome'),
        elevation: 0.0,
      ),
      body: ListView(
        children: < Widget > [
          ListItem(title: 'FloatingActionButton', page: FloatingActionButtonDemo(), ),
          ListItem(title: 'Button', page: ButtonDemo(), ),
        ],
      ),
    );
  }
}


class _WidgetDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WidgetDemo'),
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: < Widget > [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: < Widget > [

              ],
            ),
          ],
        ),
      ),
    );
  }
}



class ListItem extends StatelessWidget {

  final String title;
  final Widget page;

  ListItem({
    this.title,
    this.page,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => page),
        );
      },
    );
  }
}