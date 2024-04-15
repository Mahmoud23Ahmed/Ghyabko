import 'package:ghyabko/screens/auth/Login_Screen.dart';
import 'package:flutter/material.dart';

Widget clipRRect(Icon icon, Text text, context, Widget widget) {
  return SizedBox.fromSize(
    size: Size(150, 150),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Material(
        color: constColor,
        child: InkWell(
          splashColor: Color.fromARGB(255, 6, 25, 244),
          onTap: () =>
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return widget;
          })),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              icon,
              text,
            ],
          ),
        ),
      ),
    ),
  );
}
