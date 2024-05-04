import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ghyabko/screens/Student/notification_Screen.dart';
import 'package:ghyabko/screens/Student/profile.dart';
import 'package:flutter/material.dart';

const constColor = Color(0xFF6469d9);

// ignore: must_be_immutable
class YourSubject extends StatefulWidget {
  const YourSubject({super.key});
  @override
  State<YourSubject> createState() => _YourSubjectState();
}

class _YourSubjectState extends State<YourSubject> {
  List<String> subjectList = [];

  bool isloading = true;

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
    isloading = false;
  }

  @override
  void initState() {
    getsubject();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.person, color: Colors.white),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Profile()));
              })
        ],
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF6469d9),
        title: const Text(
          'Your Subjects',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: isloading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              itemCount: subjectList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisExtent: 160),
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NotificatePage(
                              subjectName: subjectList[i],
                            )));
                  },
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/subLogo.png",
                            height: 100,
                          ),
                          Text("${subjectList[i]}"),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
