import 'package:flutter/material.dart';

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

class ButtonDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Widget _flatButton = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: < Widget > [
        FlatButton(
          child: Text('Button'),
          onPressed: () {},
          splashColor: Colors.grey[200],
        ),
        FlatButton.icon(
          icon: Icon(Icons.adb),
          label: Text('Button'),
          onPressed: () {},
          splashColor: Colors.grey[200],
        ),
      ],
    );

    final Widget _raiseButton = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: < Widget > [
        Theme(
          data: Theme.of(context).copyWith(
            buttonColor: Theme.of(context).primaryColor,
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
              // shape: BeveledRectangleBorder(
              //   borderRadius: BorderRadius.circular(6.0),
              // ),
              shape: StadiumBorder(),
            ),
          ),
          child: RaisedButton(
            child: Text('Button'),
            onPressed: () {},
            splashColor: Colors.grey[200],
            elevation: 0.0,
            // color: Colors.yellow,
          ),
        ),
        SizedBox(width: 18.0, ),
        RaisedButton.icon(
          icon: Icon(Icons.cake),
          label: Text('Button'),
          onPressed: () {},
          splashColor: Colors.grey[200],
          elevation: 6.0,
        ),
      ],
    );

    final Widget _outlineButton = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: < Widget > [
        Theme(
          data: Theme.of(context).copyWith(
            buttonColor: Theme.of(context).primaryColor,
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.normal,
              // shape: BeveledRectangleBorder(
              //   borderRadius: BorderRadius.circular(6.0),
              // ),
              shape: StadiumBorder(),
            ),
          ),
          child: OutlineButton(
            child: Text('Button'),
            onPressed: () {},
            splashColor: Colors.grey[200],
            borderSide: BorderSide(
              color: Colors.black,
            ),
            highlightedBorderColor: Colors.yellow[300],
            // color: Colors.yellow,
          ),
        ),
        SizedBox(width: 18.0, ),
        OutlineButton.icon(
          icon: Icon(Icons.beach_access),
          label: Text('Button'),
          onPressed: () {},
          splashColor: Colors.grey[200],
          borderSide: BorderSide(
            color: Colors.black,
          ),
          highlightedBorderColor: Colors.yellow[300],
        ),
      ],
    );

    final Widget _fixedOutlineButton = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: < Widget > [
        Container(
          width: 210.0,
          child: OutlineButton(
            child: Text('Button'),
            onPressed: () {},
            splashColor: Colors.grey[200],
            borderSide: BorderSide(
              color: Colors.black,
            ),
            highlightedBorderColor: Colors.yellow[300],
            // color: Colors.yellow,
          ),
        )
      ],
    );

    final Widget _expandedButton = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: < Widget > [
        Expanded(
          child: OutlineButton(
            child: Text('Button'),
            onPressed: () {},
            splashColor: Colors.grey[200],
            borderSide: BorderSide(
              color: Colors.black,
            ),
            highlightedBorderColor: Colors.yellow[300],
            // color: Colors.yellow,
          ),
        ),
        SizedBox(width: 8.0, ),
        Expanded(
          flex: 2,
          child: OutlineButton(
            child: Text('Button'),
            onPressed: () {},
            splashColor: Colors.grey[200],
            borderSide: BorderSide(
              color: Colors.black,
            ),
            highlightedBorderColor: Colors.yellow[300],
            // color: Colors.yellow,
          ),
        ),
      ],
    );

    final Widget _buttonBar = Theme(
      data: Theme.of(context).copyWith(
        buttonTheme: ButtonThemeData(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
        ),
      ),
      child: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: < Widget > [
          OutlineButton(
            child: Text('Button'),
            onPressed: () {},
            splashColor: Colors.grey[200],
            borderSide: BorderSide(
              color: Colors.black,
            ),
            highlightedBorderColor: Colors.yellow[300],
            // color: Colors.yellow,
          ),
          OutlineButton(
            child: Text('Button'),
            onPressed: () {},
            splashColor: Colors.grey[200],
            borderSide: BorderSide(
              color: Colors.black,
            ),
            highlightedBorderColor: Colors.yellow[300],
            // color: Colors.yellow,
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('ButtonDemo'),
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: < Widget > [
            _flatButton,
            _raiseButton,
            _outlineButton,
            _fixedOutlineButton,
            _expandedButton, 
            _buttonBar,
          ],
        ),
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

class FloatingActionButtonDemo extends StatelessWidget {
  final Widget _floatingActionButton = FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.add),
    elevation: 0.0,
    backgroundColor: Colors.black,
    // shape: BeveledRectangleBorder(
    //   borderRadius: BorderRadius.circular(30.0),
    // ),
  );

  final Widget _floatingActionButtonExtended = FloatingActionButton.extended(
    onPressed: () {},
    icon: Icon(Icons.add),
    label: Text('add'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FloatingActionButtonDemo'),
        elevation: 0.0,
      ),
      floatingActionButton: _floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 80.0,
        ),
        shape: CircularNotchedRectangle(),
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