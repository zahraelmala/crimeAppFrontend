import 'package:a/view/screens/setting_screen.dart';
import 'package:a/view/screens/your_posts_screen.dart';
import 'package:a/view/screens/your_report_screen.dart';
import 'package:flutter/material.dart';
import 'editProfile.dart';
import 'helpcenter.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Center(
          child: Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/profile.jpg"),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.red,
                  child: Icon(Icons.edit, color: Colors.white, size: 15),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Text("Rodina Ahmed", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red)),
        Text("Rodinaahmed851@gamil.com", style: TextStyle(color: Colors.grey)),
        SizedBox(height: 20),
        Expanded(
          child: ListView(
            children: [
              buildMenuItem(context, Icons.person, "Your Profile", EditProfilePage()),
              buildMenuItem(context, Icons.post_add, "Your Posts", YourPostsScreen()),
              buildMenuItem(context, Icons.receipt, "Your Report", YourReportsScreen()),
              buildMenuItem(context, Icons.settings, "Settings", SettingsScreen()),
              buildMenuItem(context, Icons.help, "Help Center", HelpCenterScreen()),
              buildMenuItem(context, Icons.logout, "Log out", null, isLogout: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildMenuItem(BuildContext context, IconData icon, String text, Widget? page, {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : Colors.black),
      title: Text(text, style: TextStyle(color: isLogout ? Colors.red : Colors.black)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () {
        if (isLogout) {
          // Handle logout logic here
          print("User Logged Out");  // Replace with logout functionality
        } else if (page != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => page));
        }
      },
    );
  }
}
