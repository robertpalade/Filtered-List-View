import 'package:flutter/material.dart';

import 'data/data.dart';
import 'dto/reaction.dart';
import 'dto/user.dart';
import 'filtered_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Users',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FilteredList(),
    );
  }
}


