import 'package:ghyabko/api/user_api.dart';
import 'package:ghyabko/screens/auth/Login_Screen.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class All_Doctor extends StatefulWidget {
  const All_Doctor({Key? key}) : super(key: key);

  @override
  State<All_Doctor> createState() => _All_DoctorState();
}

class _All_DoctorState extends State<All_Doctor> {
  late Future<List<Map<String, dynamic>>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = userapi.instance.getUsersByType('Doctor');
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
        backgroundColor: const Color(0xff12032C),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg.jpg'),
              fit: BoxFit.cover,
              opacity: 50,
            ),
          ),
          child: Stack(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 70, left: 120),
                child: Text('All Doctor',
                    style: TextStyle(color: Colors.white, fontSize: 30)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 170, right: 10, left: 10),
                child: TextFormField(
                  onChanged: (data) {},
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    filled: true,
                    fillColor: constColor,
                    hintText: 'Enter Subject Name',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: constColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 230, left: 10, right: 10),
                child: SizedBox(
                  height: 600,
                  child: GestureDetector(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Container(
                      height: 40,
                      alignment: AlignmentDirectional.center,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: constColor,
                        borderRadius: BorderRadius.circular(19),
                      ),
                      child: FutureBuilder<List<Map<String, dynamic>>>(
                        future: _usersFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else {
                            List<Map<String, dynamic>> users = snapshot.data!;
                            return ListView.builder(
                              itemCount: users.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                  trailing: const Icon(Icons.delete,
                                      color: Colors.white),
                                  title: Text(
                                    users[index]['Name'] ??
                                        'Name not available',
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  )),
                ),
              ),
            ],
          ),
        ));
  }
}
