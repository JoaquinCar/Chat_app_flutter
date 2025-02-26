import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller; // controlador del campo de texto, se utiliza para controlar el texto que se muestra en el campo de texto
  final String hintText; // texto de ayuda que se muestra en el campo de texto cuando está vacío
  final bool obscureText; // indica si el texto del campo de texto debe ser oculto

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,

  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, // controlador del campo de texto
      obscureText: obscureText, // indica si el texto del campo de texto debe ser oculto
    decoration: InputDecoration( // decoración del campo de texto
      enabledBorder: OutlineInputBorder( // borde del campo de texto
        borderSide: BorderSide( // borde del campo de texto
          color: Colors.grey.shade200,
        ),
      ),
      focusedBorder: OutlineInputBorder( // borde del campo de texto cuando está enfocad  o
        borderSide: BorderSide(
        ),
      ),
              fillColor: Colors.grey[100],
              filled: true,
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey),

    ),
    );
  }
}