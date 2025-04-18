import 'package:a/view/widgets/home_widgets/post_widgets/post_actions.dart';
import 'package:a/view/widgets/home_widgets/post_widgets/post_content.dart';
import 'package:a/view/widgets/home_widgets/post_widgets/post_header.dart';
import 'package:flutter/material.dart';

import '../../../../core/view_model/home_controller.dart';
import '../../../../models/post_model.dart';

class PostsList extends StatelessWidget {
  final HomeController controller;
  const PostsList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: controller.filteredData.length,
        itemBuilder: (context, index) {
          final post = controller.filteredData[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PostHeader(post: post),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Crime Time: ${post.crimeTime}"),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Crime Type: "
                        ),
                        TextSpan(
                          text: post.crimeType,
                          style: TextStyle(color: Colors.red)
                        )
                      ]
                    )
                  ),
                ),
                const SizedBox(height: 20),
                PostContent(post: post),
                const SizedBox(height: 20),
                _buildPostImage(post),
                PostActions(post: post),
              ],
            ),
          );
        },
      ),
    );
  }
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
