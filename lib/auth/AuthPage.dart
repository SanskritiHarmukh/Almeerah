import 'package:almeerah/Pages/LoginPage.dart';
import 'package:almeerah/Pages/RegisterPage.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;
  void togglescreen(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginPage(showRegisterPage: togglescreen);
    } else{
      return RegistrationPage(showLoginPage: togglescreen);
    }
  }
}
