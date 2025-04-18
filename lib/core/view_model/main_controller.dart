import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class MainController extends GetxController {
  final pageController = PageController(initialPage: 0);
  final selectedIndex = 0.obs;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final homeController = Get.put(HomeController());

  final appBarTitles = [
    'Home',
    'Report Crime',
    'Mapping',
    'My Profile',
  ];

  @override
  void onInit() {
    super.onInit();
    getInitialData();
  }

  Future<void> getInitialData() async {
    await homeController.getAllPosts();
    homeController.filteredData.value = homeController.data;
  }

  void onItemTapped(int index) {
    selectedIndex.value = index;
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    selectedIndex.value = index;
  }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  String get currentTitle => appBarTitles[selectedIndex.value];
}
