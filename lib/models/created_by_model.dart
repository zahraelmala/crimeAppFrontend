class CreatedByModel {
  final int userID;
  final String username;
  final String profilePic;

  CreatedByModel({
    required this.userID,
    required this.username,
    required this.profilePic,
  });

  factory CreatedByModel.fromMap(Map<String, dynamic> json) {
    return CreatedByModel(
      userID: json["id"],
      username: json["username"],
      profilePic: json["profile_pic"],
    );
  }

  Map<String,dynamic> toJson(){
    return <String,dynamic>{
      "id" : userID,
      "username" : username,
      "profile_pic" : profilePic,
    };
  }

}
