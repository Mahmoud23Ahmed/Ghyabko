import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ghyabko/api/user_api.dart';
import 'package:ghyabko/main.dart';
import 'package:ghyabko/screens/Admin/Home.dart';
import 'package:ghyabko/screens/Doctor/subject_page.dart';
import 'package:ghyabko/screens/Student/your_subject.dart';
import 'package:ghyabko/screens/auth/OTP_Verfication.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final formKey = GlobalKey<FormState>();
const constColor = Color(0xFF6469d9);
final firestoreInstance = FirebaseFirestore.instance;
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final PasswordController = TextEditingController();

  final user_data = Get.put(userapi());
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
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
                padding: EdgeInsets.only(top: 210, left: 155),
                child: Text('Login',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ))),
            Padding(
              padding: const EdgeInsets.only(top: 330, left: 20, right: 20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 35,
                    ),
                    TextFormField(
                      controller: emailController,
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
                      height: 25,
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: PasswordController,
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
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        loginUserAndNavigate(
                          email: emailController.text,
                          password: PasswordController.text,
                        );
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
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: ((context) {
                        return const OTPscreen();
                      }))),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 100, right: 30),
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
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
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

      // Retrieve user data from Firestore to check user type
      DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
          .instance
          .collection('Users')
          .doc(userCredential.user!.uid)
          .get();

      if (userData.exists) {
        String userType = userData['Type'];

        // Navigate user based on type
        if (userType == 'Admin') {
          Navigator.push(context, MaterialPageRoute(builder: ((context) {
            return const Home();
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
