// ignore_for_file: file_names

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghyabko/screens/Student/TakeAttendace.dart';
import 'package:ghyabko/screens/Student/profile.dart';
import 'package:flutter/material.dart';

const constColor = Color(0xFF6469d9);

// ignore: must_be_immutable
class NotificatePage extends StatefulWidget {
  final String subjectName;
  NotificatePage({super.key, required this.subjectName});

  @override
  State<NotificatePage> createState() => _NotificatePageState();
}

class _NotificatePageState extends State<NotificatePage> {
  List<QueryDocumentSnapshot> data = [];

  bool isloading = true;
  getNotification() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Notification')
        .where('SubjectName', isEqualTo: widget.subjectName)
        .get();
    data.addAll(querySnapshot.docs);
    isloading = false;
  }

  @override
  void initState() {
    super.initState();
    getNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: const Text(
          'Notification',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF6469d9),
      ),
      body: isloading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    if (data[index]['Message'] == 'Attendace') {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.question,
                        animType: AnimType.rightSlide,
                        title: 'want to take your location Please',
                        desc: 'Are you Agree ?',
                        btnOkText: 'No',
                        btnCancelText: 'Yes',
                        btnCancelOnPress: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TakeAttendace(
                                    LecName: data[index]['SubjectName'],
                                    LecNum: data[index]['LecName'],
                                  )));
                        },
                        btnOkOnPress: () async {},
                      ).show();
                    }
                  },
                  child: ListTile(
                      leading: const Icon(
                        Icons.notification_important,
                        color: constColor,
                      ),
                      trailing: Text(
                        "LecNum:  ${data[index]['LecName']}",
                        style: TextStyle(color: constColor, fontSize: 15),
                      ),
                      title: Text("${data[index]['Message']}")),
                );
              }),
    );
  }
}
