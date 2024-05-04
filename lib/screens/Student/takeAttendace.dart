import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TakeAttendace extends StatefulWidget {
  final String LecName;
  final String LecNum;

  const TakeAttendace({super.key, required this.LecName, required this.LecNum});
  @override
  _TakeAttendaceState createState() => _TakeAttendaceState();
}

class _TakeAttendaceState extends State<TakeAttendace> {
  List<String> loggedEmails = [];
  String? excelFileURL;
  bool isUploading = false;

  @override
  void initState() {
    super.initState();
    startListeningAuthState();
  }

  Future<void> startListeningAuthState() async {
    await Firebase.initializeApp();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        String userEmail = user.email!;
        logEmail(userEmail);
      }
    });
  }

  void logEmail(String email) {
    if (!loggedEmails.contains(email)) {
      setState(() {
        loggedEmails.add(email);
      });
      saveAndUploadToFirebase();
    }
  }

  Future<void> saveAndUploadToFirebase() async {
    if (!isUploading) {
      setState(() {
        isUploading = true;
      });

      List<String> existingEmails = await getExistingEmailsFromStorage();

      List<String> newEmails = loggedEmails
          .where((email) => !existingEmails.contains(email))
          .toList();

      existingEmails.addAll(newEmails);

      List<int> excelFile = generateExcelFile(existingEmails);

      excelFileURL = await uploadToFirebaseStorage(excelFile);

      await updateURLInFirestore(excelFileURL!);

      setState(() {
        isUploading = false;
      });
    }
  }

  Future<List<String>> getExistingEmailsFromStorage() async {
    final storage = FirebaseStorage.instance;
    String subName = widget.LecName;
    String lecNum = widget.LecNum;

    // Reference to the location of the Excel file
    final ref = storage.ref().child('$subName$lecNum.csv');

    try {
      final downloadData = await ref.getData();

      String excelData = utf8.decode(downloadData!);

      List<String> existingEmails = excelData.split('\n');

      existingEmails.removeWhere((element) => element.isEmpty);
      return existingEmails;
    } catch (e) {
      print('Error retrieving existing emails: $e');
      return [];
    }
  }

  List<int> generateExcelFile(List<String> emails) {
    String excelData = emails.join('\n');
    return utf8.encode(excelData);
  }

  Future<String> uploadToFirebaseStorage(List<int> excelFile) async {
    Uint8List excelDataUint8 = Uint8List.fromList(excelFile);

    final storage = FirebaseStorage.instance;
    String subName = widget.LecName;
    String lecNum = widget.LecNum;

    final ref = storage.ref().child('$subName$lecNum.csv');

    final uploadTask = ref.putData(excelDataUint8);

    await uploadTask.whenComplete(() => print('File uploaded successfully'));

    final String downloadURL = await ref.getDownloadURL();

    return downloadURL;
  }

  Future<int> updateURLInFirestore(String url) async {
    final firestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;
    int attendanceNum = 0;
    if (user != null) {
      var userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .get();
      var name = userDoc['Name'];
      var Email = userDoc['Email'];

      final AttendanceListcollection = firestore.collection('Attendace_List');
      final FinalReportcollection = firestore.collection('Final_Report');

      QuerySnapshot querySnapshot = await AttendanceListcollection.get();
      String? docId;
      if (querySnapshot.docs.isNotEmpty) {
        docId = querySnapshot.docs.first.id;
      }
      QuerySnapshot querySnapshot1 = await FirebaseFirestore.instance
          .collection('Final_Report')
          .where('Email', isEqualTo: Email)
          .where('SubjectName', isEqualTo: widget.LecName)
          .get();

      if (querySnapshot1.docs.isEmpty) {
        await FinalReportcollection.add({
          'userName': name,
          'Email': Email,
          'AttendanceNum': 1,
          'SubjectName': widget.LecName
        });
        print('New URL added to Firestore: $url');
        attendanceNum = 1;
      } else {
        final DocumentSnapshot attendanceDoc = querySnapshot1.docs.first;
        attendanceNum = attendanceDoc['AttendanceNum'] + 1;
        await attendanceDoc.reference
            .update({'AttendanceNum': attendanceNum.toString()});
        print('AttendanceNum updated to: $attendanceNum');
      }
      QuerySnapshot querySnapshot2 = await FirebaseFirestore.instance
          .collection('Attendace_List')
          .where('SubName', isEqualTo: widget.LecName)
          .where('LecNum', isEqualTo: widget.LecNum)
          .get();

      if (querySnapshot2.docs.isEmpty) {
        await AttendanceListcollection.add(
            {'SubName': widget.LecName, 'LecNum': widget.LecNum, 'url': url});
        print('New URL added to Firestore: $url');
      } else {
        await AttendanceListcollection.doc(docId).update({'url': url});
      }
    }
    return attendanceNum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Done"),
        ),
      ),
    );
  }
}
