import 'package:chat_app/model/message.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class ChatService extends ChangeNotifier{
  //obtener autenticacion y la firestore para almacenar datos
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //mandar informacion
Future<void>sendMessage(String receiverId, String message)async{
  //obtener la informacion
  final String  currentUserId = _firebaseAuth.currentUser!.uid;
  final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
  final Timestamp timestamp = Timestamp.now();

  //crear el "mensaje"
  Message newMessage = Message(
    currentUserId,
    currentUserEmail,
    receiverId,
    message,
    timestamp,
  );
  //diseno de pagina para el chat
  List <String>ids = [currentUserId,receiverId];
  ids.sort(); //para asegurarnos que el chat siempre sea el mismo para las 2 personas
  String chatRoomId = ids.join("_"); //combinar los ids
  //almacenar los mensajes en la base de datos
  await _firestore.collection('chat_rooms').doc(chatRoomId).collection('messages').add(newMessage.toMap());

}

//recibir informacion

  Stream<QuerySnapshot>getMessages(String userId,String otherUserId) {
  List<String> ids = [userId,otherUserId];
  ids.sort();
  String chatRoomId = ids.join("_");
  return _firestore.collection('chat_rooms').doc(chatRoomId).collection('messages').orderBy('timestamp',descending: false).snapshots();
  }
}