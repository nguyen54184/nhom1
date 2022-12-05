class Register {
  String? fullName;
  String? username;
  String? password;

  Register({this.fullName,this.username, this.password});

  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = {
      'fullName': fullName,
      'username': username,
      'password': password,
    };
    return map;
  }

}