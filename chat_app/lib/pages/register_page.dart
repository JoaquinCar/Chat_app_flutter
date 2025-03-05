import 'package:chat_app/Components/button.dart';
import 'package:chat_app/Components/text_field.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onPressed; // función que se ejecuta cuando se presiona el botón
  const RegisterPage({super.key, this.onPressed});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text controllers
  final emailController = TextEditingController(); // controlador del campo de texto de email
  final passwordController = TextEditingController(); // controlador del campo de texto de contraseña
  final confirmpasswordController = TextEditingController(); // controlador del campo de texto de confirmar contraseña

  //sign up user
  void signUp() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmpassword = confirmpasswordController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmpassword.isEmpty) {
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
    return Scaffold( // crea un Scaffold, un widget de material que implementa la estructura visual básica de una aplicación'
      backgroundColor: Colors.grey[250], // color de fondo del Scaffold,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 75), // crea un espacio entre el borde del widget y sus hijos),
            child: Column( // crea una columna, un widget que organiza a sus hijos en una columna vertical
              mainAxisAlignment: MainAxisAlignment.center, // alinea los elementos de la columna al centro
              children: [ // lista de widgets hijos
                const SizedBox(height: 50), // crea un espacio vertical entre los widgets hijos
                // logo
                Icon(
                  Icons.message_outlined, // icono de chat
                  size: 85, // tamaño del icono
                  color: const Color.fromARGB(255, 97, 160, 212), // color del icono
                ),
                const SizedBox(height: 50),
                //crear la cuenta
                const Text("Let's create an account for you!", style: TextStyle(fontSize: 20,),),
                const SizedBox(height: 12),
                //email
                CustomTextField(
                  controller: emailController, // email controller, controlador del campo de texto de email
                  hintText: "Email", // texto de ayuda que se muestra en el campo de texto cuando está vacío
                  obscureText: false, // indica si el texto del campo de texto debe ser oculto
                ),
                const SizedBox(height: 25),
                //password
                CustomTextField(
                  controller: passwordController, // email controller, controlador del campo de texto de email
                  hintText: "Password", // texto de ayuda que se muestra en el campo de texto cuando está vacío
                  obscureText: true, // indica si el texto del campo de texto debe ser oculto
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  controller: confirmpasswordController, // email controller, controlador del campo de texto de email
                  hintText: "Confirm your Password", // texto de ayuda que se muestra en el campo de texto cuando está vacío
                  obscureText: true, // indica si el texto del campo de texto debe ser oculto
                ),
                const SizedBox(height: 30),
                //botón de inicio de sesión
                MyButton(onTap: signUp, text: "Sign Up"), //botón de inicio de sesión
                const SizedBox(height: 10),
                //botón de registro
                Row( // crea una fila, un widget que organiza a sus hijos en una fila horizontal
                  mainAxisAlignment: MainAxisAlignment.center, // alinea los elementos de la fila al centro
                  children: [ // lista de widgets hijos
                    const Text("Already a member?"), // texto de ayuda que se muestra en la fila
                    GestureDetector(
                      onTap: widget.onPressed,
                      child: const Text(
                        "Login Now",
                        style: TextStyle(
                          color: Colors.blueAccent,
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
    );
  }
}