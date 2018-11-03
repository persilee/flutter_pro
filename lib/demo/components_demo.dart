import 'package:flutter/material.dart';
import '../demo/button_demo.dart';
import '../demo/floating_action_button_demo.dart';
import '../demo/popup_menu_button_demo.dart';
import '../demo/simple_dialog_demo.dart';
import '../demo/alert_dialog_demo.dart';
import '../demo/bottom_sheet_demo.dart';
import '../demo/snack_bar_demo.dart';
import '../demo/expansion_panel_demo.dart';
import '../demo/chip_demo.dart';
import '../demo/data_table_demo.dart';
import '../demo/paginated_table_demo.dart';
import '../demo/stepper_demo.dart';

class ComponentsDome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('ComponentsDome'),
      //   elevation: 0.0,
      // ),
      body: ListView(
        children: <Widget>[
          ListItem(
            title: 'FloatingActionButton',
            page: FloatingActionButtonDemo(), 
            icon: Icon(
              Icons.bubble_chart,
              color: Colors.black54,
            ),
          ),
          Divider(),
          ListItem(
            title: 'ButtonDemo',
            page: ButtonDemo(),
            icon: Icon(
              Icons.mood,
              color: Colors.black54,
            ),
          ),
          Divider(),
          ListItem(
            title: 'PopupMenuButtonDemo',
            page: PopupMenuButtonDemo(),
            icon: Icon(
              Icons.menu,
              color: Colors.black54,
            ),
          ),
          Divider(),
          ListItem(
            title: 'SimpleDialogDemo',
            page: SimpleDialogDemo(),
            icon: Icon(
              Icons.import_contacts,
              color: Colors.black54,
            ),
          ),
          Divider(),
          ListItem(
            title: 'AlertDialogDemo',
            page: AlertDialogDemo(),
            icon: Icon(
              Icons.insert_comment,
              color: Colors.black54,
            ),
          ),
          Divider(),
          ListItem(
            title: 'BottomSheetDemo',
            page: BottomSheetDemo(),
            icon: Icon(
              Icons.minimize,
              color: Colors.black54,
            ),
          ),
          Divider(),
          ListItem(
            title: 'SnackBarDemo',
            page: SnackBarDemo(),
            icon: Icon(
              Icons.notifications,
              color: Colors.black54,
            ),
          ),
          Divider(),
          ListItem(
            title: 'ExpansionPanelDemo',
            page: ExpansionPanelDemo(),
            icon: Icon(
              Icons.playlist_play,
              color: Colors.black54,
            ),
          ),
          Divider(),
          ListItem(
            title: 'ChipDemo',
            page: ChipDemo(),
            icon: Icon(
              Icons.edit_attributes,
              color: Colors.black54,
            ),
          ),
          Divider(),
          ListItem(
            title: 'DataTableDemo',
            page: DataTableDemo(),
            icon: Icon(
              Icons.table_chart,
              color: Colors.black54,
            ),
          ),
          Divider(),
          ListItem(
            title: 'PaginatedDataTableDemo',
            page: PaginatedDataTableDemo(),
            icon: Icon(
              Icons.view_day,
              color: Colors.black54,
            ),
          ),
          Divider(),
          ListItem(
            title: 'StepperDemo',
            page: StepperDemo(),
            icon: Icon(
              Icons.timeline,
              color: Colors.black54,
            ),
          ),
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
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[],
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
      contentPadding: EdgeInsets.only(left: 16.0, right: 6.0),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: Colors.black45,
        size: 22.0,
      ),
    );
  }
}
