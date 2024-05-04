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
          String email = row[1] != null ? extractEmail(row[1]!.toString()) : '';

          CollectionReference student = FirebaseFirestore.instance
              .collection('subject')
              .doc(subjectID)
              .collection('student');
          await student.add({
            'studentemail': email,
          });

          try {
            DocumentSnapshot subjectSnapshot = await FirebaseFirestore.instance
                .collection('subject')
                .doc(subjectID)
                .get();
            Map<String, dynamic>? data =
                subjectSnapshot.data() as Map<String, dynamic>?;
            String? subjectName = data?['subname'];
            QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                .collection('Users')
                .where('Email', isEqualTo: email)
                .get();

            if (querySnapshot.docs.isNotEmpty) {
              String userId = querySnapshot.docs.first.id;

              List<String> existingSubjects =
                  List<String>.from(querySnapshot.docs.first['Subjects'] ?? []);

              existingSubjects.add(subjectName!);

              await FirebaseFirestore.instance
                  .collection('Users')
                  .doc(userId)
                  .update({
                'Subjects': FieldValue.arrayUnion([subjectName])
              });
            } else {
              print('User with email $email not found');
            }
          } catch (e) {
            print("Error updating subjects: $e");
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
}
