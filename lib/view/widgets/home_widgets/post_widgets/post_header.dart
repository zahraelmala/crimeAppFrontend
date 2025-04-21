import 'package:flutter/material.dart';

import '../../../../constant/date_formatter.dart';
import '../../../../models/post_model.dart';

class PostHeader extends StatelessWidget {
  final PostModel post;
  const PostHeader({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: post.profilePic.isNotEmpty
                ? NetworkImage(post.profilePic)
                : const AssetImage("assets/images/profile_icon.png")
            as ImageProvider,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.username,
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
                      post.location!,
                      style: const TextStyle(fontSize: 15, color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            DateFormatter.getSuitableDateString(post.createdAt!, true),
            style: const TextStyle(fontSize: 12, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
