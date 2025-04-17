import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: <Widget>[
          SizedBox(height: screenHeight * 0.02),
          ListTile(
            leading: const Icon(Icons.home,size: 30),
            title: Text("Types of crimes "),
            onTap: () {

            },
          ),
          ListTile(
            leading: const Icon(Icons.change_circle,size: 30,),
            title: Text("v"),
            onTap: () {
              // Navigate to the settings screen or perform an action

            },
          ),
          ListTile(
            leading: const Icon(Icons.games,size: 30,),
            title: Text('2'),
            onTap: () {
              // Navigate to the settings screen or perform an action

            },
          ),
          ListTile(
            leading: const Icon(Icons.info,size: 30),
            title: Text('3'),
            onTap: () {
              // Navigate to the settings screen or perform an action

            },
          ),
        ],
      ),
    );
  }
}