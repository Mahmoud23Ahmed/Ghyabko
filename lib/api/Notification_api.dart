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
          'Subjectid': notificationModel.subjectid,
        });
      } catch (e) {
        print("Error adding user: $e");
      }
    }
  }
}
