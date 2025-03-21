import 'package:chat_app/Components/text_field.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;
  const ChatPage({super.key, required this.receiverUserEmail, required this.receiverUserID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final ScrollController _scrollController = ScrollController();

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text);
      _messageController.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverUserEmail,
          style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFFFF4F92),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFBEEFA), Color(0xFFFFE5F1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(child: _buildMessageList()),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
          widget.receiverUserID, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom()); //Scroll_to_the_bottom_of_the_list_when_a_new_message_is_added
        return ListView(
          controller: _scrollController,
          children: snapshot.data!.docs.map((document) => _buildMessageItem(document)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderID'] == _firebaseAuth.currentUser!.uid;

    var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    var color = Colors.white;
    var crossAxisAlignment = isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    return Align(
      alignment: alignment,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            if (!isCurrentUser)
              Text(
                data['senderName'] ?? '',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(18),
              child: Text(
                data['message'],
                style: TextStyle(color: Colors.black, fontSize: 18), // Set text color to black and increase font size
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            controller: _messageController,
            hintText: 'Enter message',
            obscureText: false,
            hintStyle: const TextStyle(color: Color(0xFF000000)),
            textStyle: const TextStyle(color: Color(0xFF333333)),
          ),
        ),
        IconButton(
          onPressed: sendMessage,
          icon: Icon(Icons.arrow_upward, size: 40),
        ),
      ],
    );
  }
}