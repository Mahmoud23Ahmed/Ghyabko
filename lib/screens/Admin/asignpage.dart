import 'package:ghyabko/screens/auth/Login_Screen.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Asign_Page extends StatelessWidget {
  const Asign_Page({Key? key}) : super(key: key);

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
                padding: EdgeInsets.only(top: 70, left: 20),
                child: Text('Asign Student to Subject',
                    style: TextStyle(color: Colors.white, fontSize: 30)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 170, right: 30, left: 30),
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
                padding: const EdgeInsets.only(top: 180, left: 30, right: 30),
                child: SizedBox(
                  height: 480,
                  child: ListView.builder(
                      itemCount: 20,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          color: constColor,
                          margin: const EdgeInsets.all(5),
                          child: ListTile(
                              leading: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              trailing:
                                  const Icon(Icons.delete, color: Colors.white),
                              title: Text(
                                "Subject Name $index",
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              )),
                        );
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 670),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: constColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
                      child: Text('Continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
