import 'package:flutter/material.dart';



class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/profile.jpg"), // Replace with network image if needed
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
                buildMenuItem(Icons.person, "Your profile"),
                buildMenuItem(Icons.post_add, "Your posts"),
                buildMenuItem(Icons.receipt, "Your Report"),
                buildMenuItem(Icons.settings, "Settings"),
                buildMenuItem(Icons.help, "Help Center"),
                buildMenuItem(Icons.logout, "Log out", isLogout: true),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: "Location"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget buildMenuItem(IconData icon, String text, {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : Colors.black),
      title: Text(text, style: TextStyle(color: isLogout ? Colors.red : Colors.black)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () {},
    );
  }
}