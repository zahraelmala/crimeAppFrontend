import 'package:flutter/material.dart';

class YourReportsScreen extends StatefulWidget {
  @override
  _YourReportsScreenState createState() => _YourReportsScreenState();
}

class _YourReportsScreenState extends State<YourReportsScreen> {
  List<int> reports = List.generate(20, (index) => index);

  void deleteReport(int index) {
    setState(() {
      reports.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red, size: 18),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Your reports', style: TextStyle(color: Colors.black, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: reports.length,
        itemBuilder: (context, index) => ReportCard(
          index: reports[index],
          onDelete: () => deleteReport(index),
        ),
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  final int index;
  final VoidCallback onDelete;

  const ReportCard({Key? key, required this.index, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage('assets/avatar.png'),
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Rodina Ahmed', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.red, size: 14),
                          Text('Sidi Gaber - Alexandria', style: TextStyle(color: Colors.red, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.remove_red_eye, color: Colors.grey, size: 16),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red, size: 16),
                    onPressed: onDelete,
                  ),
                  SizedBox(width: 8),
                  Text('${10 + index} Oct 2024', style: TextStyle(color: Colors.red, fontSize: 10)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  'Lorem ipsum dolor sit amet consectetur. Amet purus tristique libero in fames fermentum a arcu at. Dolor scelerisque see more',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
