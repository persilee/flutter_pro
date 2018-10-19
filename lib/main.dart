import 'package:flutter/material.dart';

void main() {
  runApp(
    App()
  );
}

class App extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Lishaoy.net'),
            elevation: 6.0,
          ),
          body: Hello(),
        ),
        theme: ThemeData(
          primaryColor: Colors.yellow
        ),
      );
    }
}

class Hello extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Center(
        child: Text(
          'holle',
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
            color: Colors.black87,
          ),
        ),
      );
    }
}