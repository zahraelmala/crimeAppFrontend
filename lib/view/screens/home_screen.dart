import 'package:a/constant/date_formatter.dart';
import 'package:a/core/core/view_model/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import '../../models/post_model.dart';
import 'Crimepost.dart';
import 'MappingPage.dart';
import 'myProfile.dart';
import 'typesCrimes.dart';
import 'emergencyService.dart';
import 'statistical_analysis.dart';
import 'police.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  List<bool> likedPosts = List.generate(10, (index) => false);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      print("start home run");
      await homeController.getAllPosts();
    });
  }

  // Drawer selection states
  bool _homeSelected = true;
  bool _typesOfCrimesSelected = false;
  bool _emergencySelected = false;
  bool _mappingSelected = false;
  bool _statSelected = false;
  bool _policeSelected = false;

  final List<Map<String, String>> posts = List.generate(
    10,
        (index) => {
      'name': 'Rodina Ahmed',
      'location': 'Sidi Gaber - Alexandria',
      'time': '5 min ago',
      'image': 'assets/images/a.png',
    },
  ) + List.generate(
    10,
        (index) => {
      'name': 'Zahra Elmalah',
      'location': 'Smouha - Alexandria',
      'time': '5 min ago',
      'image': 'assets/images/a.png',
    },
  );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _updateDrawerSelections(index);
    });
    _pageController.jumpToPage(index);
  }

  void _updateDrawerSelections(int index) {
    setState(() {
      _homeSelected = index == 0;
      _typesOfCrimesSelected = false;
      _emergencySelected = false;
      _mappingSelected = index == 2;
      _statSelected = false;
      _policeSelected = false;
    });
  }

  Future<void> _navigateFromDrawer(int index) async {
    // First close the drawer
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      Navigator.of(context).pop();
    }

    // Small delay to ensure drawer closes
    await Future.delayed(const Duration(milliseconds: 50));

    setState(() {
      // Reset all selections
      _homeSelected = false;
      _typesOfCrimesSelected = false;
      _emergencySelected = false;
      _mappingSelected = false;
      _statSelected = false;
      _policeSelected = false;
    });

    switch (index) {
      case 0: // Home
        setState(() {
          _homeSelected = true;
          _selectedIndex = 0;
        });
        _pageController.jumpToPage(0);
        break;
      case 1: // Types of crimes
        setState(() => _typesOfCrimesSelected = true);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CrimeListScreen()),
        );
        break;
      case 2: // Emergency service
        setState(() => _emergencySelected = true);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EmergencyServicePage()),
        );
        break;
      case 3: // Mapping
        setState(() {
          _mappingSelected = true;
          _selectedIndex = 2;
        });
        _pageController.jumpToPage(2);
        break;
      case 4: // Statistical analysis
        setState(() => _statSelected = true);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StatisticalAnalysisScreen()),
        );
        break;
      case 5: // Police station
        setState(() => _policeSelected = true);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PoliceStationLocationScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey, // Add scaffold key here
      drawer: _buildDrawer(screenWidth),
      appBar: _selectedIndex == 0 ? _buildAppBar() : null,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
            _updateDrawerSelections(index);
          });
        },
        children: [
          // Home Page
          _buildHomePage(),

          // Crime Post Page
          Scaffold(
            appBar: AppBar(
              title: const Text('Report Crime'),
              backgroundColor: Colors.red,
            ),
            body: CrimeReportScreen(),
          ),

          // Mapping Page
          Scaffold(
            appBar: AppBar(
              title: const Text('Crime Map'),
              backgroundColor: Colors.red,
            ),
            body: const MappingPage(),
          ),

          // Profile Page
          Scaffold(
            appBar: AppBar(
              title: const Text('My Profile'),
              backgroundColor: Colors.red,
            ),
            body: ProfilePage(),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildDrawer(double screenWidth) {
    return Drawer(
      width: screenWidth * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile section
          Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 20, right: 20),
            child: Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red, width: 5),
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      image: AssetImage('assets/images/Ellipse.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rodina Ahmed",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 17,
                      ),
                    ),
                    Text("RodinaAhmed@gmail.com"),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Divider(thickness: 1, color: Colors.black),

          // Drawer items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const SizedBox(height: 20),
                _buildDrawerItem(
                  icon: Icons.home,
                  text: "Home",
                  isSelected: _homeSelected,
                  onTap: () => _navigateFromDrawer(0),
                ),
                const SizedBox(height: 20),
                _buildDrawerItem(
                  icon: Icons.list,
                  text: "Types of crimes",
                  isSelected: _typesOfCrimesSelected,
                  onTap: () => _navigateFromDrawer(1),
                ),
                const SizedBox(height: 20),
                _buildDrawerItem(
                  icon: Icons.emergency,
                  text: "Emergency service",
                  isSelected: _emergencySelected,
                  onTap: () => _navigateFromDrawer(2),
                ),
                const SizedBox(height: 20),
                _buildDrawerItem(
                  icon: Icons.map,
                  text: "Mapping",
                  isSelected: _mappingSelected,
                  onTap: () => _navigateFromDrawer(3),
                ),
                const SizedBox(height: 20),
                _buildDrawerItem(
                  icon: Icons.analytics,
                  text: "Statistical analysis",
                  isSelected: _statSelected,
                  onTap: () => _navigateFromDrawer(4),
                ),
                const SizedBox(height: 20),
                _buildDrawerItem(
                  icon: Icons.local_police,
                  text: "Police station",
                  isSelected: _policeSelected,
                  onTap: () => _navigateFromDrawer(5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.red : Colors.grey),
      title: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.red : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      tileColor: isSelected ? Colors.red.withOpacity(0.1) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onTap: onTap,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: SvgPicture.asset(
        "assets/images/logo.svg",
        semanticsLabel: "logo",
        width: 250,
      ),
      backgroundColor: Colors.white,
      actions: [
        IconButton(
          icon: const ImageIcon(
            AssetImage("assets/images/menu_icon.png"),
            color: Colors.red,
            size: 35,
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildHomePage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildSearchField(),
          const SizedBox(height: 30),
          _buildPostsList(),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: const Icon(Icons.search, color: Colors.red),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.red),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }

  Widget _buildPostsList() {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Expanded(
          child: ListView.builder(
            itemCount: controller.data.length,
            itemBuilder: (context, index) {
              final post = controller.data[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Column(
                  children: [
                    _buildPostHeader(post),
                    const SizedBox(height: 20),
                    _buildPostContent(post),
                    const SizedBox(height: 5),
                    _buildPostImage(post),
                    _buildPostActions(post),
                  ],
                ),
              );
            },
          ),
        );
      }
    );
  }

  Widget _buildPostHeader(PostModel post) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(post.createdBy.profilePic),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.createdBy.username,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.red, size: 15),
                    const SizedBox(width: 4),
                    Text(
                      "Sidi Gaber - Alexandria",
                      style: const TextStyle(fontSize: 15, color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            DateFormatter.getSuitableDateString(post.createdAt, true),
            style: const TextStyle(fontSize: 12, color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildPostContent(PostModel post) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: ReadMoreText(
        post.caption,
        trimMode: TrimMode.Line,
        lessStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
        trimLines: 2,
        colorClickableText: Colors.pink,
        trimCollapsedText: 'Show more',
        trimExpandedText: 'Show less',
        moreStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
    );
  }

  Widget _buildPostImage(PostModel post) {
    return Container(
      width: double.infinity,
      height: 208,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(post.postPic),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildPostActions(PostModel post) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Text(
                post.likes.toString(),
                style: TextStyle(
                  color:  Colors.black,
                ),
              ),
              TextButton.icon(
                icon: Icon(
                  Icons.thumb_up,
                  color:  Colors.black,
                ),
                label: Text(
                  "Like",
                  style: TextStyle(
                    color:  Colors.black,
                  ),
                ),
                onPressed: () {
                  // setState(() {
                  //   likedPosts[index] = !likedPosts[index];
                  // });
                },
              ),
            ],
          ),
          TextButton.icon(
            icon: const ImageIcon(
              AssetImage("assets/images/comment_icon.png"),
              color: Colors.black,
            ),
            label: const Text(
              "Comment",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              // Handle comment action
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.red,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.white,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Add',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on),
          label: 'Location',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}