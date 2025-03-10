import 'package:chat_app/Components/text_field.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Components/button.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback onPressed;
  const RegisterPage({super.key, required this.onPressed});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  void signUp() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmpassword = confirmpasswordController.text.trim();
    final name = nameController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmpassword.isEmpty || name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all the fields")),
      );
    } else if (password != confirmpassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match! Try Again")),
      );
      return;
    }

    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signUpWithEmailandPassword(email, password);
      await FirebaseFirestore.instance.collection('users').doc(authService.currentUser!.uid).set({
        'uid': authService.currentUser!.uid,
        'email': email,
        'name': name,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Sign up successful!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF67AAD), Color(0xFFF3ADCA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 75),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Icon(
                    Icons.message_outlined,
                    size: 85,
                    color: const Color.fromARGB(255, 97, 160, 212),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    "Let's create an account for you!",
                    style: TextStyle(fontSize: 22, color: Color(0xFFFFFFFF)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: nameController,
                    hintText: "Name",
                    obscureText: false,
                    hintStyle: const TextStyle(color: Colors.white),
                    textStyle: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false,
                    hintStyle: const TextStyle(color: Colors.white),
                    textStyle: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true,
                    hintStyle: const TextStyle(color: Colors.white),
                    textStyle: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: confirmpasswordController,
                    hintText: "Confirm your Password",
                    obscureText: true,
                    hintStyle: const TextStyle(color: Colors.white),
                    textStyle: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  MyButton(
                    onTap: signUp,
                    text: "Sign Up",
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF4F92), Color(0xFFFF007A)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already a member?",
                        style: TextStyle(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: widget.onPressed,
                        child: const Text(
                          "Login Now",
                          style: TextStyle(
                            color: Colors.pink,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}