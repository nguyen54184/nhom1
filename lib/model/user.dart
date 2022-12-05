class User {
  String? id;
  String? fullName;
  String? username;
  String? password;
  User({this.id, this.fullName, this.username, this.password});

  // User({this.fullName, this.username, this.password});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
        id: json['_id'] as String?,
        fullName: json['fullName'] as String?,
        username: json['username'] as String?,
        password: json['password'] as String?,
    );
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = {
      'fullName': fullName,
      'username': username,
      'password': password,
    };
    return map;
  }
}