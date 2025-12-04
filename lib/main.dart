import 'package:flutter/material.dart';
import 'screens/auth/login.dart';
import 'screens/splashscreen.dart';

void main() {
  runApp(const LMSApp());
}

class LMSApp extends StatelessWidget {
  const LMSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LMS App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Roboto",
      ),
      home: const SplashScreen(),
    );
  }
}
