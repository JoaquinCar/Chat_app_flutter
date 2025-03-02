
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform);
  runApp(
      ChangeNotifierProvider(
          create: (context) => AuthService(),
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
