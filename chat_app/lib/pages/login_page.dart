import 'package:chat_app/Components/button.dart';
import 'package:chat_app/Components/text_field.dart';
import 'package:flutter/material.dart'; // se importa el paquete material.dart de la librería flutter

class LoginPage extends StatefulWidget { 
  final void Function()? onTap; // función que se ejecuta cuando se presiona el botón
  const LoginPage({super.key, this.onTap}); 

  @override // sobreescribe el método createState de la clase StatefulWidget
  State<LoginPage> createState() => _LoginPageState(); // crea un estado de la clase LoginPage, un estado es la información que puede ser leída sincrónicamente y que puede cambiar a lo largo del tiempo
}

class _LoginPageState extends State<LoginPage> { 
  //text controllers
  final emailController = TextEditingController(); // controlador del campo de texto de email
  final passwordController = TextEditingController(); // controlador del campo de texto de contraseña

  void signIn() { // función de inicio de sesión
    final email = emailController.text.trim(); // obtiene el texto del controlador de email, trim elimina los espacios en blanco al principio y al final de la cadena
    final password = passwordController.text.trim(); // obtiene el texto del controlador de contraseña

    if (email.isEmpty || password.isEmpty) { // si el email o la contraseña están vacíos
      ScaffoldMessenger.of(context).showSnackBar( // muestra un mensaje emergente en la parte inferior de la pantalla, scaffoldMessenger es un widget que muestra mensajes emergentes
        const SnackBar(content: Text("Please fill all the fields")), // mensaje emergente
      );
    } else { // si el email y la contraseña no están vacíos
      ScaffoldMessenger.of(context).showSnackBar( // muestra un mensaje emergente en la parte inferior de la pantalla, scaffoldMessenger es un widget que muestra mensajes emergentes
        const SnackBar(content: Text("User logged in successfully")), // mensaje emergente, snackbar es un widget que se muestra en la parte inferior de la pantalla
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
                //texto de bienvenida
                const Text("Welcome Back", style: TextStyle(fontSize: 20,),),
            
              const SizedBox(height: 12),
                //email
                CustomTextField(
                controller: emailController, // email controller, controlador del campo de texto de email
                hintText: "Email", // texto de ayuda que se muestra en el campo de texto cuando está vacío
                obscureText: false, // indica si el texto del campo de texto debe ser oculto
                ),
              const SizedBox(height: 30),
                //password
                CustomTextField(
                controller: passwordController, // email controller, controlador del campo de texto de email
                hintText: "Password", // texto de ayuda que se muestra en el campo de texto cuando está vacío
                obscureText: true, // indica si el texto del campo de texto debe ser oculto
                ),
                const SizedBox(height: 30),
            
                //botón de inicio de sesión
                MyButton(onTap: signIn, text: "Sign In"), //botón de inicio de sesión
                const SizedBox(height: 10),

            
                //botón de registro
                 Row( // crea una fila, un widget que organiza a sus hijos en una fila horizontal
                  mainAxisAlignment: MainAxisAlignment.center, // alinea los elementos de la fila al centro
                  children: [ // lista de widgets hijos
                    const Text("Don't have an account?"), // texto de ayuda que se muestra en la fila
                    const SizedBox(width: 5), // crea un espacio horizontal entre los widgets hijos
                      GestureDetector(
                        onTap: widget.onTap, // función que se ejecuta cuando se presiona el botón
                        child:  const Text("Sign Up", style: TextStyle(color: Colors.blue,decoration:TextDecoration.underline,fontWeight: FontWeight.bold, ),)), // texto que se muestra en el botón
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