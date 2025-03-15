import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // This removes the default back button
        title: Row(
          children: [
            // Custom red circle with arrow (Back Button)
            GestureDetector(
              onTap: () {
                Navigator.pop(context); // Navigate back when tapped
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            // Expanded widget to push the "More" text to the center
            Expanded(
              child: Center(
                child: Text(
                  'More',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildListItem('Types of crimes'),
            _buildDivider(),
            _buildListItem('Emergency service'),
            _buildDivider(),
            _buildListItem('Mapping'),
            _buildDivider(),
            _buildListItem('Statistical analysis'),
            _buildDivider(),
            _buildListItem('Police station'),
          ],
        ),
      ),
    );
  }

  // Helper method to create list items
  Widget _buildListItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  // Helper method to create a grey divider
  Widget _buildDivider() {
    return Divider(
      color: Colors.grey,
      thickness: 1,
      height: 1,
    );
  }
}
