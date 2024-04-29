import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghyabko/screens/Admin/editeStudent.dart';
import 'package:ghyabko/screens/auth/Login_Screen.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class All_Student extends StatefulWidget {
  const All_Student({Key? key}) : super(key: key);

  @override
  State<All_Student> createState() => _All_StudentState();
}

class _All_StudentState extends State<All_Student> {
  List<QueryDocumentSnapshot> data = [];
  getsUser(String userType) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('Type', isEqualTo: userType)
        .get();
    data.addAll(querySnapshot.docs);
  }

  @override
  void initState() {
    getsUser('Student');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: constColor,
        title: Text(
          'Students',
          style: const TextStyle(
              fontFamily: 'LibreBaskerville',
              fontSize: 23,
              color: Colors.white),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisExtent: 160),
        itemBuilder: (context, i) {
          return InkWell(
            onLongPress: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.warning,
                animType: AnimType.rightSlide,
                title: 'Are you want to edite?',
                desc: 'choose you went to do',
                btnOkText: 'Delete',
                btnCancelText: 'Edit',
                btnCancelOnPress: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditeStudent(
                          id: data[i].id,
                          oldname: data[i]['Name'],
                          oldemile: data[i]['Email'],
                          oldPassword: data[i]['Password'])));
                },
                btnOkOnPress: () async {
                  await FirebaseFirestore.instance
                      .collection('Users')
                      .doc(data[i].id)
                      .delete();
                  Navigator.of(context).pushReplacementNamed("All_Student");
                },
              ).show();
            },
            child: Card(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/subLogo.png",
                      height: 100,
                    ),
                    Text("${data[i]['Name']}"),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
