import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class excelapi extends GetxController {
  static excelapi get instance => Get.find();

  Future<void> pickFileAndUploadExel(String Type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      var excel = Excel.decodeBytes(File(file.path!).readAsBytesSync());
      for (var table in excel.tables.keys) {
        for (var row in excel.tables[table]!.rows) {
          String name = row[0] != null ? _extractName(row[0]!.toString()) : '';
          String email = row[1] != null ? extractEmail(row[1]!.toString()) : '';
          String password =
              row[2] != null ? _extractPassword(row[2]!.toString()) : '';

          // Store data in Firestore
          await FirebaseFirestore.instance.collection('Users').add({
            'Name': name,
            'Email': email,
            'Password': password,
            'Image_url': null,
            'Type': Type,
          });
          try {
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: email,
              password: password,
            );
          } catch (error) {
            print('Failed to create user: $error');
          }
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
