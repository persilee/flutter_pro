import 'package:flutter/material.dart';
import 'package:pro_flutter/demo/stream_demo/stream_demo_event.dart';
import 'package:pro_flutter/demo/stream_demo/stream_demo_model.dart';
import 'package:pro_flutter/demo/stream_demo/stream_demo_state.dart';

class StreamBuilderDemo extends StatefulWidget {
  @override
  _StreamBuilderDemoState createState() => _StreamBuilderDemoState();
}

class _StreamBuilderDemoState extends State<StreamBuilderDemo> {
  final model = StreamDemoModel();

  @override
  void initState() {
    model.dispatch(FetchData(hasData: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stream Builder Demo'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        child: Icon(
          Icons.cached,
          color: Colors.black87,
        ),
        onPressed: () {
          model.dispatch(FetchData());
        },
      ),
      body: StreamBuilder(
        stream: model.streamState,
        builder: (buildContext, snapshot) {
          if (snapshot.hasError) {
            return _getInformationMessage(snapshot.error);
          }

          var streamState = snapshot.data;

          if (!snapshot.hasData || streamState is BusyState) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                backgroundColor: Colors.yellow[100],
              ),
            );
          }

          if (streamState is DataFetchedState) {
            if (!streamState.hasData) {
              return _getInformationMessage('not found data');
            }
          }
          return ListView.builder(
            itemCount: streamState.data.length,
            itemBuilder: (buildContext, index) =>
                _getListItem(index, streamState.data),
          );
        },
      ),
    );
  }

  Widget _getListItem(int index, List<String> listItems) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(listItems[index]),
        ),
        Divider(),
      ],
    );
  }

  Widget _getInformationMessage(String message) {
    return Center(
      child: Text(
        message,
        style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w900,
            color: Colors.grey[500]),
        textAlign: TextAlign.center,
      ),
    );
  }
}
