import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghyabko/api/excel_apiforsub.dart';
import 'package:ghyabko/screens/auth/Login_Screen.dart';

class AddstudentTOsubject extends StatefulWidget {
  final String subjectID;
  final String subjectName;
  const AddstudentTOsubject({
    Key? key,
    required this.subjectID,
    required this.subjectName,
  }) : super(key: key);

  @override
  State<AddstudentTOsubject> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddstudentTOsubject> {
  List<QueryDocumentSnapshot> data = [];
  final excel_api = Get.put(excelapiforsub());
  Future<void> AddSubjectsToStudent(String email, String newSubject) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('Email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String userId = querySnapshot.docs.first.id;

        List<String> existingSubjects =
            List<String>.from(querySnapshot.docs.first['Subjects'] ?? []);

        existingSubjects.add(newSubject);

        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userId)
            .update({
          'Subjects': FieldValue.arrayUnion([newSubject])
        });
      } else {
        print('User with email $email not found');
      }
    } catch (e) {
      print("Error updating subjects: $e");
    }
  }

  Future<void> deleteSubjectFromStudent(
      String email, String subjectToDelete) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('Email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String userId = querySnapshot.docs.first.id;

        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userId)
            .update({
          'Subjects': FieldValue.arrayRemove([subjectToDelete])
        });
      } else {
        print('User with email $email not found');
      }
    } catch (e) {
      print("Error deleting subject: $e");
    }
  }

  addstudent() async {
    CollectionReference student = FirebaseFirestore.instance
        .collection('subject')
        .doc(widget.subjectID)
        .collection('student');
    await student.add({'studentemail': studentemail.text});
  }

  TextEditingController studentemail = TextEditingController();
  TextEditingController studentname = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              const Text('ADD Student To Subject',
                  style: TextStyle(color: Colors.white, fontSize: 25)),
              const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Image(
                  image: AssetImage('assets/student.png'),
                  height: 170,
                  width: 190,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 25),
                padding: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: constColor,
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Colors.white,
                    )
                  ],
                ),
                alignment: Alignment.center,
                child: TextFormField(
                  controller: studentemail,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.subject,
                      color: Colors.white,
                    ),
                    hintText: "Enter student email",
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  SizedBox(width: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: constColor,
                    ),
                    onPressed: () {
                      addstudent();
                      AddSubjectsToStudent(
                          studentemail.text, widget.subjectName);
                    },
                    icon: Icon(
                      Icons.add,
                      size: 24,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: constColor,
                    ),
                    onPressed: () {
                      excelapiforsub.instance
                          .pickFileAndUploadExel(widget.subjectID);
                    },
                    icon: Icon(
                      Icons.upload_file_rounded,
                      size: 24,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Upload Excel File',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 60),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: constColor,
                ),
                onPressed: () async {
                  var snapshots = await FirebaseFirestore.instance
                      .collection('subject')
                      .doc(widget.subjectID)
                      .collection('student')
                      .get();

                  for (var doc in snapshots.docs) {
                    await doc.reference.delete();
                  }
                  deleteSubjectFromStudent(
                      studentemail.text, widget.subjectName);
                },
                icon: Icon(
                  Icons.delete,
                  size: 24,
                  color: Colors.white,
                ),
                label: Text(
                  'delete',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
