import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String id;
  String email;
  String message;

  Message({this.id, this.email, this.message});

  factory Message.fromData(DocumentSnapshot snapshot) {
    return Message(
      id: snapshot.id,
      email: snapshot["email"],
      message: snapshot["message"],
    );
  }
}
