import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

const constColor = Color(0xFF6469d9);

class AttendanceList extends StatefulWidget {
  final String subName;

  const AttendanceList({Key? key, required this.subName}) : super(key: key);

  @override
  _AttendanceListState createState() => _AttendanceListState();
}

class _AttendanceListState extends State<AttendanceList> {
  List<firebase_storage.Reference> _fileList = [];

  @override
  void initState() {
    super.initState();
    _getFileList();
  }

  Future<void> _getFileList() async {
    try {
      firebase_storage.FirebaseStorage storage =
          firebase_storage.FirebaseStorage.instance;
      firebase_storage.ListResult result = await storage.ref().listAll();

      setState(() {
        _fileList = result.items
            .where((ref) => ref.name.contains(widget.subName))
            .toList();
      });
    } catch (e) {
      print('Error fetching file list: $e');
    }
  }

  Future<void> _downloadExcelFile(firebase_storage.Reference fileRef) async {
    try {
      if (!fileRef.name.endsWith('.csv')) {
        print('Selected file is not an Excel file.');
        return;
      }

      String url = await fileRef.getDownloadURL();
      final taskId = await FlutterDownloader.enqueue(
        url: url,
        savedDir: '/storage/emulated/0/Download/',
        showNotification: true,
        openFileFromNotification: true,
        saveInPublicStorage:
            true, // Set this to true to save the file in public storage
      );
      print('Download task id: $taskId');
    } catch (e) {
      print('Error downloading file: $e');
    }
  }

  Future<void> _sendExcelToEmail(firebase_storage.Reference fileRef) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      final String? email = user?.email;

      if (email == null) {
        // Handle the case when the user is not logged in
        print("User not logged in or email not available");
        return;
      }
      if (!fileRef.name.endsWith('.csv')) {
        print('Selected file is not a CSV file.');
        return;
      }

      // Get the download URL for the file
      final String url = await fileRef.getDownloadURL();

      // Fetch the file data
      final http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<int> fileBytes = response.bodyBytes;

        // Create a temporary file to attach
        final tempDir = await getTemporaryDirectory();
        final tempFile = File('${tempDir.path}/${fileRef.name}');
        await tempFile.writeAsBytes(fileBytes);

        // Create an email with the attachment
        final Email emailToSend = Email(
          body: 'Please find the attendance list attached.',
          subject: 'Attendance List - ${fileRef.name}',
          recipients: [email], // Replace with the recipient's email
          attachmentPaths: [tempFile.path],
          isHTML: false,
        );

        // Send the email
        await FlutterEmailSender.send(emailToSend);
      } else {
        print('Error downloading file: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending email: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: constColor,
        title: Text(
          "Attendance List",
          style: const TextStyle(
              fontFamily: 'LibreBaskerville',
              fontSize: 23,
              color: Colors.white),
        ),
      ),
      body: Center(
        child: Container(
          width: 350, // Fixed width
          height: 600, // Fixed height
          child: _fileList.isEmpty
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : GridView.builder(
                  itemCount: _fileList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisExtent: 160),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.rightSlide,
                          title: 'Download or Send To your Email',
                          desc: 'Choose what you want to do',
                          btnOkText: 'Download',
                          btnCancelText: 'Send To Email',
                          btnCancelOnPress: () {
                            _sendExcelToEmail(_fileList[index]);
                          },
                          btnOkOnPress: () async {
                            _downloadExcelFile(_fileList[index]);
                          },
                        ).show();
                      },
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/excel.png",
                                height: 100,
                              ),
                              Text(_fileList[index].name),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
