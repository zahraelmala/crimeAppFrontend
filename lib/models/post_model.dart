import 'package:a/models/created_by_model.dart';

class PostModel {
  final int postId;
  final String caption;
  final CreatedByModel createdBy;
  final String createdAt;
  final String updatedAt;
  final String postPic;
  final int likes;

  PostModel({
    required this.postId,
    required this.caption,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.postPic,
    required this.likes,
  });

  factory PostModel.fromMap(Map<String, dynamic> json) {
    print(json);
    return PostModel(
      postId: json["post_id"],
      caption: json["caption"],
      createdBy: CreatedByModel.fromMap(json["created_by"]),
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      postPic: json["post_pic"],
      likes: json["likes"],
    );
  }

  Map<String,dynamic> toJson(){
    return <String,dynamic>{
        "caption": caption,
        "created_by": createdBy.toJson(),
        "post_pic": postPic,
        "likes": likes
    };
  }

}
