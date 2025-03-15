import 'package:flutter/material.dart';
import 'home_screen.dart';

class CrimeReportScreen extends StatefulWidget {
  @override
  _CrimeReportScreenState createState() => _CrimeReportScreenState();
}

class _CrimeReportScreenState extends State<CrimeReportScreen> {
  bool isAnonymous = true;
  bool isReportSelected = true;
  int _selectedIndex = 0; // ✅ Track selected bottom nav item
  TextEditingController nameController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // TODO: Add navigation logic based on index
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 100,
        title: Center(
          child: Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(vertical: 10),
            child: ToggleButtons(
              constraints: BoxConstraints(minHeight: 40, minWidth: 120),
              borderColor: Colors.red,
              selectedBorderColor: Colors.red,
              fillColor: Colors.red,
              selectedColor: Colors.white,
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("Report"),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("Post"),
                ),
              ],
              isSelected: [isReportSelected, !isReportSelected],
              onPressed: (index) {
                setState(() {
                  isReportSelected = index == 0;
                });
              },
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: ListView(
                children: [
                  TextField(
                    controller: notesController,
                    decoration: InputDecoration(
                      hintText: "Add notes",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: EdgeInsets.all(16),
                    ),
                    maxLines: 4,
                  ),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      Icon(Icons.camera_alt, color: Colors.red, size: 28),
                      SizedBox(width: 10),
                      Text("Add photos / video", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 24),
                  ToggleButtons(
                    constraints: BoxConstraints(minHeight: 45, minWidth: 140),
                    borderColor: Colors.red,
                    selectedBorderColor: Colors.red,
                    fillColor: Colors.red,
                    selectedColor: Colors.white,
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                    children: [
                      Text("Anonymous"),
                      Text("Your Name"),
                    ],
                    isSelected: [isAnonymous, !isAnonymous],
                    onPressed: (index) {
                      setState(() {
                        isAnonymous = index == 0;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  if (!isAnonymous)
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: "Enter your name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  SizedBox(height: 32),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text("Submit",
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex, // ✅ Highlight selected item
        onTap: _onItemTapped, // ✅ Handle item tap
        type: BottomNavigationBarType.fixed, // ✅ Prevents shifting behavior
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: "Location"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
