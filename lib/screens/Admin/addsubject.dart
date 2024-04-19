import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghyabko/screens/Admin/addstudentTosub.dart';
import 'package:ghyabko/screens/Admin/editbutton.dart';
import 'package:ghyabko/screens/auth/Login_Screen.dart';
import 'package:flutter/material.dart';

class Addsubject extends StatefulWidget {
  const Addsubject({super.key});

  @override
  State<Addsubject> createState() => _AddsubjectState();
}

class _AddsubjectState extends State<Addsubject> {
  List<QueryDocumentSnapshot> data = [];

  bool isloading = true;

  getsubject() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('subject').get();
    data.addAll(querySnapshot.docs);
    isloading = false;
  }

  @override
  void initState() {
    getsubject();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: constColor,
        title: Text(
          'All Subjects',
          style: const TextStyle(
              fontFamily: 'LibreBaskerville',
              fontSize: 23,
              color: Colors.white),
        ),
      ),
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: constColor,
        onPressed: () {
          Navigator.of(context).pushReplacementNamed("AddSubjectButton");
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      ),
      body: isloading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              itemCount: data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisExtent: 160),
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            AddstudentTOsubject(subjectID: data[i].id)));
                  },
                  onLongPress: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.rightSlide,
                      title: 'Delete or Edit Subject',
                      desc: 'choose you went to do',
                      btnOkText: 'Delete',
                      btnCancelText: 'Edit',
                      btnCancelOnPress: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditeSubjectButton(
                                id: data[i].id,
                                oldname: data[i]['subname'],
                                oldemile: data[i]['docemail'])));
                      },
                      btnOkOnPress: () async {
                        await FirebaseFirestore.instance
                            .collection('subject')
                            .doc(data[i].id)
                            .delete();
                        Navigator.of(context)
                            .pushReplacementNamed("Addsubject");
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
                          Text("${data[i]['subname']}"),
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
