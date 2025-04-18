import 'package:a/models/created_by_model.dart';

class PostModel {
  final int? postId;
  final String caption;
  final String location;
  final String crimeTime;
  final String crimeType;
  final CreatedByModel createdBy;
  final String? createdAt;
  final String? updatedAt;
  final String postPic;
  final int? likes;

  PostModel({
    this.postId,
    required this.caption,
    required this.location,
    required this.crimeTime,
    required this.crimeType,
    required this.createdBy,
    this.createdAt,
    this.updatedAt,
    required this.postPic,
    this.likes,
  });

  factory PostModel.fromMap(Map<String, dynamic> json) {
    return PostModel(
      postId: json["post_id"],
      caption: json["caption"],
      location: json["location"],
      crimeTime: json["crimeTime"],
      crimeType: json["crimeType"],
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
        "location": location,
        "crimeTime": crimeTime,
        "crimeType": crimeType,
        "created_by": createdBy.toJson(),
        "post_pic": postPic,
    };
  }

}
