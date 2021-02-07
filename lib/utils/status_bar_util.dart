import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatusBarUtil {
  static void setStatusBar(Brightness brightness) {
    SystemUiOverlayStyle style = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: brightness,
    );
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}