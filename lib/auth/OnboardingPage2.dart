import 'package:almeerah/auth/LoginPage.dart';
import 'package:almeerah/auth/OnboardingPage1.dart';
import 'package:almeerah/auth/RegisterPage.dart';
import 'package:flutter/material.dart';

import '../Components/customTextstyle.dart';

class OnboardingPage2 extends StatefulWidget {
        final String firstName;
        final String lastName;
        final String gender;
  const OnboardingPage2({super.key,
    required this.firstName,
    required this.lastName, required this.gender, });

  @override
  State<OnboardingPage2> createState() => _OnboardingPage2State();
}

class _OnboardingPage2State extends State<OnboardingPage2> {
  List<String> stylePreferences = ['Casual',
    'Formal',
    'Sporty',
    'Bohemian',
    'Vintage',
    'Streetwear',
    'Classic',
    'Elegant',
    'Gothic',
    'Chic',
    'Preppy',
    'Hipster',
    'Retro',
    'Minimalist',
    'Eclectic',
    'Romantic',
    'Edgy',
    'Modern',
    'Traditional',
    'Funky',
    'Artsy',
    'Business Casual',
    'Casual Chic',
    'Tomboy',
    'Sophisticated',
    'Casual Street',
    'Smart Casual',
    'Glamorous',
    'Punk',
    'Urban',
    'Surfer',
    'Rock',
    'Rustic',
    'Country',
    'Boho-Chic',
    'Avant-Garde',
    'Experimental',
    'Cottagecore',
    'Techwear',
    'Normcore',
    'Cyberpunk',
    'Grungy',
    'Nautical',
    'Military',
    'Ethnic',
    'Trendy',];
  List<String> selectedStyles = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 12),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                SizedBox(
                  height: 16,
                ),
                Text('User Preferences',style: CustomTextStyles.headingTextStyle(context),),
                SizedBox(
                  height: 8,
                ),
                Text('Select your style preferences, for more custom recommendations.',
                  style: CustomTextStyles.paragraphTextStyle(context),textAlign: TextAlign.center,),
                SizedBox(
                  height: 16,
                ),
                Wrap(
                  alignment: WrapAlignment.center,
              spacing: 12.0,
              runSpacing: 8.0,
              children: stylePreferences.map((styles) {
                return FilterChip(
                  selectedColor: Theme.of(context).colorScheme.primary.withOpacity(.5),
                  backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(.25),
                  label: Text(styles),
                  selected: selectedStyles.contains(styles),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        selectedStyles.add(styles);
                      } else {
                        selectedStyles.remove(styles);
                      }
                    });
                  },
                );
              }).toList(),
            ),
                SizedBox(
                  height: 32,
                ),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>RegistrationPage(
                        firstName: widget.firstName,
                        lastName: widget.lastName,
                        gender: widget.gender,
                        stylePreference: selectedStyles,
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
                SizedBox(
                  height: 32,
                ),
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
