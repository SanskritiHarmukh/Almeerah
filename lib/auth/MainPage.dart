import 'package:almeerah/auth/LoginPage.dart';
import 'package:almeerah/auth/RegisterPage.dart';
import 'package:almeerah/auth/AuthPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Pages/HomePage.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if (snapshot.hasData){
            return HomePage();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
