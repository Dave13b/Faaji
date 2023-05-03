import 'package:uuid/uuid.dart';

class EventModel {
  String id;
  String email;
  EventModel({
    required this.id,
    required this.email,
  });
  factory EventModel.fromMap(Map map) {
    return EventModel(
      id: map["id"],
      email: map["email"],
    );
  }
  factory EventModel.fromEmail(email, {String? id}) {
    return EventModel(
      id: id ?? Uuid().v4(),
      email: email,
    );
  }

  Map toMap() {
    return {
      "id": id,
      "email": email,
    };
  }
}
