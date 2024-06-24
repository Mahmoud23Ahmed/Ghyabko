import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ghyabko/api/user_api.dart';
import 'package:ghyabko/screens/auth/Login_Screen.dart';
import 'package:get/get.dart';

class AddSubjectButton extends StatefulWidget {
  const AddSubjectButton({
    Key? key,
  }) : super(key: key);

  @override
  State<AddSubjectButton> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddSubjectButton> {
  List<QueryDocumentSnapshot> data = [];
  // GlobalKey<FormState> formstate = GlobalKey<FormState>();
  CollectionReference subject =
      FirebaseFirestore.instance.collection('subject');

  TextEditingController emailController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  final user_data = Get.put(userapi());

  addsubject() async {
    userapi.instance
        .addSubjectToUser(emailController.text, nameController.text);
    setState(() {});
    await subject.add(
        {'subname': nameController.text, 'docemail': emailController.text});
    Navigator.of(context)
        .pushNamedAndRemoveUntil("Addsubject", (route) => false);
  }

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
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    hintText: "Enter Doc Email",
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
                    onPressed: () => {addsubject()},
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
