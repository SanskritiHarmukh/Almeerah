import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'customListTile.dart';
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    double pageWidth = MediaQuery.of(context).size.width;
    double pageHeight = MediaQuery.of(context).size.height;
    return Drawer(
      width: pageWidth/1.3,
      elevation: 2,
      backgroundColor: Theme.of(context).colorScheme.background,
      child: SafeArea(
        child: Container(
          child: ListView(
            itemExtent: pageHeight/8,
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
            children: [
              CustomListTile(
                  icon: Icons.person_2_outlined,
                  pageName: 'Profile',
                  pageRouteName: '/ootd'),
              CustomListTile(
                  icon: Icons.table_chart_outlined,
                  pageName: 'My Closet',
                  pageRouteName: '/closet'),
              CustomListTile(
                  icon: Icons.star_border_outlined,
                  pageName: 'Faves',
                  pageRouteName: '/fav'),
              CustomListTile(
                  icon: Icons.calendar_month_outlined,
                  pageName: 'Ootfit Calendar',
                  pageRouteName: '/ootd'),
              CustomListTile(
                  icon: Icons.tips_and_updates_outlined,
                  pageName: 'Fashion Tips',
                  pageRouteName: '/fashion'),
              CustomListTile(
                  icon: Icons.balance_outlined,
                  pageName: 'Zodiac Chic',
                  pageRouteName: '/zodiac'),
              CustomListTile(
                  icon: Icons.handshake_outlined,
                  pageName: 'NGO Connect',
                  pageRouteName: '/ngo'),

              ListTile(
                leading: Icon(Icons.logout_outlined,color: Colors.red,),
                title: Text('Logout',style: TextStyle(color: Colors.red,fontSize: 16,fontWeight:FontWeight.w400,),),
                onTap: () async {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login',
                        (Route<dynamic> route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
