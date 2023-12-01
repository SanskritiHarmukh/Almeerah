import 'package:almeerah/auth/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Components/customTextstyle.dart';
import '../Components/customcontainer.dart';
import '../Components/textfielddecoration.dart';
import '../Pages/HomePage.dart';

class RegistrationPage extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String gender;
  final List<String> stylePreference;
  const RegistrationPage({super.key, required this.firstName, required this.lastName, required this.gender, required this.stylePreference,});

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
     // await FirebaseAuth.instance.createUserWithEmailAndPassword(
     //     email: _emailcontroller.text.trim(),
     //     password: _passwordcontroller.text.trim());
     try {
       UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
         email: _emailcontroller.text.trim(),
         password: _passwordcontroller.text.trim(),
       );
       String? uid = userCredential.user?.uid;
       if (uid != null) {
         await FirebaseFirestore.instance.collection('users').doc(uid).set({
           'email': _emailcontroller.text.trim(),
           'firstname' : widget.firstName,
           'lastname' : widget.lastName,
           'gender' : widget.gender,
           'stylepreference' : widget.stylePreference,
         });
         //creating a sub collection for my wardrobe details
         CollectionReference myWardrobeCollection = FirebaseFirestore.instance.collection('users').doc(uid).collection('mywardrobe');
         Navigator.pushAndRemoveUntil(
           context,
           MaterialPageRoute(builder: (BuildContext context) => HomePage()),(Route<dynamic> route) => false,
         );
       }
     } catch (e) {
       print('Error during registration: $e');
       // Handle registration errors
     }
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
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 8,),
                GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.chevron_left_outlined),
                        SizedBox(width: 4,),
                        Text('Back',style: CustomTextStyles.actionTextStyle(context),)
                      ],
                    ),
                ),
                SizedBox(height: 80,),
                Text('Credentials',
                  style: CustomTextStyles.headingTextStyle(context),textAlign: TextAlign.center,),
                SizedBox(height: 8,),
                Text('These credentials will be used to login in future.',
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
                  child: CustomContainer(child: Text('Create Account',textAlign: TextAlign.center,),
                      width: pageWidth-32,
                      vpad: 16,
                      hpad: 12),
                ),
                SizedBox(height: 32,),
                //login text
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>LoginPage()));
                  },
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
