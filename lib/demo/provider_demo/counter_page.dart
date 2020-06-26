import 'package:flutter/material.dart';
import 'package:pro_flutter/model/counter_model.dart';
import 'package:provider/provider.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('second screen rebuild');

    return Scaffold(
      appBar: AppBar(
        title: Text('Counter Page'),
      ),
      body: Consumer<CounterModel>(
        builder: (context, CounterModel counter, child) => Center(
          child: Text(
            '${counter.value}',
            style: TextStyle(fontSize: 26.0),
          ),
        ),
      ),
      floatingActionButton: Consumer<CounterModel>(
        builder: (context, CounterModel counter, child) => FloatingActionButton(
          onPressed: counter.increment,
          child: child,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        child: Icon(Icons.add,color: Colors.black,),
      ),
    );
  }
}
