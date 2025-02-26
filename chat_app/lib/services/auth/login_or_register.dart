import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  //variable para mostrar el login
  bool showLogin = true;

  //función para cambiar entre login y registro, toggleview cambia el estado de showLogin dependiendo de su valor actual
  void toggleView() {
    setState(() {
      showLogin = !showLogin; //al comparar el valor actual de showLogin con el valor opuesto, se cambia el estado de showLogin
    });
  }

  @override
  Widget build(BuildContext context) {  //con todo esto se crea un widget que muestra la pantalla de inicio de sesión o de registro dependiendo del valor de showLogin
    if (showLogin) {
      return LoginPage(onTap: toggleView);
    } else {
      return RegisterPage(onPressed: toggleView);
    }
  }
}