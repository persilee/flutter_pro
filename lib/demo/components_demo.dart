import 'package:flutter/material.dart';
import '../demo/button_demo.dart';
import '../demo/floating_action_button_demo.dart';
import '../demo/popup_menu_button_demo.dart';
import '../demo/simple_dialog_demo.dart';
class ComponentsDome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('ComponentsDome'),
      //   elevation: 0.0,
      // ),
      body: ListView(
        children: < Widget > [
          ListItem(title: 'FloatingActionButton', page: FloatingActionButtonDemo(), icon: Icon(Icons.bubble_chart,color: Colors.black54,),),
          Divider(),
          ListItem(title: 'Button', page: ButtonDemo(), icon: Icon(Icons.mood,color: Colors.black54,),),
          Divider(),
          ListItem(title: 'PopupMenuButtonDemo', page: PopupMenuButtonDemo(), icon: Icon(Icons.menu,color: Colors.black54,),),
          Divider(),
          ListItem(title: 'SimpleDialogDemo', page: SimpleDialogDemo(), icon: Icon(Icons.import_contacts,color: Colors.black54,),),
          Divider(),
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
  final Widget icon;

  ListItem({
    this.title,
    this.page,
    this.icon,
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
      leading: icon,
      contentPadding: EdgeInsets.only(left: 16.0),
      trailing: Icon(Icons.keyboard_arrow_right,color: Colors.black45,size: 22.0,),
    );
  }
}