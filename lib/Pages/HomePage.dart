import 'dart:math';

import 'package:almeerah/Components/customcontainer.dart';
import 'package:almeerah/Components/tipscontainer.dart';
import 'package:almeerah/Pages/CalendarPage.dart';
import 'package:almeerah/Pages/NGOPage.dart';
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
    TextStyle headingStyle = TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontWeight:FontWeight.w500,
        fontSize: 20
    );
    TextStyle paraStyle = TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontWeight:FontWeight.w400,
        fontSize: 16
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text("Allmeerah",style: TextStyle(color: Theme.of(context).colorScheme.primary),),
        centerTitle: true,
        leading: Icon(Icons.menu),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tip of the day',style: headingStyle,),
              SizedBox(height: 16,),
              tipsContainer(),
              SizedBox(height: 24,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text('OOTD',style: headingStyle,),
                GestureDetector(
                  child: Row(
                    children: [
                      Text('Outfit Calender',style: paraStyle,),
                      SizedBox(width: 8,),
                      Icon(Icons.arrow_forward_outlined,size: 16,),
                    ],),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>CalendarPage()));
                  },
                )
              ],),
              SizedBox(height: 16,),
              CustomContainer(child: Row(
                children: [
                  Container(width: 32,height: 32,color: Color(0xff33FFEC),),
                  SizedBox(width: 32,),
                  Text("Today's Color"),
                ],
              ),
                  color: Theme.of(context).colorScheme.background,
                  width: pageWidth-32,
                   vpad: 8, hpad: 32),
              SizedBox(height: 24,),
              Center(
                child: GestureDetector(onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>NGOPage()));
                }, child: Text('Contact NGO',style: paraStyle,),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
