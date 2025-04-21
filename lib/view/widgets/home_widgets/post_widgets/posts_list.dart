import 'package:a/view/widgets/home_widgets/post_widgets/post_actions.dart';
import 'package:a/view/widgets/home_widgets/post_widgets/post_content.dart';
import 'package:a/view/widgets/home_widgets/post_widgets/post_header.dart';
import 'package:a/view/widgets/home_widgets/post_widgets/post_video_player.dart';
import 'package:flutter/material.dart';
import '../../../../core/view_model/home_controller.dart';
import '../../../../models/post_model.dart';

class PostsList extends StatelessWidget {
  final HomeController controller;

  const PostsList({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        reverse: true,
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
                  child: Text.rich(TextSpan(children: [
                    TextSpan(text: "Crime Type: "),
                    TextSpan(
                        text: post.crimeType,
                        style: TextStyle(color: Colors.red))
                  ])),
                ),
                const SizedBox(height: 20),
                PostContent(post: post),
                const SizedBox(height: 20),
                _buildPostMedia(post),
                PostActions(post: post),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPostMedia(PostModel post) {
    final mediaUrl = post.postPic;

    if (mediaUrl == null || mediaUrl.isEmpty) {
      return const SizedBox.shrink();
    }

    final isVideo = mediaUrl.toLowerCase().endsWith('.mp4') || mediaUrl.toLowerCase().endsWith('.mov');

    if (isVideo) {
      return PostVideoPlayer(videoUrl: mediaUrl);
    } else {
      return _buildImage(mediaUrl);
    }
  }

  Widget _buildImage(String imageUrl) {
    return Container(
      width: double.infinity,
      height: 208,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}



