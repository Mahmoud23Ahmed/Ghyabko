import 'package:flutter/material.dart';
import 'package:ghyabko/screens/login/componant/body.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: body(),
      ),
    );
  }
}
