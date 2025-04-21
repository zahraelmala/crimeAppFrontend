class CommentModel {
  final int commentId;
  final int postId;
  final String text;
  final String firebaseUid;
  final String createdAt;
  final String updatedAt;

  CommentModel({
    required this.postId,
    required this.commentId,
    required this.text,
    required this.firebaseUid,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CommentModel.fromMap(Map<String, dynamic> json) {
    return CommentModel(
      commentId: json["comment_id"],
      postId: json["post"],
      text: json["text"],
      firebaseUid: json["firebase_uid"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
    );
  }

  Map<String,dynamic> toJson(){
    return <String,dynamic>{
      "post": postId,
      "firebase_uid": firebaseUid,
      "text": text,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}
