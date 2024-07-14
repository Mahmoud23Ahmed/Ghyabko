import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:ghyabko/screens/Admin/AllStudent.dart';
import 'package:ghyabko/screens/Admin/All_Doctor.dart';
import 'package:ghyabko/screens/Admin/AddDoctor.dart';
import 'package:ghyabko/screens/Admin/AllSubjects.dart';
import 'package:ghyabko/screens/Admin/addStudent.dart';
//import 'package:ghyabko/screens/adminweb/navbar.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xff8086F0),
            Color(0xff7277E4),
            Color(0xff676DDC),
            Color(0xff576DDC),
            Color(0xff4E54C8),
          ]),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xff8086F0),
                    Color(0xff7277E4),
                    Color(0xff676DDC),
                    Color(0xff576DDC),
                    Color(0xff4E54C8),
                  ]),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'HOME',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.people,
                          color: Colors.white,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    AddStudent(title: 'Add student')));
                          },
                          child: Text(
                            'Add Student',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.school,
                          color: Colors.white,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Doctor()));
                          },
                          child: Text(
                            'Add Doctor',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.class_,
                          color: Colors.white,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Addsubject()));
                          },
                          child: Text(
                            'Subject',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.article_rounded,
                          color: Colors.white,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => All_Student()));
                          },
                          child: Text(
                            'Student',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.article_rounded,
                          color: Colors.white,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => All_Doctor()));
                          },
                          child: Text(
                            'Doctors',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Text(
                        'GHYABKO',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Pacifico',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                        child: Image.asset(
                      "assets/4428861.png",
                      height: 600,
                    )),
                  ),
                  Expanded(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 150.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ghyabko',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 40),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: Text(
                                'welcome Admin to our system you can add doctor ,student ,subject and Edite or view all of this ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
