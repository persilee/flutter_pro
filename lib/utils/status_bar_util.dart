import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatusBarUtil {
  static void setStatusBar(Brightness brightness,
      {Color color = Colors.transparent}) {
    SystemUiOverlayStyle style = SystemUiOverlayStyle(
      statusBarColor: color,
      statusBarIconBrightness: brightness,
    );
    SystemChrome.setSystemUIOverlayStyle(style);
  }

  static void hideTopBar() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  }

  static void hideBottomBar() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  }

  static void hideStatusBar() {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  static void showStatusBar() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top,SystemUiOverlay.bottom]);
  }
}
