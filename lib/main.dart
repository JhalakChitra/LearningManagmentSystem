import 'package:flutter/material.dart';
import 'screens/auth/login.dart';
import 'screens/splashscreen.dart';
import 'screens/onboarding/onboardingscreen.dart';
import 'screens/home/homescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Firebase App Check
  await FirebaseAppCheck.instance.activate(
    androidProvider:
    kDebugMode ? AndroidProvider.debug : AndroidProvider.playIntegrity,
  );

  runApp(const LMSApp());
}

class LMSApp extends StatelessWidget {
  const LMSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learning App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: "Roboto",
      ),

      // First screen of app:
      home: SplashScreen(),

      routes: {
        "/login": (context) => const LoginScreen(),
        "/onboarding": (context) => const OnboardingScreen(),
        "/home": (context) => const HomeScreen(),
      },
    );
  }
}
