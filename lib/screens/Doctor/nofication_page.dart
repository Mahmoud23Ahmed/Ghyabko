import 'package:ghyabko/screens/auth/Login_Screen.dart';
import 'package:flutter/material.dart';

class Notify extends StatelessWidget {
  const Notify({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: constColor,
        title: const Text(
          '',
          style: TextStyle(
              fontFamily: 'LibreBaskerville',
              fontSize: 23,
              color: Colors.white),
        ),
      ),
      backgroundColor: constColor,
      body: Column(children: [
        const SizedBox(
          height: 100,
        ),
        const Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 80),
              child: Text(
                'Notfication     ',
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'LibreBaskerville',
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 50),
              child: Icon(
                Icons.notifications_active,
                size: 50,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: TextFormField(
            style: const TextStyle(
              height: 8.0,
            ),
            obscureText: true,
            onChanged: (data) {
              data = data;
            },
            decoration: const InputDecoration(
              hintText: 'write something ...',
              hintStyle: TextStyle(
                color: Colors.white,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 50, right: 50),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Center(
                child: Text('Send',
                    style: TextStyle(
                      color: constColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
