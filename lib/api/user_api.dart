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
        // Upload image to Firebase Storage
        // String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
        // Reference storageReference = FirebaseStorage.instance.ref().child('user_images/$imageFileName.jpg');
        // await storageReference.putFile(image);

        // Get the download URL for the image
        // String imageUrl = await storageReference.getDownloadURL();

        // Add user data to Firestore
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userCredential.user!.uid)
            .set({
          'Name': user.Name,
          'Email': user.Email,
          'Password': user.Password,
          'Image_url': "null",
          'Type': user.Type,
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
