// ignore_for_file: file_names

import 'package:ghyabko/screens/Doctor/nofication_page.dart';
import 'package:ghyabko/screens/auth/Login_Screen.dart';
import 'package:flutter/material.dart';

class DoctorPage extends StatelessWidget {
  const DoctorPage({super.key, required this.namebar, required String nameBar});
  final String namebar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: constColor,
        title: Text(
          namebar,
          style: const TextStyle(
              fontFamily: 'LibreBaskerville',
              fontSize: 23,
              color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 150,
          ),
          Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: constColor,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    textStyle: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.normal)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) {
                    return const Notify();
                  })));
                },
                child: const Text(
                  'Send Notification',
                  style: TextStyle(color: Colors.white),
                )),
          ),
          const SizedBox(width: 100, height: 100),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: constColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 33),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                textStyle: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                )),
            onPressed: () {},
            child: const Text(
              'Attendacne List',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 100, height: 100),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: constColor,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 56),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  textStyle: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.normal)),
              onPressed: () {},
              child: const Text(
                'final Report',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
