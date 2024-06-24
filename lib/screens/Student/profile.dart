// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ghyabko/main.dart';
import 'package:flutter/material.dart';

const constColor = Color(0xFF6469d9);

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => Profilescreen();
}

class Profilescreen extends State<Profile> {
  String _currentUserName = '';
  List<String> subjectList = [];
  String _currentUserEmail = '';
  late String StuEmail;

  getsubject() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      StuEmail = user.email!;
    }

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('Email', isEqualTo: StuEmail)
        .get();
    DocumentSnapshot userSnapshot = querySnapshot.docs.first;
    List<dynamic> subjects = userSnapshot.get('Subjects');
    subjectList = subjects.map((subject) => subject.toString()).toList();
  }

  Future<void> _getCurrentUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .get();

      var name = userDoc['Name'];
      var Email = userDoc['Email'];

      setState(() {
        _currentUserName = name;
        _currentUserEmail = Email;
      });
    } else {
      setState(() {
        _currentUserName = 'User not found';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentUserName();
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Stack(children: [
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/main_top.png",
                width: mq.width * 0.4,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/login_bottom.png",
                width: mq.width * 0.4,
              ),
            ),
            const Padding(
                padding: EdgeInsets.only(top: 70, left: 100),
                child: Text('Welcome',
                    style: TextStyle(
                      color: constColor,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ))),
            Padding(
                padding: EdgeInsets.only(top: 200, left: 100),
                child: Image(
                    image: AssetImage('assets/logo3.png'),
                    height: 200,
                    fit: BoxFit.fill)),
            Padding(
              padding: const EdgeInsets.only(top: 400),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Text("Name : $_currentUserName",
                        style: TextStyle(
                          color: constColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Email : $_currentUserEmail',
                        style: TextStyle(
                          color: constColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(
                      height: 230,
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
