import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

final helloRiverpod = Provider((ref) => 'hello riverpod');

class ReverPodPage extends ConsumerWidget {
  const ReverPodPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext contex, ScopedReader wacth) {
    final hello = wacth(helloRiverpod);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Riverpod Page'),
        ),
      ),
      body: Text(hello),
    );
  }
}
