import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../api/Data_save.dart';
import 'message.dart';


class ChatServices extends ChangeNotifier {
  final FirebaseFirestore _firebaseStorage = FirebaseFirestore.instance;

  Future<void> sendMessage(
      {required String receiverId, required String messeage}) async {
    final String currentUserId = getData.read("AdminLogin")["id"];
    final String currentUserName = getData.read("AdminLogin")["username"];
    Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
        senderId: currentUserId,
        senderName: currentUserName,
        reciverId: receiverId,
        message: messeage,
        timestamp: timestamp);

    List<String> ids = [currentUserId, receiverId];
    ids.sort();

    String chatRoomId = ids.join("_");

    await _firebaseStorage
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("message")
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessage(
      {required String userId, required String otherUserId}) {
    List ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firebaseStorage
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("message")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
