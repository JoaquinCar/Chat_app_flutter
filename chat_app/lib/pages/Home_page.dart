import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Instance of FirebaseAuth to manage authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to sign out the user
  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    // Get the current user's email or display 'Unknown User' if not available
    final currentUserEmail = _auth.currentUser?.email ?? 'Unknown User';
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Home Page', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF))),
            Text(
              'Active User: $currentUserEmail',
              style: TextStyle(fontSize: 20, color: Color(0xFFB0B0C3)),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
            tooltip: 'Sign Out',
            color: Color(0xFFFFFFFF),
          ),
        ],
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFBDCED), Color(0xFFFBDCED)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: _buildUserList(),
      ),
    );
  }

  // Function to build the user list
  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>( // Listen to the Firestore collection 'users'
      stream: FirebaseFirestore.instance.collection('users').snapshots(), // Listen to the 'users' collection in Firestore
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading users', style: TextStyle(color: Color(0xFFFFFFFF))));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); // Show a loading indicator while waiting for data
        }
        return ListView(
          children: snapshot.data!.docs.map<Widget>((doc) => _buildUserListItem(doc)).toList(), // Convert the list of documents to a list of widgets
        );
      },
    );
  }

  // Function to build each user list item
  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>; // Cast the data to Map<String, dynamic>
//document is a DocumentSnapshot that contains the data of the user
    String name = data['name'] ?? 'Unknown User'; // Use a default value if 'name' is null

    if (_auth.currentUser?.uid != data['uid']) {
      return Card(
        color: Color(0xFFFF4F92),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: ListTile(
          title: Text(name, style: TextStyle(fontSize: 16, color: Color(0xFFFFFFFF))),
          trailing: Icon(Icons.chat, color: Color(0xFFF6DDEA)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  receiverUserEmail: data['email'] ?? 'Unknown Email', // Use the email from the document
                  receiverUserID: data['uid'],
                ),
              ),
            );
          },
        ),
      );
    } else {
      return Container();
    }
  }
}