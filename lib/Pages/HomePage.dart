import 'dart:math';

import 'package:almeerah/Components/categorycontainer.dart';
import 'package:almeerah/Components/customTextstyle.dart';
import 'package:almeerah/Components/customcontainer.dart';
import 'package:almeerah/Components/tipscontainer.dart';
import 'package:almeerah/Pages/CalendarPage.dart';
import 'package:almeerah/Pages/FashionTipsPage.dart';
import 'package:almeerah/Pages/NGOPage.dart';
import 'package:almeerah/Pages/ZodiacOutfit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    double pageWidth = MediaQuery.of(context).size.width;
    double pageHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.menu,color: Theme.of(context).colorScheme.primary,),
            Text("Allmeerah",style: TextStyle(color: Theme.of(context).colorScheme.primary),),
            GestureDetector(
                onTap: (){
                  FirebaseAuth.instance.signOut();
                },
                child: Icon(Icons.logout_outlined,color: Theme.of(context).colorScheme.primary,)),
          ],
        ),
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
              Text('Tip of the day',style: CustomTextStyles.headingTextStyle(context),),
              SizedBox(height: 16,),
              tipsContainer(),
              SizedBox(height: 24,),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //   Text('OOTD',style:CustomTextStyles.headingTextStyle(context),),
              //   GestureDetector(
              //     child: Row(
              //       children: [
              //         Text('Outfit Calender',style: CustomTextStyles.paragraphTextStyle(context),),
              //         SizedBox(width: 8,),
              //         Icon(Icons.arrow_forward_outlined,size: 16,),
              //       ],),
              //     onTap: (){
              //       Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>CalendarPage()));
              //     },
              //   )
              // ],),
              // SizedBox(height: 16,),
              // CustomContainer(child: Row(
              //   children: [
              //     Container(width: 32,height: 32,color: Color(0xff33FFEC),),
              //     SizedBox(width: 32,),
              //     Text("Today's outfit"),
              //   ],
              // ),
              //     width: pageWidth-32,
              //      vpad: 8, hpad: 32),
              // SizedBox(height: 24,),
              // Center(
              //   child: GestureDetector(onTap: (){
              //     Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ZodiacOutfit()));
              //   }, child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text('Zodiac Preferences',style: CustomTextStyles.paragraphTextStyle(context),),
              //       SizedBox(width: 12,),
              //       Icon(Icons.arrow_forward_ios_rounded,color: Theme.of(context).colorScheme.primary,size: 16,)
              //     ],
              //   ),
              //   ),
              // ),
              // SizedBox(height: 24,),
              // Center(
              //   child: GestureDetector(onTap: (){
              //     Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>NGOPage()));
              //   }, child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text('Contact NGO',style: CustomTextStyles.paragraphTextStyle(context),),
              //       SizedBox(width: 12,),
              //       Icon(Icons.arrow_forward_ios_rounded,color: Theme.of(context).colorScheme.primary,size: 16,)
              //     ],
              //   ),
              //   ),
              // ),
              // SizedBox(height: 24,),
              // Center(
              //   child: GestureDetector(onTap: (){
              //     Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>FashionTipsPage()));
              //   }, child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text('Fashion Tips',style: CustomTextStyles.paragraphTextStyle(context),),
              //       SizedBox(width: 12,),
              //       Icon(Icons.arrow_forward_ios_rounded,color: Theme.of(context).colorScheme.primary,size: 16,)
              //     ],
              //   ),
              //   ),
              // ),
              // SizedBox(height: 24,),
              Container(
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
                        icon: Icons.text_snippet_outlined,
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
                        icon: Icons.star_border,
                        pageName: '/fav'),
                    CategoryContainer(
                        categoryName: 'My Closet',
                        icon: Icons.table_chart_outlined,
                        pageName: '/closet'),
                  ]
                ),
              ),
              SizedBox(height: 24,),
              Text('For You', style: CustomTextStyles.headingTextStyle(context),)
            ],
          ),
        ),
      ),
    );
  }
}
