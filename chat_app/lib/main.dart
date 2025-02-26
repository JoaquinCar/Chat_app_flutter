
import 'package:chat_app/services/auth/login_or_register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); // corre la aplicación, se le pasa la clase principal que es MyApp

}
class MyApp extends StatelessWidget { // clase principal de la aplicación
  const MyApp({super.key}); // constructor de la clase, se le pasa la clave key que es un identificador único

  @override // sobreescribe el método build de la clase StatelessWidget
  Widget build(BuildContext context) { // método que construye la interfaz de la aplicación, build recibe un contexto de tipo BuildContext
    return MaterialApp(
      debugShowCheckedModeBanner: false, // quita la etiqueta de debug en la esquina superior derecha
      home:LoginOrRegister(), // se le pasa la clase LoginPage que es la pantalla de inicio de sesión
    );
  }
}
