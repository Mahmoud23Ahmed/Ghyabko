import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:ghyabko/api/user_api.dart';

class excelapiforsub extends GetxController {
  static excelapiforsub get instance => Get.find();
  final user_data = Get.put(userapi());

  Future<void> pickFileAndUploadExel(String subjectID, String subName,
      int emailColumn, String StudentEmail) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      List<int> bytes =
          result.files.first.bytes!; // Use bytes property instead of path

      var excel = Excel.decodeBytes(bytes); // Decode bytes directly
      for (var table in excel.tables.keys) {
        for (var row in excel.tables[table]!.rows) {
          String email = row[emailColumn - 1] != null
              ? extractEmail(row[emailColumn - 1]!.toString())
              : '';

          userapi.instance.addSubjectToUser(subName, StudentEmail);
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

  Future<void> deleteSubjectFromUsersInExcel(
      String subjectID, String subName, int emailColumn) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
      );

      if (result != null) {
        List<int> bytes = result.files.first.bytes!;
        var excel = Excel.decodeBytes(bytes);

        for (var table in excel.tables.keys) {
          for (var row in excel.tables[table]!.rows) {
            String email = row[emailColumn - 1] != null
                ? extractEmail(row[emailColumn - 1]!.toString())
                : '';

            // Get subject name from Firestore
            DocumentSnapshot subjectSnapshot = await FirebaseFirestore.instance
                .collection('subject')
                .doc(subjectID)
                .get();
            String? subjectName =
                (subjectSnapshot.data() as Map<String, dynamic>?)?['subname'];

            // Query user by email
            QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                .collection('Users')
                .where('Email', isEqualTo: email)
                .get();

            if (querySnapshot.docs.isNotEmpty) {
              DocumentSnapshot userSnapshot = querySnapshot.docs.first;
              Map<String, dynamic>? userData =
                  userSnapshot.data() as Map<String, dynamic>?;

              if (userData != null) {
                List<dynamic> currentSubjects =
                    (userData['Subjects'] as List<dynamic>?) ?? [];

                // Check if the subject exists in the list
                if (currentSubjects.contains(subjectName)) {
                  // Remove the subject from the list
                  currentSubjects.remove(subjectName);

                  // Update user's subjects list
                  await FirebaseFirestore.instance
                      .collection('Users')
                      .doc(userSnapshot.id)
                      .update({
                    'Subjects': currentSubjects,
                  });

                  print(
                      'Subject $subjectName deleted from user with email $email successfully.');
                } else {
                  print(
                      'Subject $subjectName does not exist for user with email $email.');
                }
              } else {
                print(
                    'User data is null or not in the expected format for user with email $email.');
              }
            } else {
              print('User with email $email not found');
            }
          }
        }
      }
    } catch (e) {
      print("Error deleting subject from users in Excel: $e");
    }
  }

  String extractEmail(String data) {
    RegExp regex = RegExp(r'([a-zA-Z0-9.-]+@[a-zA-Z0-9.-]+.[a-zA-Z0-9-]+)');
    String? email = regex.stringMatch(data)?.trim();
    return email ?? '';
  }
}
