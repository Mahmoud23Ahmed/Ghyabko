import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghyabko/screens/Doctor/main_Page.dart';
import 'package:ghyabko/screens/auth/Login_Screen.dart';
import 'package:flutter/material.dart';

class SubjectName extends StatefulWidget {
  SubjectName({super.key});

  @override
  State<SubjectName> createState() => _SubjectNameState();
}

class _SubjectNameState extends State<SubjectName> {
  List<QueryDocumentSnapshot> data = [];

  bool isloading = true;

  getsubject() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('subject').get();
    data.addAll(querySnapshot.docs);
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
      appBar: AppBar(
        backgroundColor: constColor,
        title: Text(
          'Your Subjects',
          style: const TextStyle(
              fontFamily: 'LibreBaskerville',
              fontSize: 23,
              color: Colors.white),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: isloading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              itemCount: data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisExtent: 160),
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            DoctorPage(subjectID: data[i].id)));
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
                          Text("${data[i]['subname']}"),
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
