import 'package:almeerah/Components/customTextstyle.dart';
import 'package:almeerah/auth/OnboardingPage2.dart';
import 'package:flutter/material.dart';

import '../Components/textfielddecoration.dart';

class OnboardingPage1 extends StatefulWidget {

  const OnboardingPage1({super.key,
    });

  @override
  State<OnboardingPage1> createState() => _OnboardingPage1State();
}

class _OnboardingPage1State extends State<OnboardingPage1> {
  final _firstNamecontroller = TextEditingController();
  final _lastNamecontroller = TextEditingController();
  String selectedGender = '';
  List<String> genderOptions = ['Male', 'Female', 'Non-Binary', 'Other'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 12),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 32,
                ),
                Text('User Details',style: CustomTextStyles.headingTextStyle(context),),
                SizedBox(
                  height: 8,
                ),
                Text('Enter your basic details',style: CustomTextStyles.paragraphTextStyle(context),textAlign: TextAlign.center,),

                SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    decoration: TextFieldDecorations.CustomBoxDeco(),
                    padding: EdgeInsets.only(left: 16),
                    child: TextFormField(
                      controller: _firstNamecontroller,
                      decoration: TextFieldDecorations.Customdecoration('First Name',Icons.account_circle_outlined),
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                //last name text field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    decoration: TextFieldDecorations.CustomBoxDeco(),
                    padding:EdgeInsets.only(left: 16),
                    child: TextFormField(
                        controller: _lastNamecontroller,
                        decoration: TextFieldDecorations.Customdecoration('Last Name',Icons.account_circle_outlined)),
                  ),
                ),
                SizedBox(height: 16,),
                Text('Select your Gender'),
                SizedBox(height: 8,),
                Wrap(
                  spacing: 8,
                  runSpacing: 12,
                  children: genderOptions.map((gender) {
                    return ChoiceChip(
                      selectedColor: Theme.of(context).colorScheme.primary.withOpacity(.5),
                      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(.05),
                      disabledColor: Theme.of(context).colorScheme.primary.withOpacity(.05),
                      label: Text(gender),
                      selected: selectedGender == gender,
                      onSelected: (selected) {
                        setState(() {
                          selectedGender = selected ? gender : '';
                        });
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 16,),
                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>OnboardingPage2(
                          firstName: _firstNamecontroller.text.trim(),
                          lastName: _lastNamecontroller.text.trim(),
                          gender: selectedGender,
                        )));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Next',style: CustomTextStyles.actionTextStyle(context),),
                          SizedBox(width: 4,),
                          Icon(Icons.chevron_right_outlined),
                        ],
                      ),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account ?'),
                        Text(' LogIn Now'),
                      ],
                    ),
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
