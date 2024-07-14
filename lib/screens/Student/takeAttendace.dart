import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghyabko/screens/auth/Login_Screen.dart';

class TakeAttendace extends StatefulWidget {
  final String LecName;
  final String LecNum;

  const TakeAttendace({Key? key, required this.LecName, required this.LecNum})
      : super(key: key);

  @override
  _TakeAttendaceState createState() => _TakeAttendaceState();
}

class _TakeAttendaceState extends State<TakeAttendace> {
  List<String> loggedNames = [];
  String? excelFileURL;
  bool isUploading = false;

  @override
  void initState() {
    super.initState();
    startListeningAuthState();
  }

  Future<void> startListeningAuthState() async {
    await Firebase.initializeApp();

    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        var userDoc = await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .get();
        var name = userDoc['Name'];
        String username = name;
        print(username);
        logName(username);
      }
    });
  }

  void logName(String name) {
    if (!loggedNames.contains(name)) {
      setState(() {
        loggedNames.add(name);
      });
      saveAndUploadToFirebase();
    }
  }

  Future<void> saveAndUploadToFirebase() async {
    if (!isUploading) {
      setState(() {
        isUploading = true;
      });

      List<String> existingNames = await getExistingNamesFromStorage();

      List<String> newNames =
          loggedNames.where((name) => !existingNames.contains(name)).toList();

      existingNames.addAll(newNames);

      List<int> excelFile = generateExcelFile(existingNames);

      excelFileURL = await uploadToFirebaseStorage(excelFile);

      await updateURLInFirestore(excelFileURL!);

      setState(() {
        isUploading = false;
      });
    }
  }

  Future<List<String>> getExistingNamesFromStorage() async {
    final storage = FirebaseStorage.instance;
    String subName = widget.LecName;
    String lecNum = widget.LecNum;

    // Reference to the location of the Excel file
    final ref = storage.ref().child('$subName$lecNum.csv');

    try {
      final downloadData = await ref.getData();

      String excelData = utf8.decode(downloadData!);

      List<String> existingNames = excelData.split('\n');

      existingNames.removeWhere((element) => element.isEmpty);
      return existingNames;
    } catch (e) {
      print('Error retrieving existing names: $e');
      return [];
    }
  }

  List<int> generateExcelFile(List<String> names) {
    String excelData = names.join('\n');
    // Use Utf8Encoder and manually add BOM
    var encoder = const Utf8Encoder();
    List<int> bom = [0xEF, 0xBB, 0xBF];
    return [...bom, ...encoder.convert(excelData)];
  }

  Future<String> uploadToFirebaseStorage(List<int> excelFile) async {
    Uint8List excelDataUint8 = Uint8List.fromList(excelFile);

    final storage = FirebaseStorage.instance;
    String subName = widget.LecName;
    String lecNum = widget.LecNum;

    final ref = storage.ref().child('$subName$lecNum.csv');

    // Specify the character encoding when uploading the file
    final uploadTask = ref.putData(
        excelDataUint8,
        SettableMetadata(
          contentType: 'text/csv; charset=utf-8',
        ));

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
        child: Container(
          width: 350, // Fixed width
          height: 600, // Fixed height
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: Image(
                  image: AssetImage('assets/ok.png'),
                  height: 300,
                  width: 300,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Text(
                  'Attendance has been registered successfully',
                  style: TextStyle(
                      fontSize: 20,
                      color: constColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: constColor),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Done",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
