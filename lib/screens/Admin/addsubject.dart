import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghyabko/api/user_api.dart';
import 'package:get/get.dart';
import 'package:ghyabko/screens/auth/Login_Screen.dart';

class AddSubjectButton extends StatefulWidget {
  const AddSubjectButton({Key? key}) : super(key: key);

  @override
  State<AddSubjectButton> createState() => _AddSubjectButtonState();
}

class _AddSubjectButtonState extends State<AddSubjectButton> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  final user_data = Get.put(userapi());
  final CollectionReference subjectCollection =
      FirebaseFirestore.instance.collection('subject');

  Future<void> addSubject() async {
    String docEmail = emailController.text.trim();
    String subName = nameController.text.trim();

    // Check if the subject already exists
    QuerySnapshot querySnapshot =
        await subjectCollection.where('subname', isEqualTo: subName).get();

    if (querySnapshot.docs.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Subject already exists'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Add subject to user data (assuming this function exists in userapi)
    userapi.instance.addSubjectToUser(docEmail, subName);

    // Add subject to Firestore collection
    await subjectCollection.add({
      'subname': subName,
      'docemail': docEmail,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Subject added successfully'),
        backgroundColor: Colors.green,
      ),
    );

    // Clear input fields after successful submission
    nameController.clear();
    emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: constColor,
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              const Text('ADD Subject',
                  style: TextStyle(color: constColor, fontSize: 40)),
              const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Image(
                  image: AssetImage('assets/subicon.png'),
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
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a subject name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.subject,
                      color: Colors.white,
                    ),
                    hintText: "Enter Subject name",
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
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter doctor\'s email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    hintText: "Enter Doctor's Email",
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Material(
                  color: constColor,
                  borderRadius: BorderRadius.circular(10),
                  child: MaterialButton(
                    onPressed: () {
                      if (nameController.text.trim().isEmpty ||
                          emailController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please fill all fields'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        addSubject();
                      }
                    },
                    minWidth: 140,
                    height: 60,
                    child: const Text(
                      'Add',
                      style: TextStyle(
                        fontSize: 22.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
