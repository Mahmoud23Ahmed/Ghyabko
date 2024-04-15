// ignore_for_file: file_names

import 'package:ghyabko/helper/Student_helper/Notificationclass.dart';
import 'package:ghyabko/screens/Student/add_subject.dart';
import 'package:ghyabko/screens/Student/profile.dart';
import 'package:ghyabko/screens/Student/your_subject.dart';
import 'package:ghyabko/screens/auth/Login_Screen.dart';
import 'package:flutter/material.dart';

import '../../helper/Student_helper/subWidgetsForNotif.dart';

const constColor = Color(0xFF6469d9);

// ignore: must_be_immutable
class NotificatePage extends StatelessWidget {
  NotificatePage({super.key});
  List<Notifi> notification = [
    Notifi(text: 'message 1'),
    Notifi(text: 'message 2'),
    Notifi(text: 'message 3'),
    Notifi(text: 'message 4'),
    Notifi(text: 'message 5'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: constColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.addchart_sharp,
              color: constColor,
            ),
            label: "Add Subject",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications_active_outlined,
              color: constColor,
            ),
            label: "Notification",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.subject_outlined,
              color: constColor,
            ),
            label: "Your Subject",
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
        title: const Text(
          'Notification',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF6469d9),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: ListView(children: [
          Items(notification: notification[0]),
          Items(notification: notification[1]),
          Items(notification: notification[2]),
          Items(notification: notification[3]),
          Items(notification: notification[4]),
        ]),
      ),
    );
  }
}
