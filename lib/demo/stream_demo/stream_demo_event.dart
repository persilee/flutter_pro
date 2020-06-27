class StreamDemoEvent{}

class FetchData extends StreamDemoEvent{
  final bool hasError;
  final bool hasData;

  FetchData({this.hasError = false, this.hasData = true});

  @override
  String toString() {
    return 'FetchData { hasError: $hasError, hasData: $hasData }';
  }
}