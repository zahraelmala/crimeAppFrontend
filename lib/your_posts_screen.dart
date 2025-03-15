import 'package:flutter/material.dart';
import 'post_card.dart';

class YourPostsScreen extends StatefulWidget {
  @override
  _YourPostsScreenState createState() => _YourPostsScreenState();
}

class _YourPostsScreenState extends State<YourPostsScreen> {
  List<int> posts = List.generate(20, (index) => index);

  void deletePost(int index) {
    setState(() {
      posts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: Text('Your posts', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) => PostCard(
          index: posts[index],
          onDelete: () => deletePost(index),
        ),
      ),
    );
  }
}
