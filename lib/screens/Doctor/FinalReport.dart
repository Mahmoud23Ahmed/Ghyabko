import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ghyabko/screens/auth/Login_Screen.dart';

class FinalReport extends StatefulWidget {
  final String subjectName;
  const FinalReport({Key? key, required this.subjectName}) : super(key: key);

  @override
  State<FinalReport> createState() => _FinalReportState();
}

class _FinalReportState extends State<FinalReport> {
  List<QueryDocumentSnapshot> data = [];
  bool isloading = true;
  late String LecName;

  Future<void> Final_Report() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Final_Report')
        .where('SubjectName', isEqualTo: widget.subjectName)
        .get();

    setState(() {
      data.addAll(querySnapshot.docs);
      isloading = false;
    });
  }

  @override
  void initState() {
    Final_Report();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: constColor,
        title: Text(
          'Final Report',
          style: const TextStyle(
              fontFamily: 'LibreBaskerville',
              fontSize: 23,
              color: Colors.white),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.grey[200],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Student Name',
                          style: TextStyle(
                              fontFamily: 'LibreBaskerville',
                              fontSize: 18,
                              color: Colors.grey[800]),
                        ),
                        Text(
                          'Email',
                          style: TextStyle(
                              fontFamily: 'LibreBaskerville',
                              fontSize: 18,
                              color: Colors.grey[800]),
                        ),
                        Text(
                          'Attendance',
                          style: TextStyle(
                              fontFamily: 'LibreBaskerville',
                              fontSize: 18,
                              color: Colors.grey[800]),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {},
                        child: ListTile(
                          title: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child:
                                    Text("${data[index]["userName"]}       "),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text("   ${data[index]["Email"]}"),
                              ),
                            ],
                          ),
                          trailing: Text(
                            "${data[index]["AttendanceNum"].toString()}",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
