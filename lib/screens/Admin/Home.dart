import 'package:ghyabko/helper/ClipRRect.dart';
import 'package:ghyabko/screens/Admin/AllStudent.dart';
import 'package:ghyabko/screens/Admin/All_Doctor.dart';
import 'package:ghyabko/screens/Admin/addDoctor.dart';
import 'package:ghyabko/screens/Admin/addStudent.dart';
import 'package:ghyabko/screens/Admin/addsubject.dart';
import 'package:ghyabko/screens/Admin/asignpage.dart';
import 'package:ghyabko/screens/auth/Login_Screen.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  static const constColor = Color(0xFF6469d9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: ((context) {
            return LoginPage();
          })));
        },
        backgroundColor: constColor,
        child: const Icon(
          Icons.logout_rounded,
          color: Colors.white,
        ),
      ),
      backgroundColor: const Color(0xff12032C),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.jpg'),
            fit: BoxFit.cover,
            opacity: 50,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              const Text(
                'Welcome Admin',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontFamily: 'Pacifico',
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  SizedBox(width: 30),
                  clipRRect(
                      Icon(
                        Icons.people,
                        color: Colors.white,
                        size: 50,
                      ),
                      Text(
                        'Add Student',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      context,
                      AddStudent(title: 'Add student')),
                  SizedBox(width: 30),
                  clipRRect(
                      Icon(
                        Icons.school,
                        color: Colors.white,
                        size: 50,
                      ),
                      Text(
                        'Add Doctor',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      context,
                      Doctor()),
                  SizedBox(width: 30),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(width: 30),
                  clipRRect(
                      Icon(
                        Icons.class_,
                        color: Colors.white,
                        size: 50,
                      ),
                      Text(
                        'Add Subject',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      context,
                      Addsubject()),
                  SizedBox(width: 30),
                  clipRRect(
                      Icon(
                        Icons.assignment,
                        color: Colors.white,
                        size: 50,
                      ),
                      Text(
                        '  Asign Student \n      to Subject',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      context,
                      Asign_Page()),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(width: 30),
                  clipRRect(
                      Icon(
                        Icons.article_rounded,
                        color: Colors.white,
                        size: 50,
                      ),
                      Text(
                        'All Student',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      context,
                      All_Student()),
                  SizedBox(width: 30),
                  clipRRect(
                      Icon(
                        Icons.article_rounded,
                        color: Colors.white,
                        size: 50,
                      ),
                      Text(
                        'All Doctors',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      context,
                      All_Doctor()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
