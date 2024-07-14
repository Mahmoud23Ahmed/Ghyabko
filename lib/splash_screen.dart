import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ghyabko/screens/login/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animationController.forward();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => login())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf7f7f7),
      body: Center(
        child: Container(
          height: 400, // Set a fixed height
          width: 300, // Set a fixed width
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: Tween<double>(begin: 0, end: 2).animate(
                  CurvedAnimation(
                      parent: _animationController, curve: Curves.easeOut),
                ),
                child: Image.asset(
                  'assets/GhyabkoLogo2.jpeg',
                  height: 150,
                ),
              ),
              const SizedBox(height: 80),
              ScaleTransition(
                scale: Tween<double>(begin: 0, end: 1).animate(
                  CurvedAnimation(
                      parent: _animationController, curve: Curves.linear),
                ),
                child: const Text(
                  "Attendance Management System",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6F35A5),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
