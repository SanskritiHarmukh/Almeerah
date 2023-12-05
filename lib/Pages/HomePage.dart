import 'dart:math';

import 'package:almeerah/Components/categorycontainer.dart';
import 'package:almeerah/Components/customListTile.dart';
import 'package:almeerah/Components/customStaggeredGrid.dart';
import 'package:almeerah/Components/customTextstyle.dart';
import 'package:almeerah/Components/customcontainer.dart';
import 'package:almeerah/Components/tipscontainer.dart';
import 'package:almeerah/Pages/CalendarPage.dart';
import 'package:almeerah/Pages/FashionTipsPage.dart';
import 'package:almeerah/Pages/NGOPage.dart';
import 'package:almeerah/Pages/RecommendationsPage.dart';
import 'package:almeerah/Pages/ZodiacOutfit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Components/CustomDrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late User _user;
  late String _userName;
  late String _userGender;

  @override
  void initState() {
    // Fetching the current user during initialization
    _user = _auth.currentUser!;
    _fetchUserData();
    super.initState();
  }
  Future<void> _fetchUserData() async {
    try {
      DocumentSnapshot userSnapshot = await _firestore.collection('users').doc(_user.uid).get();
      Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
      setState(() {
        String name = userData['firstname'];
        _userName = capitalizeFirstLetter(name);
        _userGender = userData['gender'];
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }
  String capitalizeFirstLetter(String input) {
    if (input.isEmpty) {
      return input; // Handle empty string if needed
    }
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }
  @override
  Widget build(BuildContext context) {
    double pageWidth = MediaQuery.of(context).size.width;
    double pageHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (){
                Navigator.pushReplacementNamed(context,'/profile');
              },
              icon: Icon(Icons.person_2_outlined))
        ],
        elevation: 1,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text("Allmeerah",style: TextStyle(color: Theme.of(context).colorScheme.primary),),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hello,',style: CustomTextStyles.paragraphTextStyle(context)),
              SizedBox(height: 4,),
              _userName != null
                  ? Text(_userName, style: CustomTextStyles.headingTextStyle(context))
                  : Text('User name not available'),
              //Text(_userName,style: CustomTextStyles.headingTextStyle(context)),
              SizedBox(height: 24,),
              Text('Tip of the day',style: CustomTextStyles.headingTextStyle(context),),
              SizedBox(height: 16,),
              tipsContainer(),
              SizedBox(height: 16,),
              Container(
                width: pageWidth,
                height: 128,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      CategoryContainer(
                          categoryName: 'OOTD',
                          icon: Icons.calendar_month_outlined,
                          pageName: '/ootd'),
                      CategoryContainer(
                          categoryName: 'Fashion Tips',
                          icon: Icons.tips_and_updates_outlined,
                          pageName: '/fashion'),
                      CategoryContainer(
                          categoryName: 'Zodiac Chic',
                          icon: Icons.balance_outlined,
                          pageName: '/zodiac'),
                      CategoryContainer(
                          categoryName: 'NGO Connect',
                          icon: Icons.handshake_outlined,
                          pageName: '/ngo'),
                      CategoryContainer(
                          categoryName: 'Faves',
                          icon: Icons.favorite_border_outlined,
                          pageName: '/fav'),
                      CategoryContainer(
                          categoryName: 'My Closet',
                          icon: Icons.table_chart_outlined,
                          pageName: '/closet'),
                    ]
                ),
              ),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('For You', style: CustomTextStyles.headingTextStyle(context),),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> RecommendationsPage(
                          gender: _userGender, userID: _user.uid)));
                    },
                    child: Row(children: [
                      Text('See all', style: CustomTextStyles.paragraphTextStyle(context),),
                      Icon(Icons.chevron_right_outlined,size: 20,),
                    ],),
                  )
                ],
              ),
              SizedBox(height: 8,),
              Expanded(child: CustomGrid(gender: _userGender,userID: _user.uid,)),
            ],
          ),
        ),
      ),
    );
  }
}
