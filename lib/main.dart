import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:ghyabko/screens/Admin/AllStudent.dart';
import 'package:ghyabko/screens/Admin/All_Doctor.dart';
import 'package:ghyabko/screens/Admin/AllSubjects.dart';
import 'package:ghyabko/screens/login/login.dart';
import 'package:ghyabko/splash_screen.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

late Size mq;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterDownloader.initialize(
    debug: true, // Set to false in production
  );
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
        'LoginPage': (context) => login(),
        'SplashScreen': (context) => SplashScreen(),
        'Addsubject': (context) => Addsubject(),
        'All_Student': (context) => All_Student(),
        'All_Doctor': (context) => All_Doctor(),
      },
      initialRoute: 'SplashScreen',
    );
  }
}
