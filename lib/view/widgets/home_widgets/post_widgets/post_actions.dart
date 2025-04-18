import 'package:flutter/material.dart';

import '../../../../models/post_model.dart';

class PostActions extends StatelessWidget {
  final PostModel post;
  const PostActions({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
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
                  color: Colors.black,
                ),
              ),
              TextButton.icon(
                icon: Icon(
                  Icons.thumb_up,
                  color: Colors.black,
                ),
                label: Text(
                  "Like",
                  style: TextStyle(
                    color: Colors.black,
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
}
