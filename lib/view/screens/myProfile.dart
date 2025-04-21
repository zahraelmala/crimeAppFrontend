import 'package:a/constant/custom_button.dart';
import 'package:a/core/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/enums.dart';
import '../../core/view_model/profile_controller.dart';
import 'editProfile.dart';
import 'helpcenter.dart';
import 'setting_screen.dart';
import 'your_posts_screen.dart';
import 'your_report_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final controller = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.fetchUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.getUserDate == FutureState.loading) {
        return const Center(
            child: CircularProgressIndicator(
          color: Colors.red,
        ));
      } else if (controller.getUserDate == FutureState.failed) {
        return const Center(child: Text('Failed to fetch user data'));
      }
      return Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: controller.profileImageUrl.value.isNotEmpty
                      ? NetworkImage(controller.profileImageUrl.value)
                      : const AssetImage("assets/images/profile_icon.png")
                          as ImageProvider,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.red,
                    child: InkWell(
                        onTap: controller.pickImage,
                        child: Icon(Icons.edit, color: Colors.white, size: 15)),
                  ),
                ),
              ],
            ),
          ),
          if (controller.image.value != null) ...[
            const SizedBox(height: 10),
            CustomButton(
              onTap: () async {
                String? uploadedImageUrl;
                if (controller.image.value != null) {
                  uploadedImageUrl = await controller.uploadImage();
                }
                await controller.updateUserField(
                    "profilePic", uploadedImageUrl);
                controller.image.value = null;
              },
              label: "Change Photo",
              buttonColor: Colors.red,
              textColor: Colors.white,
            ),
          ],
          const SizedBox(height: 10),
          Text(
            controller.userName.value,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          Text(
            controller.userEmail.value,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                buildMenuItem(
                    context, Icons.person, "Your Profile", EditProfilePage()),
                buildMenuItem(
                    context, Icons.post_add, "Your Posts", YourPostsScreen()),
                buildMenuItem(
                    context, Icons.receipt, "Your Report", YourReportsScreen()),
                buildMenuItem(
                    context, Icons.settings, "Settings", SettingsScreen()),
                buildMenuItem(
                    context, Icons.help, "Help Center", HelpCenterScreen()),
                buildMenuItem(context, Icons.logout, "Log out", null,
                    isLogout: true),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget buildMenuItem(
      BuildContext context, IconData icon, String text, Widget? page,
      {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : Colors.black),
      title: Text(text,
          style: TextStyle(color: isLogout ? Colors.red : Colors.black)),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () async {
        if (isLogout) {
          await Get.find<FirebaseAuthService>().signOut();
          Navigator.pushNamedAndRemoveUntil(
              context, '/login', (route) => false);
        } else if (page != null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => page));
        }
      },
    );
  }
}
