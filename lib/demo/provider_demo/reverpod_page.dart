import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

final helloRiverpod = Provider((ref) => 'Hello Riverpod');

class HttpClient {
  Future<String> get(String url) async {
    await Future.delayed(Duration(seconds: 1));
    return 'Respones from $url';
  }
}

final httpProvider = Provider((ref) => HttpClient());
final responseProvider =
    FutureProvider.autoDispose.family<String, String>((ref, url) async {
  return ref.read(httpProvider).get(url);
});

class ReverPodPage extends ConsumerWidget {
  const ReverPodPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader wacth) {
    final hello = wacth(helloRiverpod);
    var respones = wacth(responseProvider('https://lishaoy.net'));
    return Scaffold(
      appBar: AppBar(
        title: Text(hello),
      ),
      body: Center(
        child: Builder(
          builder: (context) {
            return respones.map(
              data: (_) => Text(_.value),
              loading: (_) => CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                backgroundColor: Colors.yellow[100],
              ),
              error: (_) => Text(_.error.toString()),
            );
          },
        ),
      ),
    );
  }
}
