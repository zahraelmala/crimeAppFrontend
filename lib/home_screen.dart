import 'package:flutter/material.dart';
import 'Menu.dart';
import 'menu_screen.dart'; // Import the menu screen


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Map<String, String>> posts = List.generate(10, (index) => {
    'name': 'Rodina Ahmed',
    'location': 'Sidi Gaber - Alexandria',
    'time': '5 min ago',
    'image': 'assets/images/a.png', // Replace with local asset image
  }) + List.generate(10, (index) => {
    'name': 'Zahra Elmalah',
    'location': 'Smouha - Alexandria',
    'time': '5 min ago',
    'image': 'assets/images/a.png', // Replace with local asset image
  });

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),

      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                size: 25,
                color: Colors.red,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Image.asset('assets/images/crimecatcher.png', height: 40), // Use local asset
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search, color: Colors.red),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.red),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(post['image']!), // Use local asset
                          ),
                          title: Text(post['name']!),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(post['location']!, style: TextStyle(color: Colors.red)),
                              Text(post['time']!, style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit...'),
                        SizedBox(height: 10),
                        Image.asset(post['image']!, fit: BoxFit.cover), // Use local asset
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: IconButton(
                                icon: Icon(Icons.thumb_up, color: Colors.blue),
                                onPressed: () {},
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                icon: Icon(Icons.comment, color: Colors.black),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'Location'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
