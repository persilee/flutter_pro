import 'package:flutter/material.dart';

class LayoutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: < Widget > [
          Stack(
            alignment: Alignment(-1.0, -0.75),
            children: < Widget > [
              SizedBox(
                width: 300.0,
                height: 400.0,
                child: Container(
                  alignment: Alignment(-1.0, -1.0),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(48, 128, 196, 1.0),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
              ),
              SizedBox(height: 36.0, width: 36.0),
              SizedBox(
                width: 150.0,
                height: 150.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(48, 128, 196, 1.0),
                    // borderRadius: BorderRadius.circular(6.0),
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Color.fromRGBO(5, 165, 255, 0.6),
                        Color.fromRGBO(48, 128, 196, 0.8),
                      ]
                    )
                  ),
                  child: Icon(Icons.brightness_3, color: Colors.white, size: 36.0, ),
                ),
              ),
              Positioned(
                right: 30.0,
                top: 15.0,
                child: Icon(Icons.opacity, color: Colors.white, size: 10.0, ),
              ),
              Positioned(
                right: 50.0,
                top: 55.0,
                child: Icon(Icons.ac_unit, color: Colors.white, size: 16.0, ),
              ),
              Positioned(
                right: 20.0,
                top: 105.0,
                child: Icon(Icons.ac_unit, color: Colors.white, size: 16.0, ),
              ),
              Positioned(
                right: 90.0,
                top: 205.0,
                child: Icon(Icons.ac_unit, color: Colors.white, size: 14.0, ),
              ),
              Positioned(
                right: 70.0,
                top: 245.0,
                child: Icon(Icons.ac_unit, color: Colors.white, size: 12.0, ),
              ),
              Positioned(
                right: 85.0,
                top: 265.0,
                child: Icon(Icons.ac_unit, color: Colors.white, size: 16.0, ),
              ),
              Positioned(
                right: 40.0,
                top: 295.0,
                child: Icon(Icons.opacity, color: Colors.white, size: 12.0, ),
              ),
              Positioned(
                right: 30.0,
                top: 325.0,
                child: Icon(Icons.ac_unit, color: Colors.white, size: 14.0, ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class IconBadge extends StatelessWidget {
  final IconData icon;
  final double size;

  IconBadge(this.icon, {
    this.size = 32.0
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(icon, size: size, color: Colors.white, ),
      width: size + 80,
      height: size + 80,
      color: Color.fromRGBO(36, 67, 189, 0.3),
    );
  }
}