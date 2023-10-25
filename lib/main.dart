import 'package:flutter/material.dart';
import 'package:quiz_app/Models/db_connect.dart';
import 'package:quiz_app/Models/question_model.dart';
import 'package:quiz_app/Screens/home_screen.dart';

void main() {
  var db = DBConnect();
  db.fetchQuestion();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}


