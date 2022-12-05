class Login {
  String? username;
  String? password;

  Login({this.username, this.password});

  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = {
      'username': username,
      'password': password,
    };
    return map;
  }

}