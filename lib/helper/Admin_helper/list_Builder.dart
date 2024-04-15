import 'package:ghyabko/helper/search_bar.dart';
import 'package:ghyabko/helper/Admin_helper/item.dart';
import 'package:flutter/material.dart';

//import 'package:note_app/views/widgets/app_bar.dart';
//import 'package:note_app/views/widgets/item.dart';

class Body extends StatelessWidget {
  Body({super.key});
  final List<String> subject = ['sub 1', 'sub 2', 'sub 3', 'sub 4', 'sub 5'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(width: 15, height: 180),
          const Search_bar(),
          const SizedBox(width: 20),

          // عشان اقدر اقرر list
          Expanded(
            child: ListView.builder(
                itemCount: subject.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Item(
                      child: subject[index],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
