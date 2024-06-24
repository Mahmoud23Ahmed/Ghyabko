import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghyabko/api/user_api.dart';
import 'package:ghyabko/screens/Admin/AddstudentTosub.dart';
import 'package:ghyabko/screens/Admin/AddSubject.dart';
import 'package:ghyabko/screens/Admin/editSubject.dart';
import 'package:ghyabko/screens/auth/Login_Screen.dart';
import 'package:flutter/material.dart';

class Addsubject extends StatefulWidget {
  const Addsubject({super.key});

  @override
  State<Addsubject> createState() => _AddsubjectState();
}

class _AddsubjectState extends State<Addsubject> {
  List<QueryDocumentSnapshot> data = [];

  bool isloading = true;
  late StreamSubscription<QuerySnapshot> _subscription;

  // Function to initialize the listener
  void _initializeListener() {
    _subscription = FirebaseFirestore.instance
        .collection('subject')
        .snapshots()
        .listen((snapshot) {
      setState(() {
        data = snapshot.docs;
        isloading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getsubject();
    // Initialize the listener when the widget is first created
    _initializeListener();
  }

  @override
  void dispose() {
    // Dispose the subscription when the widget is disposed
    _subscription.cancel();
    super.dispose();
  }

  getsubject() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('subject').get();
    setState(() {
      data.addAll(querySnapshot.docs);
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: constColor,
        title: Text(
          'Subjects',
          style: const TextStyle(
              fontFamily: 'LibreBaskerville',
              fontSize: 23,
              color: Colors.white),
        ),
      ),
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: constColor,
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddSubjectButton()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      ),
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
                        builder: (context) => AddstudentTOsubject(
                              subjectID: data[i].id,
                              subjectName: data[i]['subname'],
                            )));
                  },
                  onLongPress: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.rightSlide,
                      title: 'Delete or Edit Subject',
                      desc: 'choose you want to do',
                      btnOkText: 'Delete',
                      btnCancelText: 'Edit',
                      btnCancelOnPress: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditeSubjectButton(
                                id: data[i].id,
                                oldname: data[i]['subname'],
                                oldemile: data[i]['docemail'])));
                      },
                      btnOkOnPress: () async {
                        await FirebaseFirestore.instance
                            .collection('subject')
                            .doc(data[i].id)
                            .delete();
                        userapi.instance
                            .deleteSubjectFromAllUsers(data[i]['subname']);
                        Navigator.of(context)
                            .pushReplacementNamed("Addsubject");
                      },
                    ).show();
                  },
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/subjecticon.png",
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
