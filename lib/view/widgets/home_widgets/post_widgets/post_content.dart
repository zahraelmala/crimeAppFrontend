import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import '../../../../models/post_model.dart';

class PostContent extends StatelessWidget {
  final PostModel post;
  const PostContent({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: ReadMoreText(
        post.caption,
        style: TextStyle(
          fontWeight: FontWeight.bold
        ),
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
}
