import 'package:a/view/screens/signup.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/onboarding1.png",
      "title": "Welcome To",
      "subtitle": "crime_catcher_logo", // Special case for image
      "description":
          "This app is designed to help the user report and stay informed about potential crimes and suspicious activities in their area."
    },
    {
      "image": "assets/images/onboarding2.png",
      "title": "Report Crimes Instantly.",
      "subtitle": "Stay Safe, Stay Secure",
      "description":
          "Your safety is our priority. Share details of crimes in just a few taps and help make your community safer."
    }
  ];

  void _skip() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: onboardingData.length,
            itemBuilder: (context, index) => OnboardingContent(
              image: onboardingData[index]["image"]!,
              title: onboardingData[index]["title"]!,
              subtitle: onboardingData[index]["subtitle"]!,
              description: onboardingData[index]["description"]!,
            ),
          ),
          // "Skip" Button at the Top Right (Hidden on Last Page)
          Positioned(
            top: 50,
            right: 20,
            child: _currentPage == onboardingData.length - 1
                ? SizedBox.shrink()
                : TextButton(
                    onPressed: _skip,
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ),
          // Page Indicator Dots
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  height: 8,
                  width: _currentPage == index ? 24 : 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? Colors.red : Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          // "Get Started" Button at Bottom Right (Shown Only on Last Page)
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            bottom: 30,
            right: 20,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: _currentPage == onboardingData.length - 1 ? 1.0 : 0.0,
              child: TextButton(
                onPressed: _skip,
                child: Text(
                  "Get started",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  final String image, title, subtitle, description;

  const OnboardingContent({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, width: 300, height: 300),
          SizedBox(height: 20),
          // Title
          Text(
            title,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          // Subtitle (If "crime_catcher_logo", show image instead)
          subtitle == "crime_catcher_logo"
              ? Image.asset(
                  'assets/images/crimecatcher.png', // Make sure this is correct
                  height: 30,
                )
              : Text(
                  subtitle,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
          SizedBox(height: 10),
          // Description
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
