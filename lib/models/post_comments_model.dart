import 'package:a/models/comment_model.dart';
import 'package:a/models/post_model.dart';

class PostCommentsModel {
  final PostModel post;
  final List<CommentModel> comments;

  PostCommentsModel({
    required this.post,
    required this.comments,
  });

  factory PostCommentsModel.fromMap(Map<String, dynamic> json) {
    return PostCommentsModel(
      post: PostModel.fromCommentMap(json["post"]),
      comments: (json["comments"] as List)
          .map((comment) => CommentModel.fromMap(comment))
          .toList(),
    );
  }
}
