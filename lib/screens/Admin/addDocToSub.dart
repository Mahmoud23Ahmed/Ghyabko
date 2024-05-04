import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ghyabko/screens/auth/Login_Screen.dart';

class AddSubjectToDoc extends StatefulWidget {
  const AddSubjectToDoc({
    Key? key,
  }) : super(key: key);

  @override
  State<AddSubjectToDoc> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddSubjectToDoc> {
  List<QueryDocumentSnapshot> data = [];
  CollectionReference subject =
      FirebaseFirestore.instance.collection('subject');

  TextEditingController emailController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  Future<void> AddSubjectsToDoc(String email, String newSubject) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('Email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String userId = querySnapshot.docs.first.id;

        List<String> existingSubjects =
            List<String>.from(querySnapshot.docs.first['Subjects'] ?? []);

        existingSubjects.add(newSubject);

        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userId)
            .update({
          'Subjects': FieldValue.arrayUnion([newSubject])
        });
      } else {
        print('User with email $email not found');
      }
    } catch (e) {
      print("Error updating subjects: $e");
    }
  }

  addsubject() async {
    setState(() {});
    await subject.add(
        {'subname': nameController.text, 'docemail': emailController.text});
    Navigator.of(context)
        .pushNamedAndRemoveUntil("Addsubject", (route) => true);
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
              const Text('ADD Doctor to Subject',
                  style: TextStyle(color: Colors.white, fontSize: 30)),
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
                    hintText: "Enter Doctor Email",
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
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: constColor,
                    ),
                    onPressed: () {
                      AddSubjectsToDoc(
                          emailController.text, nameController.text);
                      addsubject();
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
