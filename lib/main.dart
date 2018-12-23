import 'package:flutter/material.dart';
import 'package:watering_app/screens/home_screen.dart';
import 'package:watering_app/screens/propriety_view_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sua Irrigação',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

