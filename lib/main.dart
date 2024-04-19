import 'package:firebase_core/firebase_core.dart';

import 'package:ghyabko/screens/Admin/addsubject.dart';

import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:ghyabko/screens/auth/Login_Screen.dart';

late Size mq;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'LoginPage': (context) => LoginPage(),
        'Addsubject': (context) => Addsubject(),
        //'AddSubjectButton': (context) => AddSubjectButton(title: 'addsubject'),
      },
      initialRoute: 'LoginPage',
    );
  }
}
