import 'package:flutter/material.dart';
import 'package:skilsmanager/screens/skills_list_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skills App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SkillsListScreen(),
    );
  }
}
