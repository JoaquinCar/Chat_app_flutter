// chat_app/lib/services/auth/auth_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService extends ChangeNotifier {
  // Autenticación
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance; // Firebase Auth

  // Cloud Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Firestore

  // Getter for current user
  User? get currentUser => _firebaseAuth.currentUser; // Current user getter for Firebase Auth

  // Sign user in
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      // Sign in
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      // Documentation in case it doesn't exist at the time of sign in
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      }, SetOptions(merge: true)); // Merge to avoid overwriting the document if it already exists
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Create new user
  Future<UserCredential> signUpWithEmailandPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      // Create documentation
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Sign out
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}