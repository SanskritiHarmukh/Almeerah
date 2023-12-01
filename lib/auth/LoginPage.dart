import 'package:almeerah/Components/customTextstyle.dart';
import 'package:almeerah/Components/customcontainer.dart';
import 'package:almeerah/Components/textfielddecoration.dart';
import 'package:almeerah/auth/OnboardingPage1.dart';
import 'package:almeerah/auth/RegisterPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({super.key, });
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //controllers
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  //login function
  Future logIn() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailcontroller.text.trim(),
        password: _passwordcontroller.text.trim());
  }
  //dispose controller after use
  @override
  void dispose(){
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double pageWidth = MediaQuery.of(context).size.width;
    double pageHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 32,),
                Text('Welcome Back!',
                  style: CustomTextStyles.headingTextStyle(context),textAlign: TextAlign.center,),
                SizedBox(height: 8,),
                Text('We missed you!!',
                  style: CustomTextStyles.paragraphTextStyle(context),textAlign: TextAlign.center,),
                SizedBox(height: 32,),
                //email text field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    decoration: TextFieldDecorations.CustomBoxDeco(),
                    padding: EdgeInsets.only(left: 16),
                    child: TextFormField(
                      controller: _emailcontroller,
                      decoration: TextFieldDecorations.Customdecoration('Email',Icons.email_outlined),
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                //password text field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    decoration: TextFieldDecorations.CustomBoxDeco(),
                    padding:EdgeInsets.only(left: 16),
                    child: TextFormField(
                      controller: _passwordcontroller,
                      obscureText: true,
                      decoration: TextFieldDecorations.Customdecoration('Password',Icons.lock_outline_rounded)),
                  ),
                ),
                SizedBox(height: 32,),
                //login in button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: logIn,
                        child: CustomContainer(child: Text('Log In',textAlign: TextAlign.center,),
                            width: pageWidth-32,
                            vpad: 16,
                            hpad: 12),
                      ),
                      SizedBox(height: 12,),
                      //forgot password text
                      Text('Forgot Password?',textAlign: TextAlign.right,),
                    ],
                  ),
                ),
                SizedBox(height: 32,),
                //signup text
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>OnboardingPage1()));
                  },
                  // widget.showRegisterPage,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account yet?'),
                      Text(' Register Now'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
