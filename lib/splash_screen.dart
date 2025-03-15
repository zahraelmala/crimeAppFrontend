import 'package:flutter/material.dart';
import 'onboarding_screen.dart'; // Import HomeScreen

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    // Animation Controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Duration of slide effect
    )..forward();

    // Slide animation from bottom to normal position
    _animation = Tween<Offset>(
      begin: const Offset(0, 1), // Start off-screen at the bottom
      end: Offset.zero, // End at normal position
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Navigate to HomeScreen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color of the splash screen
      body: Center(
        child: SlideTransition(
          position: _animation,
          child: Image.asset('assets/images/splashScreen.png',
              width: 250, height: 250),
        ),
      ),
    );
  }
}
