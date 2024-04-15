// ignore_for_file: file_names
import 'package:ghyabko/main.dart';
import 'package:ghyabko/screens/Student/add_subject.dart';
import 'package:ghyabko/screens/Student/notification_Screen.dart';
import 'package:ghyabko/screens/Student/your_subject.dart';
import 'package:ghyabko/screens/auth/Login_Screen.dart';
import 'package:flutter/material.dart';

const constColor = Color(0xFF6469d9);

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => Profilescreen();
}

class Profilescreen extends State<StudentPage> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 3,
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
              padding: const EdgeInsets.only(top: 230, left: 20, right: 20),
              child: Column(
                children: [
                  profileImg(),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Student Name',
                      style: TextStyle(
                        color: constColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Fourth Year',
                      style: TextStyle(
                        color: constColor,
                        fontSize: 20,
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

  Widget profileImg() {
    return const Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: AssetImage("assets/profileIcon.jpg"),
        ),
      ]),
    );
  }
}
