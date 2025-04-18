import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmergencyServicePage extends StatefulWidget {
  const EmergencyServicePage({super.key});

  @override
  EmergencyServicePageState createState() => EmergencyServicePageState();
}

class EmergencyServicePageState extends State<EmergencyServicePage> {
  bool emergencyServiceEnabled = true;
  bool doubleClickEnabled = false;
  bool sendMessageEnabled = true;
  bool callListEnabled = false;
  bool actionExpanded = false;
  bool emergencyListExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Emergency service"),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSwitchTile("Emergency service", emergencyServiceEnabled, (value) {
              setState(() {
                emergencyServiceEnabled = value;
                if (!emergencyServiceEnabled) {
                  actionExpanded = false;
                  emergencyListExpanded = false;
                  doubleClickEnabled = false;
                  sendMessageEnabled = false;
                  callListEnabled = false;
                }
              });
            }),
            if (emergencyServiceEnabled) ...[
              Divider(),
              _buildExpandableSection("action", actionExpanded, () {
                setState(() {
                  actionExpanded = !actionExpanded;
                });
              }),
              if (actionExpanded) ...[
                _buildSwitchTile("double click on power button", doubleClickEnabled, (value) {
                  setState(() {
                    doubleClickEnabled = value;
                  });
                }),
              ],
              Divider(),
              _buildExpandableSection("emergency list", emergencyListExpanded, () {
                setState(() {
                  emergencyListExpanded = !emergencyListExpanded;
                });
              }),
              if (emergencyListExpanded) ...[
                _buildSwitchTile("send message", sendMessageEnabled, (value) {
                  setState(() {
                    sendMessageEnabled = value;
                    if (sendMessageEnabled) callListEnabled = false;
                  });
                }),
                _buildSwitchTile("send Email", callListEnabled, (value) {
                  setState(() {
                    callListEnabled = value;
                    if (callListEnabled) sendMessageEnabled = false;
                  });
                }),
              ],
              Divider(),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.add_circle_outline, color: Colors.black),
                label: Text("add people", style: TextStyle(color: Colors.black)),
              )
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.green,
    );
  }

  Widget _buildExpandableSection(String title, bool expanded, VoidCallback onTap) {
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      trailing: Icon(expanded ? Icons.expand_less : Icons.expand_more),
      onTap: onTap,
    );
  }
}