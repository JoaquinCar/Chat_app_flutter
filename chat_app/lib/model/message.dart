import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderID;
  final String senderEmail;
  final String receiverID;
  final String message;
  final Timestamp timestamp;
  final String currentUserName;

  Message(this.senderID, this.senderEmail, this.receiverID, this.message, this.timestamp, this.currentUserName);

  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'senderEmail': senderEmail,
      'receiverID': receiverID,
      'message': message,
      'timestamp': timestamp,
      'currentUserName': currentUserName,
    };
  }
}