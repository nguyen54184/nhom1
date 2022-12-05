import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileMenu extends StatefulWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press
  }) : super(key: key);

  final String text, icon;
  final VoidCallback? press;
  @override
  _ProfileMenuState createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.black,
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: null,
        ),
        onPressed: widget.press,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
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
                widget.icon,
                color: Colors.black,
                width: 22,
              ),
              SizedBox(width: 20),
              Expanded(
                  child: Text(
                    widget.text,
                    style: TextStyle(fontSize: 15,color:Colors.black ),
                  )),
              Icon(Icons.arrow_forward_ios,color: Colors.grey,),
            ],
          ),
        ),
      ),
    );
  }
}