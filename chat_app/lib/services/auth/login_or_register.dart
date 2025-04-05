import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // Variable to show the login screen
  bool showLogin = true;

  // Function to toggle between login and register screens
  void toggleView() {
    setState(() { // Update the state
      showLogin = !showLogin; // Toggle the value of showLogin
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build a widget that shows either the login or register screen based on showLogin
    if (showLogin) {
      // If showLogin is true, show the login screen
      return LoginPage(onTap: toggleView);
    } else {
      // If showLogin is false, show the register screen
      return RegisterPage(onPressed: toggleView);
    }
  }
}