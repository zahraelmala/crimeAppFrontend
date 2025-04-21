import 'package:get/get.dart';
import '../../view/screens/login_screen.dart';
import '../view/screens/main_screen.dart';

// Define the routes and corresponding pages for the application
abstract class AppRoutes {
  static final routes = [
    GetPage(
      name: '/login',
      page: () => LoginScreen(),
      arguments: Get.arguments,
    ),
    GetPage(
      name: '/MainScreen',
      page: () => MainScreen(),
      arguments: Get.arguments,
    ),
  ];
}