/// code : 200
/// data : [{"name":"摄影"},{"name":"设计"},{"name":"动漫"},{"name":"影视"},{"name":"插画"},{"name":"服装"},{"name":"其他"}]
/// message : "success"

class CategoryModel {
  int _code;
  List<Category> _data;
  String _message;

  int get code => _code;
  List<Category> get data => _data;
  String get message => _message;

  CategoryModel({
      int code, 
      List<Category> data, 
      String message}){
    _code = code;
    _data = data;
    _message = message;
}

  CategoryModel.fromJson(dynamic json) {
    _code = json["code"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Category.fromJson(v));
      });
    }
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["code"] = _code;
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    map["message"] = _message;
    return map;
  }

}

/// name : "摄影"

class Category {
  String _name;

  String get name => _name;

  Category({
      String name}){
    _name = name;
}

  Category.fromJson(dynamic json) {
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    return map;
  }

}