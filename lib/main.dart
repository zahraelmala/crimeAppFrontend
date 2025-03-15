import 'package:a/report_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Crimepost.dart';
import 'emergencyService.dart';
import 'firebase_options.dart';
import 'login_screen.dart';
import 'password_manager.dart';
import 'setting_screen.dart';
import 'signup.dart';
import 'home_screen.dart';
import 'typesCrimes.dart';
import 'verification_screen.dart';
import 'verify_email.dart';
import 'your_posts_screen.dart';
import 'statistical_analysis.dart';
import 'MappingPage.dart';
import 'your_report_screen.dart';
import 'myProfile.dart';
import 'editProfile.dart';
import 'police.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    print("Initializing Firebase...");
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    }
    print("Firebase initialized successfully!");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PoliceStationLocationScreen()
    );
  }
}
