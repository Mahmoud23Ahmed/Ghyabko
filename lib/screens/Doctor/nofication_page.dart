import 'package:awesome_dialog/awesome_dialog.dart';
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
  int selectedNumber = 1;
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
            height: 50,
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
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Text(
                  'Select Lec Number   :    ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                buildNumberDropdown(onChanged: (int? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedNumber = newValue;
                    });
                  }
                }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
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
                          LecName: selectedNumber.toString(),
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
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.question,
                      animType: AnimType.leftSlide,
                      title: 'You want to take Attendance now ?',
                      btnCancelText: 'Yes',
                      btnOkText: 'No',
                      btnOkOnPress: () {
                        Navigator.pop(context);
                      },
                      btnCancelOnPress: () async {
                        if (formKey.currentState!.validate()) {
                          final Notification = NotificationModel(
                              Message: 'Attendace',
                              LecName: selectedNumber.toString(),
                              date: DateTime.now().toString(),
                              subjectName: widget.subjectName);
                          Notificationapi.instance
                              .addNotification(Notification);
                        }
                      },
                    ).show();
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

  DropdownButton<int> buildNumberDropdown(
      {required ValueChanged<int?> onChanged}) {
    return DropdownButton<int>(
      value: selectedNumber,
      onChanged: onChanged,
      items: List.generate(
        12,
        (index) => DropdownMenuItem<int>(
          value: index + 1,
          child: Text((index + 1).toString()),
        ),
      ),
    );
  }
}
