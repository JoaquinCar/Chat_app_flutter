import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Message {
  final String senderID;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timestamp;

  Message(this.senderID, this.senderEmail, this.receiverId, this.message, this.timestamp);

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderID,
      'senderEmail': senderEmail,
      'receiverID': receiverId,
      'message': message,
      'timestamp': timestamp,
    };
  }
}