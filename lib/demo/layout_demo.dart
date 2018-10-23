import 'package:flutter/material.dart';

class LayoutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 300.0,
            height: 400.0,
            child: Container(
              alignment: Alignment(-1.0, -1.0),
              decoration: BoxDecoration(
                color: Color.fromRGBO(48, 128, 196, 0.6),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Icon(Icons.opacity, color: Colors.white, size: 36.0,),
            ),
          ),
          SizedBox(height: 36.0, width: 36.0),
          SizedBox(
            width: 200.0,
            height: 200.0,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(48, 128, 196, 0.6),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Icon(Icons.ac_unit, color: Colors.white, size: 36.0,),
            ),
          ),
        ],
      ),
    );
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