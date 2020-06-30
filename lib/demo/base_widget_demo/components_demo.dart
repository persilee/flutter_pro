import 'package:flutter/material.dart';
import 'package:pro_flutter/demo/base_widget_demo/paginated_table_demo.dart';
import 'package:pro_flutter/demo/base_widget_demo/popup_menu_button_demo.dart';
import 'package:pro_flutter/demo/base_widget_demo/simple_dialog_demo.dart';
import 'package:pro_flutter/demo/base_widget_demo/snack_bar_demo.dart';
import 'package:pro_flutter/demo/base_widget_demo/stepper_demo.dart';

import 'alert_dialog_demo.dart';
import 'bottom_sheet_demo.dart';
import 'button_demo.dart';
import 'chip_demo.dart';
import 'data_table_demo.dart';
import 'expansion_panel_demo.dart';
import 'floating_action_button_demo.dart';
import 'forms_demo.dart';


class ComponentsDome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text('Base Widget Dome'),
         elevation: 0.0,
       ),
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
          ListItem(
            title: 'ButtonDemo',
            page: ButtonDemo(),
            icon: Icon(
              Icons.mood,
              color: Colors.black54,
            ),
          ),
          ListItem(
            title: 'PopupMenuButtonDemo',
            page: PopupMenuButtonDemo(),
            icon: Icon(
              Icons.menu,
              color: Colors.black54,
            ),
          ),
          ListItem(
            title: 'SimpleDialogDemo',
            page: SimpleDialogDemo(),
            icon: Icon(
              Icons.import_contacts,
              color: Colors.black54,
            ),
          ),
          ListItem(
            title: 'AlertDialogDemo',
            page: AlertDialogDemo(),
            icon: Icon(
              Icons.insert_comment,
              color: Colors.black54,
            ),
          ),
          ListItem(
            title: 'BottomSheetDemo',
            page: BottomSheetDemo(),
            icon: Icon(
              Icons.minimize,
              color: Colors.black54,
            ),
          ),
          ListItem(
            title: 'SnackBarDemo',
            page: SnackBarDemo(),
            icon: Icon(
              Icons.notifications,
              color: Colors.black54,
            ),
          ),
          ListItem(
            title: 'ExpansionPanelDemo',
            page: ExpansionPanelDemo(),
            icon: Icon(
              Icons.playlist_play,
              color: Colors.black54,
            ),
          ),
          ListItem(
            title: 'ChipDemo',
            page: ChipDemo(),
            icon: Icon(
              Icons.edit_attributes,
              color: Colors.black54,
            ),
          ),
          ListItem(
            title: 'DataTableDemo',
            page: DataTableDemo(),
            icon: Icon(
              Icons.table_chart,
              color: Colors.black54,
            ),
          ),
          ListItem(
            title: 'PaginatedDataTableDemo',
            page: PaginatedDataTableDemo(),
            icon: Icon(
              Icons.view_day,
              color: Colors.black54,
            ),
          ),
          ListItem(
            title: 'StepperDemo',
            page: StepperDemo(),
            icon: Icon(
              Icons.timeline,
              color: Colors.black54,
            ),
          ),
          ListItem(
            title: 'FormsDemo',
            page: FormsDemo(),
            icon: Icon(
              Icons.format_line_spacing,
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
