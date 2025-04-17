import 'package:a/view/screens/password_manager.dart';
import 'package:flutter/material.dart';

import 'notification_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
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
          _buildSettingItem(context, 'Delete account', Icons.delete, Colors.red, Container()),
        ],
      ),
    );
  }

  Widget _buildSettingItem(BuildContext context, String title, IconData icon, Color iconColor, Widget screen) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward, color: Colors.red),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen),
      ),
    );
  }
}
