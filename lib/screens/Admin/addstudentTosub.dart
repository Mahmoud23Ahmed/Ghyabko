import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghyabko/api/excel_apiforsub.dart';
import 'package:ghyabko/api/user_api.dart';
import 'package:ghyabko/screens/auth/Login_Screen.dart';

class AddstudentTOsubject extends StatefulWidget {
  final String subjectID;
  final String subjectName;

  const AddstudentTOsubject({
    Key? key,
    required this.subjectID,
    required this.subjectName,
  }) : super(key: key);

  @override
  State<AddstudentTOsubject> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddstudentTOsubject> {
  final excel_api = Get.put(excelapiforsub());
  final user_data = Get.put(userapi());

  TextEditingController studentemail = TextEditingController();
  TextEditingController studentname = TextEditingController();
  final emailNumController = TextEditingController();

  void addStudent() async {
    try {
      await userapi.instance
          .addSubjectToUser(studentemail.text, widget.subjectName);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Student added to ${widget.subjectName}'),
          backgroundColor: Colors.green,
        ),
      );
      studentemail.clear();
      studentname.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add student: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.subjectName,
          style: const TextStyle(
            fontFamily: 'LibreBaskerville',
            fontSize: 23,
            color: Colors.white,
          ),
        ),
        backgroundColor: constColor,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 60),
              const Text(
                'ADD Student To Subject',
                style: TextStyle(color: constColor, fontSize: 25),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Image(
                  image: AssetImage('assets/student3.png'),
                  height: 170,
                  width: 190,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 25),
                padding: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: constColor,
                ),
                alignment: Alignment.center,
                child: TextFormField(
                  controller: studentname,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.subject,
                      color: Colors.white,
                    ),
                    hintText: "Enter student name",
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 25),
                padding: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: constColor,
                ),
                alignment: Alignment.center,
                child: TextFormField(
                  controller: studentemail,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.subject,
                      color: Colors.white,
                    ),
                    hintText: "Enter student email",
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 50),
              Row(
                children: [
                  SizedBox(width: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: constColor,
                    ),
                    onPressed: () {
                      addStudent();
                    },
                    icon: Icon(
                      Icons.add,
                      size: 24,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: constColor,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'Enter the number of columns in Excel',
                              style: TextStyle(color: constColor),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Text(
                                      'Email Column   ',
                                      style: TextStyle(color: constColor),
                                    ),
                                    Expanded(
                                      child: TextField(
                                        controller: emailNumController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('Submit'),
                                onPressed: () {
                                  int emailColumn =
                                      int.tryParse(emailNumController.text) ??
                                          0;

                                  excelapiforsub.instance.pickFileAndUploadExel(
                                    widget.subjectID,
                                    widget.subjectName,
                                    emailColumn,
                                    studentemail.text,
                                  );

                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.upload_file_rounded,
                      size: 24,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Add Students Excel File',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: constColor,
                    ),
                    onPressed: () async {
                      userapi.instance.deleteSubjectFromUserByEmail(
                        studentemail.text,
                        widget.subjectName,
                      );
                    },
                    icon: Icon(
                      Icons.delete,
                      size: 24,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Delete',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: constColor,
                    ),
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'Enter the number of columns in Excel',
                              style: TextStyle(color: constColor),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Text(
                                      'Email Column   ',
                                      style: TextStyle(color: constColor),
                                    ),
                                    Expanded(
                                      child: TextField(
                                        controller: emailNumController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('Submit'),
                                onPressed: () {
                                  int emailColumn =
                                      int.tryParse(emailNumController.text) ??
                                          0;
                                  excel_api.deleteSubjectFromUsersInExcel(
                                    widget.subjectID,
                                    widget.subjectName,
                                    emailColumn,
                                  );
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.delete,
                      size: 24,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Delete Students Excel',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
