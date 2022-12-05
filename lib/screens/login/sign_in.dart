import 'package:flutter/material.dart';
import 'package:kthp_moblie/provider/login_provider.dart';
import 'package:kthp_moblie/screens/login/forgot_password.dart';
import 'package:kthp_moblie/screens/login/sign_up.dart';
import 'package:kthp_moblie/screens/login/social_icon.dart';
import 'package:kthp_moblie/screens/pages/home.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import '../../service/auth.dart';
import '../../model/login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {



  // form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  final navigatorHome = (BuildContext context){
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyHome()),
    );
  };

  show(String text){
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('login'),
        content: Text('${text}'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void  login() async {
    print("submit login");
    if(emailController.text.isEmpty || passwordController.text.isEmpty){
      show("Vui lòng điền thông tin login");
      return;
    }


    Login userLogin = new Login(username: emailController.text, password: passwordController.text);
    await context.read<LoginProvider>().login(userLogin).then((value) => {
      if(value){
        // show("Login successfully!!!"),
        navigatorHome(context)
      }else{
        show("Login failed!!!")
      }
    });

    // final dio = Dio(); // Provide a dio instance
    // dio.options.headers["Demo-Header"] =
    // "demo header"; // config your dio headers globally
    // final client = RestLoginAuth(dio);
    // client
    //     .loginAuth(userLogin)
    //     .then((it) => {
    //   print(it.user?.fullName),
    //   (it.status == true ? navigatorHome(context):
    //   showDialog<String>(
    //     context: context,
    //     builder: (BuildContext context) => AlertDialog(
    //       title: const Text('Login'),
    //       content: Text('${it.message}'),
    //       actions: <Widget>[
    //         TextButton(
    //           onPressed: () => Navigator.pop(context, 'OK'),
    //           child: const Text('OK'),
    //         ),
    //       ],
    //     ),
    //   )),
    // })
    //     .catchError((err) => {
    //   showDialog<String>(
    //     context: context,
    //     builder: (BuildContext context) => AlertDialog(
    //       title: const Text('Login'),
    //       content: Text('Login Failed'),
    //       actions: <Widget>[
    //         TextButton(
    //           onPressed: () => Navigator.pop(context, 'OK'),
    //           child: const Text('OK'),
    //         ),
    //       ],
    //     ),
    //   ),
    // });

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    //email field
    final userNameField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Vui Lòng Nhập User name");
          }

          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "User Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: true,
        validator: (value) {
          RegExp regex = RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Mật Khẩu bắt buộc để đăng nhập");
          }
          if (!regex.hasMatch(value)) {
            return ("Nhập mật khẩu hợp lệ(Tối thiểu 6 kí tự)");
          }
          return null;
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Mật Khẩu",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.lightGreen,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery
              .of(context)
              .size
              .width,
          onPressed: () async {
            if (_formKey.currentState!.validate()){
              login();
            }else{
              show("Login Failed!!!");
            }

          },
          child: const Text(
            "Đăng nhập",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 200,
                        child: Image.asset(
                          "assets/icons/logo.png",
                          fit: BoxFit.contain,
                        )),
                    const SizedBox(height: 45),
                    userNameField,
                    const SizedBox(height: 25),
                    passwordField,
                    const SizedBox(height: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPassword()));
                            },
                            child: const Text(
                              "Quên mật khẩu?",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          )
                        ]),
                    const SizedBox(height: 10),
                    loginButton,
                    const SizedBox(height: 15),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text("Bạn chưa có tài khoản? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegistrationScreen()));
                            },
                            child: const Text(
                              "Đăng kí",
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          )
                        ]),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SocalIcon(
                          iconSrc: "assets/icons/facebook.svg",
                          press: () {},
                        ),
                        SocalIcon(
                          iconSrc: "assets/icons/twitter.svg",
                          press: () {},
                        ),
                        SocalIcon(
                          iconSrc: "assets/icons/google-plus.svg",
                          press: () {

                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
