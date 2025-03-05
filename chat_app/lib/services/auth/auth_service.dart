import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService extends ChangeNotifier {
  // Autenticación
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //cloud firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign user in
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try { //sing in
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      //documentacion por si no la tiene al momento de hacer sign in
      _firestore.collection('users').doc(userCredential.user!.uid).set({  //23:16
        'uid': userCredential.user!.uid,
        'email': email,
      },SetOptions(merge: true));
      return userCredential;
      //errors
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
    //crear nuevo usuario
  Future<UserCredential>signUpWithEmailandPassword(String email,password ) async{
    try{
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      //crear documentacion
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      }

      );
      
      return userCredential;

    } on FirebaseAuthException catch (e) {
      throw Exception (e.code);
    }
  }
  // Sign out
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}