import 'package:flutter/material.dart';

class LayoutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconBadge(Icons.monetization_on);
  }
}

class IconBadge extends StatelessWidget {
  final IconData icon;
  final double size;

  IconBadge(this.icon, {this.size = 32.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(icon, size: size, color: Colors.white,),
      width: size + 80,
      height: size + 80,
      color: Color.fromRGBO(36, 67, 189, 0.3),
    );
  }
}