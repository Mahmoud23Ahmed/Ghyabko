// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghyabko/screens/Doctor/nofication_page.dart';
import 'package:ghyabko/screens/auth/Login_Screen.dart';
import 'package:flutter/material.dart';

class DoctorPage extends StatefulWidget {
  final String subjectID;
  DoctorPage({
    Key? key,
    required this.subjectID,
  }) : super(key: key);

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  String appBarTitle = 'Loading...';

  @override
  void initState() {
    super.initState();
    fetchName();
  }

  List<QueryDocumentSnapshot> data = [];
  Future<String?> getNameById(String id) async {
    try {
      CollectionReference subject =
          FirebaseFirestore.instance.collection('subject');

      DocumentSnapshot documentSnapshot = await subject.doc(id).get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        String? name = data['subname'];
        return name;
      } else {
        return null;
      }
    } catch (e) {
      print("Error getting name by ID: $e");
      return null;
    }
  }

  Future<void> fetchName() async {
    try {
      String? name = await getNameById(widget.subjectID);
      setState(() {
        appBarTitle = name ?? 'Default Name';
      });
    } catch (e) {
      setState(() {
        appBarTitle = 'Error';
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: constColor,
        title: Text(
          appBarTitle,
          style: const TextStyle(
              fontFamily: 'LibreBaskerville',
              fontSize: 23,
              color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 150,
          ),
          Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: constColor,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    textStyle: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.normal)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) {
                    return Notify(subjectID: widget.subjectID);
                  })));
                },
                child: const Text(
                  'Send Notification',
                  style: TextStyle(color: Colors.white),
                )),
          ),
          const SizedBox(width: 100, height: 100),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: constColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 33),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                textStyle: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                )),
            onPressed: () {},
            child: const Text(
              'Attendacne List',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 100, height: 100),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: constColor,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 56),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  textStyle: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.normal)),
              onPressed: () {},
              child: const Text(
                'final Report',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }

  getsubject() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('subject').get();
    data.addAll(querySnapshot.docs);
  }
}
