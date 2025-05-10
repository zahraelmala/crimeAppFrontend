import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../core/view_model/main_controller.dart';
import '../widgets/drawer_menu/drawer_widget.dart';
import 'crime_report_screen.dart';
import 'MappingPage.dart';
import 'home_screen.dart';
import 'myProfile.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final controller = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Obx(() {
      return Scaffold(
        key: controller.scaffoldKey,
        drawer: DrawerWidget(
          screenWidth: screenWidth,
        ),
        appBar: _buildAppBar(controller.currentTitle),
        body: PageView(
          controller: controller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: controller.onPageChanged,
          children: [
            HomeScreen(),
            CrimeReportScreen(),
            MappingPage(),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
      );
    });
  }

  AppBar _buildAppBar(String title) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      title: Row(
        children: [
          if (controller.selectedIndex.value == 0)
            SvgPicture.asset(
              "assets/images/logo.svg",
              semanticsLabel: "logo",
              width: 150,
            )
          else
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
        ],
      ),
      actions: [
        IconButton(
          icon: const ImageIcon(
            AssetImage("assets/images/menu_icon.png"),
            color: Colors.red,
            size: 35,
          ),
          onPressed: controller.openDrawer,
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Obx(() {
      return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.red,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        currentIndex: controller.selectedIndex.value,
        onTap: controller.onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Location',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      );
    });
  }
}
