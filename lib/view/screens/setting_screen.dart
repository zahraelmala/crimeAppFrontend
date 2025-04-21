import 'package:a/constant/common_dialogs.dart';
import 'package:a/core/view_model/profile_controller.dart';
import 'package:a/view/screens/password_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'notification_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Setting', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        children: [
          _buildSettingItem(context, 'Notification', Icons.notifications, Colors.red, NotificationScreen()),
          _buildSettingItem(context, 'Password Manager', Icons.lock, Colors.red, PasswordManagerPage()),
          _buildSettingItem(context, 'Delete account', Icons.delete, Colors.red, null),
        ],
      ),
    );
  }

  Widget _buildSettingItem(BuildContext context, String title, IconData icon, Color iconColor,[Widget? screen]) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return ListTile(
          leading: Icon(icon, color: iconColor),
          title: Text(title),
          trailing: Icon(Icons.arrow_forward, color: Colors.red),
          onTap: () {
            if(screen == null){
              CommonDialogs.showConfirmDelete(context, controller.userName.value);
            }else{
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => screen),
              );
            }
          }
        );
      }
    );
  }
}
