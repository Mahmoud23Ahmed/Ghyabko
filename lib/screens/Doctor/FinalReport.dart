import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ghyabko/screens/auth/Login_Screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class FinalReport extends StatefulWidget {
  final String subjectName;
  const FinalReport({Key? key, required this.subjectName}) : super(key: key);

  @override
  State<FinalReport> createState() => _FinalReportState();
}

class _FinalReportState extends State<FinalReport> {
  List<QueryDocumentSnapshot> data = [];
  bool isLoading = true;
  final GlobalKey _finalReportKey = GlobalKey();
  int notificationCount = 0;

  Future<void> fetchFinalReport() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Final_Report')
          .where('SubjectName', isEqualTo: widget.subjectName)
          .get();

      QuerySnapshot notificationQuerySnapshot = await FirebaseFirestore.instance
          .collection('Notification')
          .where('Message', isEqualTo: "Attendance")
          .where('SubjectName', isEqualTo: widget.subjectName)
          .get();

      setState(() {
        data.addAll(querySnapshot.docs);
        notificationCount = notificationQuerySnapshot.size;
        isLoading = false;
      });
    } catch (e) {
      // Handle the error properly
      print("Error fetching data: $e");
    }
  }

  Future<void> generateAndShareExcel() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String? email = user?.email;

    if (email == null) {
      // Handle the case when the user is not logged in
      print("User not logged in or email not available");
      return;
    }

    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];

    // Arabic header row
    List<String> headerRow = [
      "الاسم",
      "الايميل",
      "عدد الحضور",
      "اجمالي المحاضرات"
    ];

    // Adding header row to the Excel sheet
    for (var j = 0; j < headerRow.length; j++) {
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: j, rowIndex: 1))
          .value = TextCellValue(headerRow[j]);
    }

    // Data rows
    List<List<String>> rows = [];
    for (var doc in data) {
      List<String> rowData = [
        doc["userName"].toString(),
        doc["Email"].toString(),
        doc["AttendanceNum"].toString(),
        notificationCount.toString(),
      ];
      rows.add(rowData);
    }

    // Adding data rows
    for (var i = 0; i < rows.length; i++) {
      for (var j = 0; j < rows[i].length; j++) {
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: j, rowIndex: i + 2))
            .value = TextCellValue(rows[i][j]);
      }
    }
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      String fileName = "${widget.subjectName}_FinalReport.xlsx";
      String filePath = "${directory.path}/$fileName";
      File(filePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(excel.encode()!);

      final Email emailToSend = Email(
        body: 'press Send to receive the excel file',
        subject: 'Final Report of ${widget.subjectName}',
        recipients: [email],
        attachmentPaths: [filePath],
        isHTML: false,
      );

      await FlutterEmailSender.send(emailToSend);
    } catch (e) {
      if (e is PlatformException && e.code == 'not_available') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text(
                'No email client available. Please install an email client to send the report.'),
            actions: [
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      } else {
        print('Error sending email: $e');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchFinalReport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          generateAndShareExcel();
        },
        backgroundColor: constColor,
        child: const Icon(
          Icons.upload_file_outlined,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: constColor,
        title: const Text(
          'Final Report',
          style: TextStyle(
            fontFamily: 'LibreBaskerville',
            fontSize: 23,
            color: Colors.white,
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Builder(
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    key: _finalReportKey,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {},
                              child: Card(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${data[index]["userName"]}",
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text("${data[index]["Email"]}"),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "${data[index]["AttendanceNum"]} | $notificationCount",
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
