import 'package:ghyabko/main.dart';
import 'package:ghyabko/screens/auth/Login_Screen.dart';
import 'package:flutter/material.dart';

const constColor = Color(0xFF6469d9);

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    // String? email;
    // String? Password;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Positioned(
          bottom: mq.height * .15,
          left: mq.width * .05,
          width: mq.width * .9,
          height: mq.height * .06,
          child: Stack(children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset("assets/background.png", fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Image.asset("assets/light-1.png"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 165),
              child: Image.asset("assets/light-2.png"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 290, top: 100),
              child: Image.asset("assets/clock.png"),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 240),
              child: Row(
                children: [
                  Text('Registration',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mq.width * 0.05),
              child: Form(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: mq.width,
                        height: mq.height * 0.4,
                      ),
                      profileImg(),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Full Name',
                          hintStyle: TextStyle(
                            color: constColor,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: constColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(
                              color: constColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Academic Email',
                          hintStyle: TextStyle(
                            color: constColor,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: constColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(
                              color: constColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        obscureText: true,
                        onChanged: (data) {
                          // Password = data;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: constColor,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: constColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(
                              color: constColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: ((context) {
                            return LoginPage();
                          })));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: constColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Center(
                              child: Text('Sign Up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget profileImg() {
    return Center(
      child: Stack(children: <Widget>[
        const CircleAvatar(
          radius: 60.0,
          backgroundImage: AssetImage("assets/profileIcon.jpg"),
        ),
        Positioned(
          right: 10.0,
          bottom: 10.0,
          child: InkWell(
            onTap: () {},
            child: const Icon(
              Icons.camera_alt,
              color: constColor,
              size: 40.0,
            ),
          ),
        ),
      ]),
    );
  }
}
