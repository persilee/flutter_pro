import 'dart:async';
import 'package:pro_flutter/demo/stream_demo/stream_demo_event.dart';
import 'package:pro_flutter/demo/stream_demo/stream_demo_state.dart';


enum StreamViewState { Busy, DataRetrieved, NoData }

class StreamDemoModel {
  final StreamController<StreamDemoState> _stateController = StreamController<StreamDemoState>();

  List<String> _listItems;

  Stream<StreamDemoState> get streamState => _stateController.stream;

  void dispatch(StreamDemoEvent event){
    print('Event dispatched: $event');
    if(event is FetchData) {
      _getListData(hasData: event.hasData, hasError: event.hasError);
    }
  }

  Future _getListData({bool hasError = false, bool hasData = true}) async {
    _stateController.add(BusyState());
    await Future.delayed(Duration(seconds: 2));

    if (hasError) {
      return _stateController.addError('error');
    }

    if (!hasData) {
      return _stateController.add(DataFetchedState(data: List<String>()));
    }

    _listItems = List<String>.generate(10, (index) => '$index content');
    _stateController.add(DataFetchedState(data: _listItems));
  }
}
