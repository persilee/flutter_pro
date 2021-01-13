import 'package:flutter/material.dart';

class Hello extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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