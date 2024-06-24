import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class excelapi extends GetxController {
  static excelapi get instance => Get.find();

  Future<void> pickFileAndUploadExel(
      String Type, int nameColumn, int emailColumn, int passwordColumn) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
      );

      if (result != null) {
        PlatformFile file = result.files.first;
        List<int> bytes = result.files.first.bytes!;
        var excel = Excel.decodeBytes(bytes);

        for (var table in excel.tables.keys) {
          for (var row in excel.tables[table]!.rows) {
            String name = row[nameColumn - 1] != null
                ? _extractName(row[nameColumn - 1]!.toString())
                : '';
            String email = row[emailColumn - 1] != null
                ? extractEmail(row[emailColumn - 1]!.toString())
                : '';
            String password = row[passwordColumn - 1] != null
                ? _extractPassword(row[passwordColumn - 1]!.toString())
                : '';

            // Validate email format
            if (isValidEmail(email)) {
              try {
                // Attempt to create user with Firebase Authentication
                UserCredential userCredential =
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                await FirebaseFirestore.instance
                    .collection('Users')
                    .doc(userCredential.user!.uid)
                    .set({
                  'Name': name,
                  'Email': email,
                  'Password': password,
                  'Type': Type,
                  'Subjects': null,
                });

                print('User created successfully with email: $email');
              } catch (error) {
                print('Failed to create user with email $email: $error');
              }
            } else {
              print('Invalid email format: $email');
            }
          }
        }
      }
    } catch (error) {
      print('Error uploading Excel file: $error');
    }
  }

  bool isValidEmail(String email) {
    // Regular expression for email validation
    RegExp emailRegex =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$', caseSensitive: false);
    return emailRegex.hasMatch(email);
  }

  Future<void> deleteUsersInExcel(int emailColumn, String Type) async {
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
                // Check if the user type is 'student'
                if (userData['Type'] == Type) {
                  // Delete the user
                  await FirebaseFirestore.instance
                      .collection('Users')
                      .doc(userSnapshot.id)
                      .delete();

                  print('User with email $email deleted successfully.');
                }
              }
            }
          }
        }
      }
    } catch (e) {
      print("Error deleting users from Excel: $e");
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
