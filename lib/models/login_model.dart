class LoginModel {
  int code;
  Login data;
  String message;

  LoginModel({this.code, this.data, this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new Login.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Login {
  int id;
  String name;
  String password;
  String token;

  Login({this.id, this.name,this.password, this.token});

  Login.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    name = json['password'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['password'] = this.password;
    data['token'] = this.token;
    return data;
  }
}
