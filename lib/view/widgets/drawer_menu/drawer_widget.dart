import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/view_model/main_controller.dart';
import '../../../core/view_model/profile_controller.dart';
import '../../screens/emergencyService.dart';
import '../../screens/police.dart';
import '../../screens/statistical_analysis.dart';
import '../../screens/typesCrimes.dart';

class DrawerWidget extends StatefulWidget {
  final double screenWidth;

  const DrawerWidget({
    super.key,
    required this.screenWidth,
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final controller = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.fetchUserData();
    });
  }

  int selectedIndex = 0;

  void updateSelection(int index) {
    final mainController = Get.find<MainController>();
    setState(() {
      selectedIndex = index;
    });
    mainController.onItemTapped(index);
    Navigator.of(context).pop(); // Close drawer
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: widget.screenWidth * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 20, right: 20),
            child: Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red, width: 5),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: controller.profileImageUrl.value.isNotEmpty
                          ? NetworkImage(controller.profileImageUrl.value)
                          : const AssetImage("assets/images/profile_icon.png") as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.userName.value,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 17,
                      ),
                    ),
                    Text(controller.userEmail.value),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Divider(thickness: 1, color: Colors.black),
          // Drawer Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const SizedBox(height: 20),
                _buildDrawerItem(
                  icon: Icons.home,
                  text: "Home",
                  index: 0,
                  isMainScreen: true,
                ),
                const SizedBox(height: 20),
                _buildDrawerItem(
                  icon: Icons.list,
                  text: "Types of crimes",
                  index: 1,
                  isMainScreen: false,
                ),
                const SizedBox(height: 20),
                _buildDrawerItem(
                  icon: Icons.emergency,
                  text: "Emergency service",
                  index: 3,
                  isMainScreen: false,
                ),
                const SizedBox(height: 20),
                _buildDrawerItem(
                  icon: Icons.map,
                  text: "Mapping",
                  index: 2,
                  isMainScreen: true,
                ),
                const SizedBox(height: 20),
                _buildDrawerItem(
                  icon: Icons.analytics,
                  text: "Statistical analysis",
                  index: 4,
                  isMainScreen: false,
                ),
                const SizedBox(height: 20),
                _buildDrawerItem(
                  icon: Icons.local_police,
                  text: "Police station",
                  index: 5,
                  isMainScreen: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required int index,
    required bool isMainScreen,
  }) {
    final isSelected = selectedIndex == index;

    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.red : Colors.grey),
      title: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.red : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      tileColor: isSelected ? Colors.red.withValues(alpha: 0.1) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onTap: () {
        if (isMainScreen) {
          updateSelection(index);
        } else {
          Navigator.of(context).pop();
          _navigateToOtherScreen(index);
        }
      },
    );
  }

  void _navigateToOtherScreen(int index) {
    switch (index) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CrimeListScreen()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EmergencyServicePage()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StatisticalAnalysisScreen()),
        );
        break;
      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PoliceStationLocationScreen()),
        );
        break;
      default:
        break;
    }
  }
}
