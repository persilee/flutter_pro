import 'package:flutter/material.dart';
import 'package:smart_flare/actors/smart_flare_actor.dart';
import 'package:smart_flare/models.dart';

class FlareButtonDemo extends StatefulWidget {
  @override
  _FlareButtonDemoState createState() => _FlareButtonDemoState();
}

class _FlareButtonDemoState extends State<FlareButtonDemo> {
  @override
  Widget build(BuildContext context) {
    var animationWidth = 295.0;
    var animationHeight = 251.0;
    var animationWidthThirds = animationWidth / 3;
    var halfAnimationHeight = animationHeight / 2;

    var activeAreas = [

      ActiveArea(
        area: Rect.fromLTWH(0, 0, animationWidthThirds, halfAnimationHeight),
        debugArea: false,
        guardComingFrom: ['deactivate'],
        animationName: 'camera_tapped',
      ),

      ActiveArea(
          area: Rect.fromLTWH(animationWidthThirds, 0, animationWidthThirds, halfAnimationHeight),
          debugArea: false,
          guardComingFrom: ['deactivate'],
          animationName: 'pulse_tapped'),

      ActiveArea(
          area: Rect.fromLTWH(animationWidthThirds * 2, 0, animationWidthThirds, halfAnimationHeight),
          debugArea: false,
          guardComingFrom: ['deactivate'],
          animationName: 'image_tapped'),

      ActiveArea(
          area: Rect.fromLTWH(0, animationHeight / 2, animationWidth, animationHeight / 2),
          debugArea: false,
          animationsToCycle: ['activate', 'deactivate'],
          onAreaTapped: () {
            print('Button tapped!');
          })

    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Flare Button Demo'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0x3fffeb3b),
                Colors.orange,
              ]),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SmartFlareActor(
            width: animationWidth,
            height: animationHeight,
            filename: 'assets/button-animation.flr',
            startingAnimation: 'deactivate',
            activeAreas: activeAreas,
          ),
        ),
      ),
    );
  }
}
