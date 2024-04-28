import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghyabko/screens/auth/Login_Screen.dart';

class EditeStudent extends StatefulWidget {
  final String id;
  final String oldname;
  final String oldemile;
  final String oldPassword;
  const EditeStudent(
      {super.key,
      required this.id,
      required this.oldname,
      required this.oldemile,
      required this.oldPassword});

  @override
  State<EditeStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<EditeStudent> {
  CollectionReference student = FirebaseFirestore.instance.collection('Users');

  TextEditingController emailController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController PasswordController = TextEditingController();

  var auth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser;

  Future<void> editStudent(
      String email, String oldPassword, String newPassword) async {
    var cred =
        EmailAuthProvider.credential(email: email, password: oldPassword);
    await currentUser!
        .reauthenticateWithCredential(cred)
        .then((value) => {currentUser!.updatePassword(newPassword)});

    await student.doc(widget.id).update({
      'Name': nameController.text,
      'Email': emailController.text,
      'Password': PasswordController.text
    });

    Navigator.of(context)
        .pushNamedAndRemoveUntil("All_Student", (route) => false);
  }

  @override
  void initState() {
    super.initState();
    nameController.text = widget.oldname;
    emailController.text = widget.oldemile;
    PasswordController.text = widget.oldPassword;
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              const Text('Edit Student',
                  style: TextStyle(color: Colors.white, fontSize: 40)),
              const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Image(
                  image: AssetImage('assets/student.png'),
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
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Colors.white,
                    )
                  ],
                ),
                alignment: Alignment.center,
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.subject,
                      color: Colors.white,
                    ),
                    hintText: "Enter name",
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
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Colors.white,
                    )
                  ],
                ),
                alignment: Alignment.center,
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    hintText: "Enter Email",
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
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Colors.white,
                    )
                  ],
                ),
                alignment: Alignment.center,
                child: TextFormField(
                  controller: PasswordController,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.password_outlined,
                      color: Colors.white,
                    ),
                    hintText: "Enter Password",
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
                    onPressed: () => {
                      editStudent(widget.oldemile, widget.oldPassword,
                          PasswordController.text)
                    },
                    minWidth: 140,
                    height: 60,
                    child: const Text(
                      'Save',
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
