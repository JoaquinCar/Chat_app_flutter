import 'package:chat_app/services/auth/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/Home_page.dart';

class AuthGate extends StatelessWidget {
  // Constructor de la clase AuthGate
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // El cuerpo del Scaffold contiene un StreamBuilder
      body: StreamBuilder<User?>(
        // Escucha los cambios en el estado de autenticación de Firebase
        stream: FirebaseAuth.instance.authStateChanges(),
        // Construye el widget basado en el estado de autenticación
        builder: (context, snapshot) {
          // Si el usuario está autenticado, muestra la HomePage
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            // Si el usuario no está autenticado, muestra la pantalla de Login o Registro
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}