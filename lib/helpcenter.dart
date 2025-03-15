import 'package:flutter/material.dart';

class HelpCenterScreen extends StatefulWidget {
  @override
  _HelpCenterScreenState createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  bool _showTypesOfCrimes = false;
  bool _showEmergencyServices = false;
  bool _showStatisticalAnalysis = false;
  bool _showMapping = false;
  bool _showPoliceStation = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'help center',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _buildExpandableItem('How-to-protect-yourself', [
            'Stay Aware: Be mindful of your surroundings and trust your instincts.',
            'Secure Home: Lock doors, use lights, and avoid oversharing on social media.',
            'Online Caution: Protect personal info, use strong passwords, and beware of scams.',
            'Travel Safely: Stick to well-lit areas, travel in groups, and carry safety tools like pepper spray.',
            'Vehicle Tips: Lock your car, hide valuables, and stay vigilant while driving.',
            'Emergency Prep: Save emergency numbers, use safety apps, and have an exit plan.',
            'Self-Defense: Take classes and learn basic techniques for personal protection.',
            'Community Awareness: Know local risks and avoid high-crime areas.',
          ], showArrows: false),
          Divider(),
          ExpansionTile(
            title: Text('Safety feature', style: TextStyle(fontWeight: FontWeight.bold)),
            children: [
              _buildExpandableListTile(
                title: 'Types of crimes',
                isExpanded: _showTypesOfCrimes,
                onTap: () {
                  setState(() {
                    _showTypesOfCrimes = !_showTypesOfCrimes;
                  });
                },
                highlightedText: 'Types of crimes',
              ),
              _buildExpandableListTile(
                title: 'Emergency services',
                isExpanded: _showEmergencyServices,
                onTap: () {
                  setState(() {
                    _showEmergencyServices = !_showEmergencyServices;
                  });
                },
                highlightedText: 'Emergency service',
              ),
              _buildExpandableListTile(
                title: 'Statistical analysis',
                isExpanded: _showStatisticalAnalysis,
                onTap: () {
                  setState(() {
                    _showStatisticalAnalysis = !_showStatisticalAnalysis;
                  });
                },
                highlightedText: 'Statistical analysis',
              ),
              _buildExpandableListTile(
                title: 'Mapping',
                isExpanded: _showMapping,
                onTap: () {
                  setState(() {
                    _showMapping = !_showMapping;
                  });
                },
                highlightedText: 'Mapping',
              ),
              _buildExpandableListTile(
                title: 'Police station',
                isExpanded: _showPoliceStation,
                onTap: () {
                  setState(() {
                    _showPoliceStation = !_showPoliceStation;
                  });
                },
                highlightedText: 'Police station',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableItem(String title, List<String> subItems, {bool showArrows = true}) {
    return ExpansionTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      children: subItems
          .map((subItem) => ListTile(
        title: Text(subItem),
        trailing: showArrows ? Icon(Icons.arrow_forward_ios, color: Colors.red, size: 16) : null,
      ))
          .toList(),
    );
  }

  Widget _buildExpandableListTile({
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
    required String highlightedText,
  }) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
                Icon(
                  isExpanded ? Icons.expand_less : Icons.arrow_forward_ios,
                  color: Colors.red,
                  size: 16,
                ),
              ],
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                  children: [
                    TextSpan(text: 'Go to ', style: TextStyle(fontWeight: FontWeight.normal)),
                    TextSpan(text: 'Home page, More button, ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: highlightedText, style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}


