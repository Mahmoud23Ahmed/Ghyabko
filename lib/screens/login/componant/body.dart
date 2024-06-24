import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ghyabko/api/user_api.dart';
import 'package:ghyabko/screens/Admin/Home.dart';
import 'package:ghyabko/screens/Doctor/subject_page.dart';
import 'package:ghyabko/screens/Student/your_subject.dart';
import 'package:ghyabko/screens/adminweb/home.dart';
import 'package:ghyabko/screens/adminweb/hometaplet.dart';
import 'package:ghyabko/screens/auth/OTP_Verfication.dart';
import 'package:ghyabko/screens/login/componant/background.dart';
import 'package:responsive_builder/responsive_builder.dart';

class body extends StatefulWidget {
  const body({super.key});

  @override
  State<body> createState() => _bodyState();
}

final formKey = GlobalKey<FormState>();
final firestoreInstance = FirebaseFirestore.instance;
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class _bodyState extends State<body> {
  final emailController = TextEditingController();
  final PasswordController = TextEditingController();
  final user_data = Get.put(userapi());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Text(
            'LOGIN',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Color(0xFF6F35A5)),
          ),
          SizedBox(
            height: 50,
          ),
          SvgPicture.asset(
            'assets/login.svg',
            height: size.height * 0.35,
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Academic Email',
                hintStyle: TextStyle(
                  color: Color(0xFF6F35A5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF6F35A5),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(
                    color: Color(0xFF6F35A5),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: TextFormField(
              obscureText: true,
              controller: PasswordController,
              decoration: const InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(
                  color: Color(0xFF6F35A5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF6F35A5),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(
                    color: Color(0xFF6F35A5),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          GestureDetector(
            onTap: () {
              loginUserAndNavigate(
                email: emailController.text,
                password: PasswordController.text,
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Color(0xFF6F35A5),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Center(
                  child: Text('Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () =>
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
              return const OTPscreen();
            }))),
            child: const Padding(
              padding: EdgeInsets.only(left: 110, right: 30),
              child: Row(
                children: [
                  Text(
                    'Forget Password ?',
                    style: TextStyle(
                      color: constColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  Future<void> loginUserAndNavigate({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Retrieve user data from Firestore using the correct UID
      DocumentSnapshot<Map<String, dynamic>> userData =
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(userCredential.user!.uid) // Use correct UID here
              .get();

      if (userData.exists) {
        String userType = userData['Type'];

        // Navigate user based on type
        if (userType == 'Admin') {
          Navigator.push(context, MaterialPageRoute(builder: ((context) {
            return ScreenTypeLayout.builder(
              mobile: (BuildContext context) => Home(),
              tablet: (BuildContext context) => HomeViewtab(),
              desktop: (BuildContext context) => HomeView(),
            );
          })));
        } else if (userType == 'Doctor') {
          Navigator.push(context, MaterialPageRoute(builder: ((context) {
            return SubjectName();
          })));
        } else if (userType == 'Student') {
          Navigator.push(context, MaterialPageRoute(builder: ((context) {
            return YourSubject();
          })));
        } else {
          // Handle unknown user type
          print('Unknown user type');
        }
      } else {
        // User document doesn't exist, handle appropriately
        print('User data not found');
      }
    } catch (e) {
      print("Error logging in: $e");
      // Handle error
    }
  }
}
