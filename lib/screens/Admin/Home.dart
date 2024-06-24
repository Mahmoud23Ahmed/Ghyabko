import 'package:ghyabko/helper/ClipRRect.dart';
import 'package:ghyabko/screens/Admin/AllStudent.dart';
import 'package:ghyabko/screens/Admin/All_Doctor.dart';
import 'package:ghyabko/screens/Admin/AddDoctor.dart';
import 'package:ghyabko/screens/Admin/AllSubjects.dart';
import 'package:flutter/material.dart';
import 'package:ghyabko/screens/Admin/addStudent.dart';
import 'package:ghyabko/screens/login/login.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  static const constColor = Color(0xFF6469d9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: ((context) {
            return login();
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
        decoration: const BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 65,
              ),
              const Text(
                'Welcome Admin',
                style: TextStyle(
                  color: constColor,
                  fontSize: 40,
                  fontFamily: 'Pacifico',
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  SizedBox(width: 30),
                  Expanded(
                    child: clipRRect(
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
                  ),
                  SizedBox(width: 30),
                  Expanded(
                    child: clipRRect(
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
                  ),
                  SizedBox(width: 30),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(width: 30),
                  Expanded(
                    child: clipRRect(
                        Icon(
                          Icons.class_,
                          color: Colors.white,
                          size: 50,
                        ),
                        Text(
                          'Subject',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        context,
                        Addsubject()),
                  ),
                  SizedBox(width: 30),
                  Expanded(
                    child: clipRRect(
                        Icon(
                          Icons.article_rounded,
                          color: Colors.white,
                          size: 50,
                        ),
                        Text(
                          'Student',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        context,
                        All_Student()),
                  ),
                  SizedBox(width: 30),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(width: 30),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 80, right: 80),
                      child: clipRRect(
                          Icon(
                            Icons.article_rounded,
                            color: Colors.white,
                            size: 50,
                          ),
                          Text(
                            'Doctors',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          context,
                          All_Doctor()),
                    ),
                  ),
                  SizedBox(width: 30),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
