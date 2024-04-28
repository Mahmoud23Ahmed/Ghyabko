import 'package:get/get.dart';
import 'package:ghyabko/api/user_api.dart';
import 'package:ghyabko/api/Excel_api.dart';
import 'package:ghyabko/model/user_Model.dart';
import 'package:ghyabko/screens/auth/Login_Screen.dart';
import 'package:flutter/material.dart';

class Doctor extends StatefulWidget {
  @override
  State<Doctor> createState() => _DoctorState();
}

class _DoctorState extends State<Doctor> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final PasswordController = TextEditingController();

  final user_data = Get.put(userapi());
  final excel_api = Get.put(excelapi());
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
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
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                const Text('ADD Doctor',
                    style: TextStyle(color: Colors.white, fontSize: 40)),
                const Padding(
                  padding: EdgeInsets.only(top: 80),
                  child: Image(
                    image: AssetImage('assets/doctor.png'),
                    height: 220,
                    width: 220,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
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
                        Icons.person,
                        color: Colors.white,
                      ),
                      hintText: "Enter Name",
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
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.vpn_key,
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
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 20),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: constColor,
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final user = UserModel(
                              Email: emailController.text.trim(),
                              Name: nameController.text.trim(),
                              Password: PasswordController.text.trim(),
                              Type: 'Doctor');

                          userapi.instance.addUser(user);
                        }
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
                    SizedBox(width: 20),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: constColor,
                      ),
                      onPressed: () {
                        excelapi.instance.pickFileAndUploadExel('Doctor');
                      },
                      icon: Icon(
                        Icons.upload_file_rounded,
                        size: 24,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Upload Excel File',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
