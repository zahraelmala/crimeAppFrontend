import 'package:flutter/material.dart';

class StatisticalAnalysisScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Statistical Analysis',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Image.asset(
          'assets/images/statistical.png', // Ensure the image is in the assets folder
          fit: BoxFit.contain,
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}