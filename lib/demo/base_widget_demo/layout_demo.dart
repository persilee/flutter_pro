import 'package:flutter/material.dart';

class LayoutDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(48, 198, 196, 1.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: < Widget > [
          Stack(
            alignment: Alignment(-1.0, -0.75),
            children: < Widget > [
              SizedBox(
                width: 400.0,
                height: 450.0,
                child: Container(
                  alignment: Alignment(-1.0, -1.0),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(48, 198, 196, 1.0),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
              ),
              Positioned(
                left: 0.0,
                top: -6.0,
                child: SizedBox(
                  width: 160.0,
                  height: 190.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(48, 198, 196, 1.0),
                      // borderRadius: BorderRadius.circular(6.0),
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Color.fromRGBO(169, 205, 255, 0.6),
                          Color.fromRGBO(48, 198, 196, 0.8),
                        ]
                      )
                    ),
                    child: Icon(Icons.brightness_3, color: Colors.white, size: 46.0, ),
                  ),
                ),
              ),
              Positioned(
                right: 160.0,
                top: 15.0,
                child: Icon(Icons.opacity, color: Colors.white, size: 10.0, ),
              ),
              Positioned(
                right: 140.0,
                top: 55.0,
                child: Icon(Icons.ac_unit, color: Colors.white, size: 16.0, ),
              ),
              Positioned(
                right: 100.0,
                top: 105.0,
                child: Icon(Icons.ac_unit, color: Colors.white, size: 16.0, ),
              ),
              Positioned(
                right: 140.0,
                top: 135.0,
                child: Icon(Icons.ac_unit, color: Colors.white, size: 14.0, ),
              ),
              Positioned(
                right: 130.0,
                top: 205.0,
                child: Icon(Icons.ac_unit, color: Colors.white, size: 14.0, ),
              ),
              Positioned(
                right: 110.0,
                top: 245.0,
                child: Icon(Icons.ac_unit, color: Colors.white, size: 12.0, ),
              ),
              Positioned(
                right: 95.0,
                top: 265.0,
                child: Icon(Icons.ac_unit, color: Colors.white, size: 16.0, ),
              ),
              Positioned(
                right: 90.0,
                top: 295.0,
                child: Icon(Icons.opacity, color: Colors.white, size: 12.0, ),
              ),
              Positioned(
                right: 160.0,
                top: 325.0,
                child: Icon(Icons.ac_unit, color: Colors.white, size: 14.0, ),
              ),
              Positioned(
                right: 120.0,
                top: 345.0,
                child: Icon(Icons.ac_unit, color: Colors.white, size: 14.0, ),
              ),
              Positioned(
                right: 100.0,
                top: 365.0,
                child: Icon(Icons.ac_unit, color: Colors.white, size: 10.0, ),
              ),
              Positioned(
                right: 133.0,
                top: 392.0,
                child: Icon(Icons.ac_unit, color: Colors.white, size: 12.0, ),
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