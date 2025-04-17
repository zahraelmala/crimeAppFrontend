import 'package:a/models/created_by_model.dart';

class CommentModel {
  final int postId;
  final String text;
  final CreatedByModel commentedBy;

  CommentModel({
    required this.postId,
    required this.text,
    required this.commentedBy,
  });

  factory CommentModel.fromMap(Map<String, dynamic> json) {
    return CommentModel(
      postId: json["post"],
      text: json["text"],
      commentedBy: CreatedByModel.fromMap(json["commented_by"]),
    );
  }

  Map<String,dynamic> toJson(){
    return <String,dynamic>{
      "post": postId,
      "commented_by": commentedBy.toJson(),
      "text": text,
    };
  }

}
