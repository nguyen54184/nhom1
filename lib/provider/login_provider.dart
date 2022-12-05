import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:kthp_moblie/model/login.dart';
import 'package:kthp_moblie/model/register.dart';
import 'package:kthp_moblie/model/user.dart';
import 'package:kthp_moblie/service/auth.dart';

class LoginProvider with ChangeNotifier{

  bool _isLoginSuccess = false;
  User? user = null;
  String message = "123456";

  bool getIsLogin(){
    return _isLoginSuccess;
  }

  Future login(Login userLogin) async{
    final dio = Dio(); // Provide a dio instance
    dio.options.headers["Demo-Header"] =
    "demo header"; // config your dio headers globally
    final client = RestLoginAuth(dio);
    await client
        .loginAuth(userLogin)
        .then((it)=>{
          user = it.user == null ? null : it.user,
          _isLoginSuccess = it.status!,
          message = it.message! as String
        });
    notifyListeners();
    return _isLoginSuccess;
  }

  Future register(Register userRegister) async{
    final dio = Dio(); // Provide a dio instance
    dio.options.headers["Demo-Header"] =
    "demo header"; // config your dio headers globally
    final client = RestLoginAuth(dio);
    await client
        .registerAuth(userRegister)
        .then((it)=>{
      user = it.user == null ? null : it.user,
      _isLoginSuccess = it.status!,
      message = it.message! as String
    });
    notifyListeners();
    return _isLoginSuccess;
  }

  void logout() {
    user = null;
    notifyListeners();
  }


//   final dio = Dio(); // Provide a dio instance
  //   dio.options.headers["Demo-Header"] =
  //   "demo header"; // config your dio headers globally
  //   final client = RestLoginAuth(dio);
  //   Login login = new Login(email: email, password: passWord);
  //   await client
  //       .loginAuth(login)
  //       .then((it)=>{
  //     user = it.user,
  //     _isLoginSuccess = it.status!,
  //   });
  //   notifyListeners();
  //   return _isLoginSuccess;
  // }
  //
  // void logout(){
  //   _isLoginSuccess = false;
  //   user = null;
  //   print("logout");
  //   notifyListeners();
  // }

}
