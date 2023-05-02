class SessionModel {
  int userId;
  String? email;
  SessionModel({
    required this.userId,
    required this.email,

  });
  factory SessionModel.fromMap(Map map){
    return SessionModel(userId: map["user_id"],
        email: map["user_info"]?["user_email"]);
  }
  Map toMap(){
    return {"user_id":userId,
      "user_info":{
      "user_email":email,
      }
    };
  }
}
