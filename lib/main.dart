import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'constant/app_routes.dart';
import 'constant/bindings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final user = FirebaseAuth.instance.currentUser;
  final initialRoute = user != null ? '/MainScreen' : '/login';
  runApp(MyApp(initialRoute: initialRoute));
}
class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      initialBinding: AppBinding(),
      getPages: AppRoutes.routes,
    );
  }
}

//TODO Add Notifications logic (back and front) (ask zahra)
//TODO Add Reports logic (back and front) (ask zahra)
//TODO Add Mapping logic (back and front) (ask zahra)