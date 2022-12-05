import 'package:flutter/material.dart';
import 'package:kthp_moblie/model/register.dart';
import 'package:kthp_moblie/provider/login_provider.dart';
import 'package:kthp_moblie/screens/pages/home.dart';
import 'package:kthp_moblie/service/auth.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // string for displaying the error Message
  String? errorMessage;
  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final firstNameEditingController = TextEditingController();
  // final secondNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //first name field
    final fullName = TextFormField(
        autofocus: false,
        controller: firstNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Tên không được bỏ trống!");
          }
          if (!regex.hasMatch(value)) {
            return ("Nhập tên hợp lệ(Tối thiểu 3 kí tự)!");
          }
          return null;
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Full Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //email field
    final userNameField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Vui lòng nhập username của bạn!");
          }
          return null;
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
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
        controller: passwordEditingController,
        obscureText: true,
        validator: (value) {
          RegExp regex = RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Mật khẩu bắt buộc để đăng nhập");
          }
          if (!regex.hasMatch(value)) {
            return ("Nhập mật khẩu hợp lệ(Tối thiểu 6 kí tự)");
          }
          return null;
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Mật Khẩu",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //confirm password field
    final confirmPasswordField = TextFormField(
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: true,
        validator: (value) {
          if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return "Mật khẩu không khớp!";
          }
          return null;
        },
        onSaved: (value) {
          confirmPasswordEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Xác Nhận Mật Khẩu",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final navigatorHome = (){
      return Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyHome()),
      );
    };

    show(String text){
      return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Register'),
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

    void submitRegister() async {
      if(firstNameEditingController.text.isEmpty || emailEditingController.text.isEmpty || passwordEditingController.text.isEmpty || confirmPasswordEditingController.text.isEmpty){
        show("Vui lòng nhập thông tin đăng ký");
        return;
      }

      if(passwordEditingController.text != confirmPasswordEditingController.text){
        show("Vui lòng nhập đúng password");
        return;
      }

      String fullName = firstNameEditingController.text;
      String username = emailEditingController.text;
      String password = passwordEditingController.text;

      Register userRegister = new Register(fullName: fullName,username: username, password: password);


      await context.read<LoginProvider>().register(userRegister).then((value) => {
        if(value){
          // show("Register successfully!!!"),
          navigatorHome()
        }else{
          show("Register failed!!!")
        }
      });

      // final dio = Dio(); // Provide a dio instance
      // dio.options.headers["Demo-Header"] =
      // "demo header"; // config your dio headers globally
      // final client = RestLoginAuth(dio);
      //
      // client
      //     .registerAuth(userRegister)
      //     .then((it) => {
      //   print(it.user?.fullName),
      //   (it.status == true ? navigatorHome(context):
      //   show(it.message as String)
      //   ),
      // })
      //     .catchError((err) => {
      //   showDialog<String>(
      //     context: context,
      //     builder: (BuildContext context) => AlertDialog(
      //       title: const Text('Register'),
      //       content: Text('Register Failed'),
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


    //signup button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.lightGreen,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            if (_formKey.currentState!.validate()){
              submitRegister();
            }else{
              show("Register Failed!!!");
            }
          },
          child: const Text(
            "Đăng Kí",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
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
                        height: 180,
                        child: Image.asset(
                          "assets/icons/logo.png",
                          fit: BoxFit.contain,
                        )),

                    const SizedBox(height: 45),
                    fullName,
                    const SizedBox(height: 20),
                    userNameField,
                    const SizedBox(height: 20),
                    passwordField,
                    const SizedBox(height: 20),
                    confirmPasswordField,
                    const SizedBox(height: 20),
                    signUpButton,
                    const SizedBox(height: 15),
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