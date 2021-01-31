import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pages/app.dart';

void main() {
  runApp(
    ProviderScope(
      child: App(),
    ),
  );
}


