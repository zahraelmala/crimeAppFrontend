
class PostModel {
  final int? postId;
  final String caption;
  final String? location;
  final String? crimeTime;
  final String? crimeType;
  final String username;
  final String profilePic;
  final String? createdAt;
  final String? updatedAt;
  final String postPic;
  final List<dynamic>? likes;

  PostModel({
    this.postId,
    required this.caption,
    this.location,
    this.crimeTime,
    this.crimeType,
    required this.username,
    required this.profilePic,
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
      username: json["username"],
      profilePic: json["profile_pic"],
      postPic: json["post_pic"],
      likes: json["likes"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
    );
  }

  factory PostModel.fromCommentMap(Map<String, dynamic> json) {
    return PostModel(
      postId: json["post_id"],
      caption: json["caption"],
      likes: json["likes"],
      username: json["username"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      location: json["location"],
      profilePic: json["profile_pic"],
      postPic: json["post_pic"],
    );
  }

  Map<String,dynamic> toJson(){
    return <String,dynamic>{
        "caption": caption,
        "location": location,
        "crimeTime": crimeTime,
        "crimeType": crimeType,
        "username": username,
        "profile_pic": profilePic,
        "post_pic": postPic,
    };
  }

}
