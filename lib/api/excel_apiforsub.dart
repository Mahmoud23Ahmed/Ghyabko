import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class excelapiforsub extends GetxController {
  static excelapiforsub get instance => Get.find();

  Future<void> pickFileAndUploadExel(String subjectID) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      var excel = Excel.decodeBytes(File(file.path!).readAsBytesSync());
      for (var table in excel.tables.keys) {
        for (var row in excel.tables[table]!.rows) {
          //  String name = row[0] != null ? _extractName(row[0]!.toString()) : '';
          String email = row[0] != null ? extractEmail(row[0]!.toString()) : '';

          // Store data in Firestore
          CollectionReference student = FirebaseFirestore.instance
              .collection('subject')
              .doc(subjectID)
              .collection('student');
          DocumentReference response = await student.add({
            'studentemail': email,
            //'studentname': name,
          });
        }
      }
    }
  }

  String extractEmail(String data) {
    RegExp regex = RegExp(r'([a-zA-Z0-9.-]+@[a-zA-Z0-9.-]+.[a-zA-Z0-9-]+)');
    String? email = regex.stringMatch(data)?.trim();
    return email ?? '';
  }

  String _extractName(String data) {
    int startIndex = data.indexOf('(') + 1;
    int endIndex = data.indexOf(',', startIndex);
    String name = data.substring(startIndex, endIndex).trim();
    return name;
  }

  String _extractPassword(String data) {
    int startIndex = data.indexOf('(') + 1;
    int endIndex = data.indexOf(',', startIndex);
    String password = data.substring(startIndex, endIndex).trim();
    return password;
  }
}
