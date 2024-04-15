import 'package:ghyabko/helper/Student_helper/subjectcalss.dart';
import 'package:ghyabko/screens/Student/add_subject.dart';
import 'package:ghyabko/screens/Student/notification_Screen.dart';
import 'package:ghyabko/screens/Student/profile.dart';
import 'package:ghyabko/screens/auth/Login_Screen.dart';
import 'package:flutter/material.dart';
import '../../helper/Student_helper/subWidgetsForSubject.dart';

const constColor = Color(0xFF6469d9);

// ignore: must_be_immutable
class YourSubject extends StatelessWidget {
  YourSubject({super.key});
  List<Subject> subjects = [
    Subject(text: 'Math-3'),
    Subject(text: 'Algorithm'),
    Subject(text: 'Embedded System'),
    Subject(text: 'Operatin System-1'),
    Subject(text: 'Parallel Programming'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: constColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.addchart_sharp,
              color: constColor,
            ),
            label: ("Add Subject"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications_active_outlined,
              color: constColor,
            ),
            label: ("Notification"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.subject_outlined,
              color: constColor,
            ),
            label: ("Your Subject"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: constColor,
            ),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.logout,
              color: constColor,
            ),
            label: "Logout",
          ),
        ],
        onTap: (value) {
          if (value == 0) {
            Navigator.push(context, MaterialPageRoute(builder: ((context) {
              return Addsubject();
            })));
          }
          if (value == 1) {
            Navigator.push(context, MaterialPageRoute(builder: ((context) {
              return NotificatePage();
            })));
          }
          if (value == 2) {
            Navigator.push(context, MaterialPageRoute(builder: ((context) {
              return YourSubject();
            })));
          }
          if (value == 3) {
            Navigator.push(context, MaterialPageRoute(builder: ((context) {
              return const StudentPage();
            })));
          }
          if (value == 4) {
            Navigator.push(context, MaterialPageRoute(builder: ((context) {
              return LoginPage();
            })));
          }
        },
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF6469d9),
        title: const Text(
          'Your Subjects',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: ListView(children: [
          Items(subject: subjects[0]),
          Items(subject: subjects[1]),
          Items(subject: subjects[2]),
          Items(subject: subjects[3]),
          Items(subject: subjects[4]),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 160, vertical: 50),
          )
        ]),
      ),
    );
  }
}
