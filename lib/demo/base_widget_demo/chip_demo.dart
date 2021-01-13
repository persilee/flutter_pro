import 'package:flutter/material.dart';

class ChipDemo extends StatefulWidget {
  @override
  _ChipDemoState createState() => _ChipDemoState();
}

class _ChipDemoState extends State<ChipDemo> {
  List<String> _tags = [
    'Apple',
    'Banana',
    'Lemon',
  ];
  String _action = 'Nothing';
  List<String> _selected = [];
  String _choice = 'Lemon';

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
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: <Widget>[
                Chip(
                  label: Text('Life'),
                ),
                Chip(
                  label: Text('Sunset'),
                  backgroundColor: Colors.yellow,
                ),
                Chip(
                  label: Text('persilee'),
                  avatar: CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Text(
                      '颖',
                      style: TextStyle(color: Colors.orangeAccent),
                    ),
                  ),
                ),
                Chip(
                  label: Text('persilee'),
                  avatar: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://cn.gravatar.com/avatar/ebf4749fb999f134566782c20e67a3ac?s=60&d=robohash&r=G'),
                  ),
                ),
                Chip(
                  label: Text('City'),
                  onDeleted: () {},
                  deleteIcon: Icon(
                    Icons.delete_forever,
                    size: 20.0,
                  ),
                  deleteButtonTooltipMessage: 'Remove this tag',
                ),
                Divider(),
                Wrap(
                  spacing: 8.0,
                  children: _tags
                      .map((tag) => Chip(
                            label: Text(tag),
                            onDeleted: () {
                              setState(() {
                                _tags.remove(tag);
                              });
                            },
                          ))
                      .toList(),
                ),
                Divider(),
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  child: Text('ActionChip: $_action'),
                ),
                Wrap(
                  spacing: 8.0,
                  children: _tags
                      .map((tag) => ActionChip(
                            label: Text(tag),
                            onPressed: () {
                              setState(() {
                                _action = tag;
                              });
                            },
                          ))
                      .toList(),
                ),
                Divider(),
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  child: Text('FilterChip: ${_selected.toString()}'),
                ),
                Wrap(
                  spacing: 8.0,
                  children: _tags
                      .map((tag) => FilterChip(
                            label: Text(tag),
                            selected: _selected.contains(tag),
                            onSelected: (value) {
                              setState(() {
                                _selected.contains(tag)
                                    ? _selected.remove(tag)
                                    : _selected.add(tag);
                              });
                            },
                          ))
                      .toList(),
                ),
                Divider(),
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  child: Text('ChoiceChip: $_choice'),
                ),
                Wrap(
                  spacing: 8.0,
                  children: _tags
                      .map((tag) => ChoiceChip(
                            label: Text(tag),
                            selectedColor: Colors.black54,
                            selected: _choice == tag,
                            onSelected: (value) {
                              setState(() {
                                _choice = tag;
                              });
                            },
                          ))
                      .toList(),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.reply,
          color: Colors.black,
        ),
        backgroundColor: Colors.yellow[500],
        onPressed: () {
          setState(() {
            _tags = [
              'Apple',
              'Banana',
              'Lemon',
            ];
            _selected = [];
            _choice = 'Lemon';
          });
        },
      ),
    );
  }
}
