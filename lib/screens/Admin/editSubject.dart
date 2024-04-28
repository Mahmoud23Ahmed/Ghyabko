import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghyabko/screens/auth/Login_Screen.dart';

class EditeSubjectButton extends StatefulWidget {
  final String id;
  final String oldname;
  final String oldemile;
  const EditeSubjectButton(
      {super.key,
      required this.id,
      required this.oldname,
      required this.oldemile});

  @override
  State<EditeSubjectButton> createState() => _AddStudentState();
}

class _AddStudentState extends State<EditeSubjectButton> {
  // GlobalKey<FormState> formstate = GlobalKey<FormState>();
  CollectionReference subject =
      FirebaseFirestore.instance.collection('subject');

  TextEditingController emailController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  // bool isloading = false;

  editsubject() async {
    // isloading = true;
    setState(() {});
    await subject.doc(widget.id).update(
        {'subname': nameController.text, 'docemail': emailController.text});
    // isloading = false;
    Navigator.of(context)
        .pushNamedAndRemoveUntil("Addsubject", (route) => false);
  }

  @override
  void initState() {
    super.initState();
    nameController.text = widget.oldname;
    emailController.text = widget.oldemile;
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
              const Text('Edit Subject',
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Material(
                  color: constColor,
                  borderRadius: BorderRadius.circular(10),
                  child: MaterialButton(
                    onPressed: () => {editsubject()},
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
