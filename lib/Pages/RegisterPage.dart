import 'package:almeerah/Pages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Components/customTextstyle.dart';
import '../Components/customcontainer.dart';
import '../Components/textfielddecoration.dart';

class RegistrationPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegistrationPage({super.key, required this.showLoginPage});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  //controllers
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _confirmpasswordcontroller = TextEditingController();
  Future SignUp() async{
   if (confirmedpassword()){
     await FirebaseAuth.instance.createUserWithEmailAndPassword(
         email: _emailcontroller.text.trim(),
         password: _passwordcontroller.text.trim());
   }
  }
  bool confirmedpassword(){
    if (_passwordcontroller.text.trim() == _confirmpasswordcontroller.text.trim()){
      return true;
    }else {
      return false;
    }
  }
  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _confirmpasswordcontroller.dispose();
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
                Text('Hello!',
                  style: CustomTextStyles.headingTextStyle(context),textAlign: TextAlign.center,),
                SizedBox(height: 8,),
                Text('Great Choice, we are all ready to help you.',
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
                SizedBox(height: 16,),
                //confirm password text field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    decoration: TextFieldDecorations.CustomBoxDeco(),
                    padding:EdgeInsets.only(left: 16),
                    child: TextFormField(
                      controller: _confirmpasswordcontroller,
                        obscureText: true,
                        decoration: TextFieldDecorations.Customdecoration('Confirm Password',Icons.lock_outline_rounded)),
                  ),
                ),
                SizedBox(height: 32,),
                //signup in button
                GestureDetector(
                  onTap: SignUp,
                  child: CustomContainer(child: Text('Sign In',textAlign: TextAlign.center,),
                      width: pageWidth-32,
                      vpad: 16,
                      hpad: 12),
                ),
                SizedBox(height: 32,),
                //login text
                GestureDetector(
                  onTap: widget.showLoginPage,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account ?'),
                      Text(' LogIn Now'),
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
