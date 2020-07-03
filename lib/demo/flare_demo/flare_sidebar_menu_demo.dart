import 'package:flutter/material.dart';
import 'package:smart_flare/smart_flare.dart';

class FlareSidebarMenuDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    return Scaffold(
      body: Container(
        child: Align(
          alignment: Alignment.centerRight,
          child: PanFlareActor(
            width: MediaQuery.of(context).size.width / 2.366,
            height: MediaQuery.of(context).size.height,
            filename: 'assets/slideout-menu.flr',
            openAnimation: 'open',
            closeAnimation: 'close',
            direction: ActorAdvancingDirection.RightToLeft,
            threshold: 20.0,
            reverseOnRelease: true,
            completeOnThresholdReached: true,
            activeAreas: [
              RelativePanArea(
                  area: Rect.fromLTWH(0, .7, 1.0, .3), debugArea: false),
            ],
          ),
        ),
      ),
    );
  }
}
