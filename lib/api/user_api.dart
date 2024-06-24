import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ghyabko/model/user_Model.dart';

class userapi extends GetxController {
  static userapi get instance => Get.find();

  Future<void> addUser(UserModel user) async {
    {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: user.Email,
          password: user.Password,
        );
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userCredential.user!.uid)
            .set({
          'Name': user.Name,
          'Email': user.Email,
          'Password': user.Password,
          'Type': user.Type,
          'Subjects': user.subjects,
        });
      } catch (e) {
        print("Error adding user: $e");
        // Handle error
      }
    }
  }

  Future<List<Map<String, dynamic>>> getUsersByType(String userType) async {
    List<Map<String, dynamic>> users = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('Type', isEqualTo: userType)
          .get();

      querySnapshot.docs.forEach((doc) {
        users.add(doc.data() as Map<String, dynamic>);
      });

      return users;
    } catch (e) {
      print("Error retrieving users: $e");
      return [];
    }
  }

  Future<void> addSubjectToUser(String Email, String subject) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('Email', isEqualTo: Email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot userSnapshot = querySnapshot.docs.first;

        Map<String, dynamic>? userData =
            userSnapshot.data() as Map<String, dynamic>?;

        if (userData != null) {
          List<dynamic> currentSubjects = userData['Subjects'] ?? [];

          if (!currentSubjects.contains(subject)) {
            currentSubjects.add(subject);

            await FirebaseFirestore.instance
                .collection('Users')
                .doc(userSnapshot.id)
                .update({
              'Subjects': currentSubjects,
            });

            print('Subject added successfully.');
          } else {
            print('Subject already exists for this user.');
          }
        } else {
          print('User data is null or not in the expected format.');
        }
      } else {
        print('User with username $Email not found.');
      }
    } catch (error) {
      print('Error adding subject: $error');
    }
  }

  Future<void> deleteSubjectFromAllUsers(String subject) async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Users').get();

      for (DocumentSnapshot userSnapshot in querySnapshot.docs) {
        Map<String, dynamic>? userData =
            userSnapshot.data() as Map<String, dynamic>?;

        if (userData != null) {
          List<dynamic> currentSubjects = userData['Subjects'] ?? [];

          if (currentSubjects.contains(subject)) {
            currentSubjects.remove(subject);

            await FirebaseFirestore.instance
                .collection('Users')
                .doc(userSnapshot.id)
                .update({
              'Subjects': currentSubjects,
            });

            print(
                'Subject deleted from user ${userData['Username']} successfully.');
          }
        } else {
          print(
              'User data is null or not in the expected format for user ${userSnapshot.id}.');
        }
      }

      print('Subject deleted from all users successfully.');
    } catch (error) {
      print('Error deleting subject from all users: $error');
    }
  }

  Future<void> deleteSubjectFromUserByEmail(
      String email, String subject) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('Email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot userSnapshot = querySnapshot.docs.first;
        Map<String, dynamic>? userData =
            userSnapshot.data() as Map<String, dynamic>?;

        if (userData != null) {
          List<dynamic> currentSubjects = userData['Subjects'] ?? [];
          if (currentSubjects.contains(subject)) {
            currentSubjects.remove(subject);

            await FirebaseFirestore.instance
                .collection('Users')
                .doc(userSnapshot.id)
                .update({
              'Subjects': currentSubjects,
            });

            print('Subject deleted from user with email $email successfully.');
          } else {
            print('Subject does not exist for user with email $email.');
          }
        } else {
          print(
              'User data is null or not in the expected format for user with email $email.');
        }
      } else {
        print('User with email $email not found.');
      }
    } catch (error) {
      print('Error deleting subject from user with email $email: $error');
    }
  }
}
