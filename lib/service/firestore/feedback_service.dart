import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wallpaper_app_flutter/model/feedback/feed.dart';

class FeedbackService {
  final String collectionPath = "FeedbakQuestions";

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ///Todo Database add FeedBack message and email
  ///Service Firestore from database collections
  Future<void> addMeessageService(String email, String msg) async {
    var ref = _firestore.collection(collectionPath);

    var document = await ref.add({
      "email": email,
      "msg": msg,
    });

    return Message(
      id: document.id,
      email: email,
      message: msg,
    );
  }
}
