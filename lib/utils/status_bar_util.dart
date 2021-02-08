import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatusBarUtil {
  static void setStatusBar(Brightness brightness, {Color color = Colors.transparent}) {
    SystemUiOverlayStyle style = SystemUiOverlayStyle(
      statusBarColor: color,
      statusBarIconBrightness: brightness,
    );
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}