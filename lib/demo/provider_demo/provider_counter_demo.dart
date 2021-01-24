import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_flutter/demo/model/counter_model.dart';
import 'counter_page.dart';

class ProviderCounterDemo extends StatelessWidget {
  const ProviderCounterDemo({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    print('first screen rebuild');

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Consumer(
              builder: (BuildContext context, ScopedReader wacth, _) {
                final int count = wacth(counterProvider).state;
                return Text(
                  '$count',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => CounterPage(),
          ),
        ),
        tooltip: 'Increment',
        child: Icon(
          Icons.arrow_forward,
          color: Colors.black,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
