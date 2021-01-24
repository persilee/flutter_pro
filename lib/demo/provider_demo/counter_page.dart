import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_flutter/demo/model/counter_model.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('second screen rebuild');

    return Scaffold(
      appBar: AppBar(
        title: Text('Counter Page'),
      ),
      body: Consumer(builder: (context, wacth, _) {
        final count = wacth(counterProvider).state;
        return Center(
          child: Text(
            '$count',
            style: TextStyle(fontSize: 26.0),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read(counterProvider).state++,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
