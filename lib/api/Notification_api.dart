import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ghyabko/model/Notifiction_Model.dart';

class Notificationapi extends GetxController {
  static Notificationapi get instance => Get.find();

  Future<void> addNotification(NotificationModel notificationModel) async {
    {
      try {
        // Add Notification data to Firestore
        await FirebaseFirestore.instance
            .collection('Notification')
            .doc(notificationModel.id)
            .set({
          'Message': notificationModel.Message,
          'LecName': notificationModel.LecName,
          'Date': notificationModel.date,
          'Subject': notificationModel.subject,
        });
      } catch (e) {
        print("Error adding user: $e");
      }
    }
  }

//   Future<List<Map<String, dynamic>>> getUsersByType(String userType) async {
//     List<Map<String, dynamic>> users = [];

//     try {
//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//           .collection('Users')
//           .where('Type', isEqualTo: userType)
//           .get();

//       querySnapshot.docs.forEach((doc) {
//         users.add(doc.data() as Map<String, dynamic>);
//       });

//       return users;
//     } catch (e) {
//       print("Error retrieving users: $e");
//       return [];
//     }
//   }
}
