
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async{ // metodo principal de la aplicación
  WidgetsFlutterBinding.ensureInitialized(); // inicializa los widgets de flutter
  await Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform); // inicializa firebase con las opciones por defecto de la plataforma actual
  runApp(
      ChangeNotifierProvider( // provee el servicio de autenticación a la aplicación
          create: (context) => AuthService(), //
      child: const MyApp(),
      )
  ); // corre la aplicación, se le pasa la clase principal que es MyApp

}
class MyApp extends StatelessWidget { // clase principal de la aplicación
  const MyApp({super.key}); // constructor de la clase, se le pasa la clave key que es un identificador único

  @override // sobreescribe el metodo build de la clase StatelessWidget
  Widget build(BuildContext context) { // metodo que construye la interfaz de la aplicación, build recibe un contexto de tipo BuildContext
    return MaterialApp(
      debugShowCheckedModeBanner: false, // quita la etiqueta de debug en la esquina superior derecha
      home:AuthGate(), // se le pasa la clase LoginPage que es la pantalla de inicio de sesión
    );
  }
}
