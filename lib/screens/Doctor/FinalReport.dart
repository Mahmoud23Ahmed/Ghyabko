import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ghyabko/screens/auth/Login_Screen.dart';

class FinalReport extends StatefulWidget {
  const FinalReport({super.key});

  @override
  State<FinalReport> createState() => _FinalReportState();
}

class _FinalReportState extends State<FinalReport> {
  List<QueryDocumentSnapshot> data = [];

  bool isloading = true;
  late String LecName;

  getsubject() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Notification')
        .where('LecName', isEqualTo: LecName)
        .get();
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
          'Final Report',
          style: const TextStyle(
              fontFamily: 'LibreBaskerville',
              fontSize: 23,
              color: Colors.white),
        ),
      ),
      extendBodyBehindAppBar: true,
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
                  onTap: () {},
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/subLogo.png",
                            height: 100,
                          ),
                          Text("${data[i]['LecName']}"),
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
