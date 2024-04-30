import 'package:get/get.dart';
import 'package:ghyabko/api/Notification_api.dart';
import 'package:ghyabko/model/Notifiction_Model.dart';
import 'package:ghyabko/screens/auth/Login_Screen.dart';
import 'package:flutter/material.dart';

class Notify extends StatefulWidget {
  final String subjectName;
  Notify({
    Key? key,
    required this.subjectName,
  }) : super(key: key);

  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  final Notification_data = Get.put(Notificationapi());

  @override
  Widget build(BuildContext context) {
    final MessageController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: constColor,
        title: const Text(
          '',
          style: TextStyle(
              fontFamily: 'LibreBaskerville',
              fontSize: 23,
              color: Colors.white),
        ),
      ),
      backgroundColor: constColor,
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 100,
          ),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 80),
                child: Text(
                  'Notfication     ',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'LibreBaskerville',
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 50),
                child: Icon(
                  Icons.notifications_active,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: TextFormField(
              controller: MessageController,
              style: const TextStyle(
                height: 8.0,
              ),
              onChanged: (data) {
                data = data;
              },
              decoration: const InputDecoration(
                hintText: 'write something ...',
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: constColor,
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final Notification = NotificationModel(
                          Message: MessageController.text.trim(),
                          LecName: "0",
                          date: DateTime.now().toString(),
                          subjectName: widget.subjectName);
                      Notificationapi.instance.addNotification(Notification);
                    }
                  },
                  icon: Icon(
                    Icons.send,
                    size: 24,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Send',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: constColor,
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final Notification = NotificationModel(
                          Message: 'Attendace',
                          LecName: "0",
                          date: DateTime.now().toString(),
                          subjectName: widget.subjectName);
                      Notificationapi.instance.addNotification(Notification);
                    }
                  },
                  icon: Icon(
                    Icons.notification_add_rounded,
                    size: 24,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Attendace',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
