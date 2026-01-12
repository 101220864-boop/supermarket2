import 'package:flutter/material.dart';
import 'data/db_platform.dart';
import 'screens/StartScreen.dart'; // عدلي الاسم حسب ملفك

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DbPlatform.init(); // ✅ لازم هون قبل runApp

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartScreen(),
    );
  }
}
