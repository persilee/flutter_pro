
/// code : 201
/// data : {"fieldCount":0,"affectedRows":1,"insertId":0,"info":"","serverStatus":2,"warningStatus":0}
/// message : "success"

class BaseModel{
  int _code;
  Data _data;
  String _message;

  int get code => _code;
  Data get data => _data;
  String get message => _message;

  BaseModel({
      int code, 
      Data data, 
      String message}){
    _code = code;
    _data = data;
    _message = message;
}

  BaseModel.fromJson(dynamic json) {
    _code = json["code"];
    _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["code"] = _code;
    if (_data != null) {
      map["data"] = _data.toJson();
    }
    map["message"] = _message;
    return map;
  }

}

/// fieldCount : 0
/// affectedRows : 1
/// insertId : 0
/// info : ""
/// serverStatus : 2
/// warningStatus : 0

class Data {
  int _fieldCount;
  int _affectedRows;
  int _insertId;
  String _info;
  int _serverStatus;
  int _warningStatus;

  int get fieldCount => _fieldCount;
  int get affectedRows => _affectedRows;
  int get insertId => _insertId;
  String get info => _info;
  int get serverStatus => _serverStatus;
  int get warningStatus => _warningStatus;

  Data({
      int fieldCount, 
      int affectedRows, 
      int insertId, 
      String info, 
      int serverStatus, 
      int warningStatus}){
    _fieldCount = fieldCount;
    _affectedRows = affectedRows;
    _insertId = insertId;
    _info = info;
    _serverStatus = serverStatus;
    _warningStatus = warningStatus;
}

  Data.fromJson(dynamic json) {
    _fieldCount = json["fieldCount"];
    _affectedRows = json["affectedRows"];
    _insertId = json["insertId"];
    _info = json["info"];
    _serverStatus = json["serverStatus"];
    _warningStatus = json["warningStatus"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["fieldCount"] = _fieldCount;
    map["affectedRows"] = _affectedRows;
    map["insertId"] = _insertId;
    map["info"] = _info;
    map["serverStatus"] = _serverStatus;
    map["warningStatus"] = _warningStatus;
    return map;
  }

}