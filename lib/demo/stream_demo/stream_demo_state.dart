class StreamDemoState{}

class InitializedState extends StreamDemoState {}

class DataFetchedState extends StreamDemoState {
  final List<String> data;

  DataFetchedState({this.data});

  bool get hasData => data.length > 0;
}

class ErrorState extends StreamDemoState{}

class BusyState extends StreamDemoState{}

