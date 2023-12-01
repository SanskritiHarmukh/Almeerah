// import 'package:almeerah/auth/LoginPage.dart';
// import 'package:almeerah/auth/OnboardingPage1.dart';
// import 'package:almeerah/auth/RegisterPage.dart';
// import 'package:flutter/material.dart';
//
// class AuthPage extends StatefulWidget {
//   const AuthPage({super.key});
//
//   @override
//   State<AuthPage> createState() => _AuthPageState();
// }
//
// class _AuthPageState extends State<AuthPage> {
//   bool showLoginPage = true;
//   void togglescreen(){
//     setState(() {
//       showLoginPage = !showLoginPage;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     if(showLoginPage){
//       return LoginPage(showRegisterPage: togglescreen);
//     } else{
//       return OnboardingPage1(toggleScreen: togglescreen);
//       // return RegistrationPage(showLoginPage: togglescreen);
//     }
//   }
// }
