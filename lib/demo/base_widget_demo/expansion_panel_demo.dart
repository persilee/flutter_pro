import 'package:flutter/material.dart';

class ExpansionPanelItem {
  final String heartText;
  final Widget body;
  bool isExpanded;

  ExpansionPanelItem({
    this.heartText,
    this.body,
    this.isExpanded,
  });
}

class ExpansionPanelDemo extends StatefulWidget {
  @override
  _ExpansionPanelDemoState createState() => _ExpansionPanelDemoState();
}

class _ExpansionPanelDemoState extends State<ExpansionPanelDemo> {
  List<ExpansionPanelItem> _expansionPanelItem;

  @override
  void initState() {
    super.initState();

    _expansionPanelItem = <ExpansionPanelItem>[
      ExpansionPanelItem(
        heartText: 'Panel A',
        body: Container(
          padding: EdgeInsets.all(16.0),
          width: double.infinity,
          child: Text('Content for Panel A'),
        ),
        isExpanded: false,
      ),
      ExpansionPanelItem(
        heartText: 'Panel B',
        body: Container(
          padding: EdgeInsets.all(16.0),
          width: double.infinity,
          child: Text('Content for Panel B'),
        ),
        isExpanded: false,
      ),
      ExpansionPanelItem(
        heartText: 'Panel C',
        body: Container(
          padding: EdgeInsets.all(16.0),
          width: double.infinity,
          child: Text('Content for Panel C'),
        ),
        isExpanded: false,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ExpansionPanelDemo'),
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ExpansionPanelList(
              expansionCallback: (int panelIndex, bool isExpanded) =>
                  setState(() {
                    _expansionPanelItem[panelIndex].isExpanded = !isExpanded;
                  }),
              children: _expansionPanelItem.map((ExpansionPanelItem item) {
                return ExpansionPanel(
                  body: item.body,
                  isExpanded: item.isExpanded,
                  headerBuilder: (BuildContext context, bool isExpanded) =>
                      Container(
                        padding: EdgeInsets.all(16.0),
                        child: Text(item.heartText, style: Theme.of(context).textTheme.headline6),
                      ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
