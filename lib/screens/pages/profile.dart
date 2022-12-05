import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kthp_moblie/constants/constants.dart';
import 'package:kthp_moblie/constants/size_config.dart';
import 'package:kthp_moblie/provider/buyer_provider.dart';
import 'package:kthp_moblie/provider/cart_provider.dart';
import 'package:kthp_moblie/provider/home_provider.dart';
import 'package:kthp_moblie/provider/login_provider.dart';
import 'package:kthp_moblie/screens/login/sign_in.dart';
import 'package:kthp_moblie/screens/profile_screen/profile_menu.dart';
import 'package:kthp_moblie/screens/profile_screen/profile_screen.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    final buyerProvider = Provider.of<BuyerProvider>(context, listen: false);
    final authProvider = Provider.of<LoginProvider>(context, listen: false);
    final navigatorLogin = (BuildContext context){
      return Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    };

    void logout(){
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      authProvider.logout();
      cartProvider.removeAll();
      navigatorLogin(context);
    }

    bool statuslight = true;

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30,),
              // const ProfilePic(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(19, 0, 19, 0),
                    child: Container(
                        height: 110,
                        width: size.width * 0.9,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: const Offset(
                                      0, 1), // changes position of shadow
                                )
                              ]),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 35,
                                left: 30,
                                child: Transform.scale(
                                  scale: 1.7,
                                  child: const CircleAvatar(
                                    backgroundImage:
                                    AssetImage('assets/images/image-01.png'),
                                  ),
                                ),
                              ),
                              Positioned(
                                  left: 100,
                                  top: 30,
                                  child: Text('${context.watch<LoginProvider>().user?.fullName}',style: const TextStyle(
                                      fontSize: 25, fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),)),
                              const Positioned(
                                  left: 100,
                                  bottom: 30,
                                  child: Text("Custommer",style: TextStyle(
                                      fontSize: 17,color: Colors.white
                                  ),)),

                              Positioned(
                                right: 20,
                                top: 40,
                                child: Container(
                                    width: 110,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2.0,
                                      ),
                                    ),
                                    child:
                                    const Center(
                                      child: Text(
                                        "EDIT PROFILE",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    )
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: null,
                    padding:  const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  ),
                  onPressed: null,
                  child: Container(
                    height: 60,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide( //                   <--- left side
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/1.png",
                          color: Colors.black,
                          width: 22,
                        ),
                        const SizedBox(width: 20),
                        const Expanded(
                            child: Text("Notifications",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ))),
                        SizedBox(
                          width: 40,
                          height: 26,
                          child: Switch(
                            activeColor: Colors.green,
                            value: statuslight,
                            onChanged: (bool val) async {
                              setState(() {
                                statuslight = !statuslight;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              ProfileMenu(
                text: "Languages",
                icon: "assets/icons/2.png",
                press: () => {},
              ),
              ProfileMenu(
                text: "Payment",
                icon: "assets/icons/3.png",
                press: () {},
              ),
              ProfileMenu(
                text: "Privacy & Policy",
                icon: "assets/icons/4.png",
                press: () {},
              ),
              ProfileMenu(
                text: "Feedback",
                icon: "assets/icons/5.png",
                press: () {},
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: null,
                    padding:  const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  ),
                  onPressed: null,
                  child: InkWell(
                    child: Container(
                      height: 60,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide( //                   <--- left side
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child:  Row(
                        children: [
                          Image.asset(
                            "assets/icons/close.png",
                            color: Colors.black,
                            width: 22,
                          ),
                          const SizedBox(width: 20),
                          const Expanded(
                              child: Text("Sign out",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                  ))),
                          const Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                        ],
                      ),

                    ),
                    onTap: ()=>{
                      logout()
                    },
                  ),
                ),
              ),
            ],
          )),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


