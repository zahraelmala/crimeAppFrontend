import 'package:a/view/screens/home_screen.dart';
import 'package:get/get.dart';

import '../../view/screens/login_screen.dart';

// Define the routes and corresponding pages for the application
abstract class AppRoutes {
  static final routes = [
    GetPage(
      name: '/login',
      page: () => LoginScreen(),
      arguments: Get.arguments,
    ),
    GetPage(
      name: '/home',
      page: () => HomeScreen(),
      arguments: Get.arguments,
    ),
  ];
}