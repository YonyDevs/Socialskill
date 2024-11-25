// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(FlutterMysqlApp());
}

class FlutterMysqlApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MySQL App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(),
    );
  }
}
