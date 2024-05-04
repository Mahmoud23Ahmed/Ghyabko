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
        body: Positioned(
          bottom: mq.height * .15,
          left: mq.width * .05,
          width: mq.width * .9,
          height: mq.height * .06,
          child: Stack(children: [
            SizedBox(
              width: mq.width,
              child: Image.asset("assets/bg2.jpg", fit: BoxFit.cover),
            ),
            const Padding(
                padding: EdgeInsets.only(top: 100, left: 80),
                child: Text('Welcome',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ))),
            const Padding(
                padding: EdgeInsets.only(top: 500, left: 100),
                child: Image(
                    image: AssetImage('assets/logo2.jpg'),
                    height: 200,
                    fit: BoxFit.fill)),
            Padding(
              padding: const EdgeInsets.only(top: 250, left: 20, right: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Name : $_currentUserName",
                      style: TextStyle(
                        color: constColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Email : $_currentUserEmail',
                      style: TextStyle(
                        color: constColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
