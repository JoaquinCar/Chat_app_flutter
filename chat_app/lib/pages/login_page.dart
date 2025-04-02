import 'package:chat_app/Components/button.dart';
import 'package:chat_app/Components/text_field.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false); // Proveedor de AuthService para iniciar sesión
    // Lógica de inicio de sesión usando authService
    try {
      await authService.signInWithEmailAndPassword(emailController.text, passwordController.text); // Iniciar sesión con correo electrónico y contraseña
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
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
                    color: const Color.fromARGB(255, 255, 255, 250),
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    "Welcome Back",
                    style: TextStyle(fontSize: 20, color: Color(0xFFFFFFFF)),
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false,
                    hintStyle: const TextStyle(color: Colors.white),
                    textStyle: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 30),
                  CustomTextField(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true,
                    hintStyle: const TextStyle(color: Colors.white),
                    textStyle: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 30),
                  MyButton(
                    onTap: signIn,
                    text: "Sign In",
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
                        "Don't have an account?",
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          "Sign Up",
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