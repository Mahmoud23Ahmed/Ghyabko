import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ghyabko/screens/Admin/editeUser.dart';
import 'package:ghyabko/screens/auth/Login_Screen.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class All_Doctor extends StatefulWidget {
  const All_Doctor({Key? key}) : super(key: key);

  @override
  State<All_Doctor> createState() => _All_DoctorState();
}

class _All_DoctorState extends State<All_Doctor> {
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
    getsUser('Doctor');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: constColor,
        title: Text(
          'Doctors',
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
            onTap: () {
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
                      builder: (context) => EditeUser(
                          id: data[i].id,
                          oldname: data[i]['Name'],
                          oldemile: data[i]['Email'],
                          oldPassword: data[i]['Password'])));
                },
                btnOkOnPress: () async {
                  FirebaseAuth auth = FirebaseAuth.instance;
                  AuthCredential credential = EmailAuthProvider.credential(
                    email: data[i]['Email'],
                    password: data[i]['Password'],
                  );
                  auth.signInWithCredential(credential).then((userCredential) {
                    User? user = userCredential.user;
                    if (user != null) {
                      user.delete().then((_) {
                        print('User deleted successfully');
                      }).catchError((error) {
                        print('Error deleting user: $error');
                      });
                    }
                  }).catchError((error) {
                    print('Error updating email: $error');
                  });

                  await FirebaseFirestore.instance
                      .collection('Users')
                      .doc(data[i].id)
                      .delete();
                  Navigator.of(context).pushReplacementNamed("All_Doctot");
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
