import 'package:flutter/material.dart';
import 'package:supermarket2/screens/calculatescreen.dart';

import 'screens/StartScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:GameScreen()
      //  home: StartScreen(),
    );
  }}