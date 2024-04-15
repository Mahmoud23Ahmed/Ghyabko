import 'package:ghyabko/screens/Doctor/main_Page.dart';
import 'package:ghyabko/screens/auth/Login_Screen.dart';
import 'package:flutter/material.dart';

class SubjectName extends StatelessWidget {
  SubjectName({super.key});
  final List<String> buttonNames = [
    'Algorithm',
    'Compiler',
    'parlell programming',
    'embeded System',
  ];
  final List<Widget Function(BuildContext)> pageRoutes = [
    (context) => const DoctorPage(
          namebar: 'Algorithm',
          nameBar: 'Alghorithm',
        ),
    (context) => const DoctorPage(
          nameBar: 'Compiler',
          namebar: 'compiler',
        ),
    (context) => const DoctorPage(
          nameBar: 'parlell programming',
          namebar: 'parlell programming',
        ),
    (context) => const DoctorPage(
          nameBar: 'embeded System',
          namebar: 'embeded system',
        ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: ((context) {
              return LoginPage();
            })));
          },
          backgroundColor: constColor,
          child: const Icon(
            Icons.logout_rounded,
            color: Colors.white,
          ),
        ),
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/bg.jpg'),
              fit: BoxFit.cover,
            )),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                  top: 100, start: 20, end: 20),
              child: Column(children: [
                const Text(
                  'Subject Name',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontFamily: 'LibreBaskerville'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SizedBox(
                    height: 60.0,
                    child: ListView.separated(
                      itemCount: buttonNames.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                // ignore: deprecated_member_use
                                primary: constColor,
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  // Set the desired text size
                                ),
                              ),
                              child: Text(
                                buttonNames[index],
                                style: const TextStyle(color: Colors.white),
                              ), // Button text
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: pageRoutes[index]),
                                );
                              },
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        height: 20,
                      ),
                    ),
                  ),
                )
              ]),
            )));
  }
}
