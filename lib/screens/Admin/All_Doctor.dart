import 'dart:async';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ghyabko/api/Excel_api.dart';
import 'package:ghyabko/screens/Admin/editeUser.dart';
import 'package:get/get.dart';
import 'package:ghyabko/screens/auth/Login_Screen.dart';

class All_Doctor extends StatefulWidget {
  const All_Doctor({Key? key}) : super(key: key);

  @override
  State<All_Doctor> createState() => _All_DoctorState();
}

class _All_DoctorState extends State<All_Doctor> {
  List<QueryDocumentSnapshot> data = [];
  bool isLoading = true;
  late StreamSubscription<QuerySnapshot> _subscription;
  TextEditingController _searchController = TextEditingController();

  // Function to initialize the listener
  void _initializeListener() {
    _subscription = FirebaseFirestore.instance
        .collection('Users')
        .where('Type', isEqualTo: 'Doctor')
        .snapshots()
        .listen((snapshot) {
      setState(() {
        data.clear(); // Clear existing data before adding new documents
        data.addAll(snapshot.docs);
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // Initialize the listener when the widget is first created
    _initializeListener();
  }

  @override
  void dispose() {
    // Dispose the subscription when the widget is disposed
    _subscription.cancel();
    super.dispose();
  }

  void _filterDoctors(String query) {
    if (query.isEmpty) {
      // If the search query is empty, reload all doctors
      getsDoctors('Doctor');
    } else {
      setState(() {
        // Filter doctors based on the search query
        data = data.where((doctor) {
          String name = doctor['Name'].toLowerCase();
          return name.startsWith(query.toLowerCase());
        }).toList();
      });
    }
  }

  void getsDoctors(String userType) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('Type', isEqualTo: userType)
          .get();

      setState(() {
        data.clear(); // Clear existing data before adding new documents
        data.addAll(querySnapshot.docs);
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching doctors: $e');
      // Handle error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    final emailNumController = TextEditingController();
    final excelApi = Get.put(excelapi());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: constColor,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search by Name',
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
          ),
          style: TextStyle(color: Colors.white),
          onChanged: _filterDoctors,
        ),
      ),
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: constColor,
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
                          int.tryParse(emailNumController.text) ?? 0;
                      excelApi.deleteUsersInExcel(emailColumn, 'Doctor');
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 35,
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              itemCount: data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 160,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
              ),
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
                        AuthCredential credential =
                            EmailAuthProvider.credential(
                          email: data[i]['Email'],
                          password: data[i]['Password'],
                        );
                        auth
                            .signInWithCredential(credential)
                            .then((userCredential) {
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
                        Navigator.of(context)
                            .pushReplacementNamed("All_Doctor");
                      },
                    ).show();
                  },
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/doc.png",
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
