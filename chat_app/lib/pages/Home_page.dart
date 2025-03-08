import 'package:chat_app/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signOut() { // sign out method
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [IconButton(onPressed: signOut, icon: const Icon(Icons.logout))], // sign out button
      ),
      body: _buildUserList(),
    );
  }

  // lista de usuarios
  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading');
        }
        return ListView(
          children: snapshot.data!.docs.map<Widget>((doc) => _buildUserListItem(doc)).toList(),
        );
      },
    );
  }

  // creamos la lista individual de usuarios
  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    // mostrar usuarios menos el activo
    if (_auth.currentUser?.uid != data['email']) {
      return ListTile(
        title: Text(data['email']),
        onTap:(){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => ChatPage(
                  receiverUserEmail: data['email'],receiverUserID: data['uid'],)));
        } , //para pasarlo al chat con el usuario seleccionado
      );
    } else {
      return Container(); // return an empty container for the active user
    }
  }
}