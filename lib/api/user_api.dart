import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ghyabko/model/user_Model.dart';

class userapi extends GetxController {
  static userapi get instance => Get.find();

  Future<void> addUser(UserModel user) async {
    {
      try {
        // Create the user in Firebase Authentication
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: user.Email,
          password: user.Password,
        );

        // Add user data to Firestore
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
}
