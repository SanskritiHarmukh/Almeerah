// import 'package:almeerah/auth/LoginPage.dart';
// import 'package:almeerah/auth/OnboardingPage1.dart';
// import 'package:almeerah/auth/RegisterPage.dart';
// import 'package:flutter/material.dart';
//
// class AuthPage extends StatefulWidget {
//   const AuthPage({super.key});
//
//   @override
//   State<AuthPage> createState() => _AuthPageState();
// }
//
// class _AuthPageState extends State<AuthPage> {
//   bool showLoginPage = true;
//   void togglescreen(){
//     setState(() {
//       showLoginPage = !showLoginPage;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     if(showLoginPage){
//       return LoginPage(showRegisterPage: togglescreen);
//     } else{
//       return OnboardingPage1(toggleScreen: togglescreen);
//       // return RegistrationPage(showLoginPage: togglescreen);
//     }
//   }
// }

// home page ka code
// ListView(
// // mainAxisAlignment: MainAxisAlignment.start,
// // crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text('Hello,',style: CustomTextStyles.paragraphTextStyle(context)),
// SizedBox(height: 4,),
// _userName != null
// ? Text(_userName!, style: CustomTextStyles.headingTextStyle(context))
//     : Text('User name not available'),
// //Text(_userName,style: CustomTextStyles.headingTextStyle(context)),
// SizedBox(height: 24,),
// Text('Tip of the day',style: CustomTextStyles.headingTextStyle(context),),
// SizedBox(height: 16,),
// tipsContainer(),
// SizedBox(height: 24,),
// // Row(
// //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //   children: [
// //   Text('OOTD',style:CustomTextStyles.headingTextStyle(context),),
// //   GestureDetector(
// //     child: Row(
// //       children: [
// //         Text('Outfit Calender',style: CustomTextStyles.paragraphTextStyle(context),),
// //         SizedBox(width: 8,),
// //         Icon(Icons.arrow_forward_outlined,size: 16,),
// //       ],),
// //     onTap: (){
// //       Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>CalendarPage()));
// //     },
// //   )
// // ],),
// // SizedBox(height: 16,),
// // CustomContainer(child: Row(
// //   children: [
// //     Container(width: 32,height: 32,color: Color(0xff33FFEC),),
// //     SizedBox(width: 32,),
// //     Text("Today's outfit"),
// //   ],
// // ),
// //     width: pageWidth-32,
// //      vpad: 8, hpad: 32),
// // SizedBox(height: 24,),
// // Center(
// //   child: GestureDetector(onTap: (){
// //     Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ZodiacOutfit()));
// //   }, child: Row(
// //     mainAxisAlignment: MainAxisAlignment.center,
// //     children: [
// //       Text('Zodiac Preferences',style: CustomTextStyles.paragraphTextStyle(context),),
// //       SizedBox(width: 12,),
// //       Icon(Icons.arrow_forward_ios_rounded,color: Theme.of(context).colorScheme.primary,size: 16,)
// //     ],
// //   ),
// //   ),
// // ),
// // SizedBox(height: 24,),
// // Center(
// //   child: GestureDetector(onTap: (){
// //     Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>NGOPage()));
// //   }, child: Row(
// //     mainAxisAlignment: MainAxisAlignment.center,
// //     children: [
// //       Text('Contact NGO',style: CustomTextStyles.paragraphTextStyle(context),),
// //       SizedBox(width: 12,),
// //       Icon(Icons.arrow_forward_ios_rounded,color: Theme.of(context).colorScheme.primary,size: 16,)
// //     ],
// //   ),
// //   ),
// // ),
// // SizedBox(height: 24,),
// // Center(
// //   child: GestureDetector(onTap: (){
// //     Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>FashionTipsPage()));
// //   }, child: Row(
// //     mainAxisAlignment: MainAxisAlignment.center,
// //     children: [
// //       Text('Fashion Tips',style: CustomTextStyles.paragraphTextStyle(context),),
// //       SizedBox(width: 12,),
// //       Icon(Icons.arrow_forward_ios_rounded,color: Theme.of(context).colorScheme.primary,size: 16,)
// //     ],
// //   ),
// //   ),
// // ),
// // SizedBox(height: 24,),
// Container(
// width: pageWidth,
// height: 128,
// child: ListView(
// scrollDirection: Axis.horizontal,
// children: [
// CategoryContainer(
// categoryName: 'OOTD',
// icon: Icons.calendar_month_outlined,
// pageName: '/ootd'),
// CategoryContainer(
// categoryName: 'Fashion Tips',
// icon: Icons.tips_and_updates_outlined,
// pageName: '/fashion'),
// CategoryContainer(
// categoryName: 'Zodiac Chic',
// icon: Icons.balance_outlined,
// pageName: '/zodiac'),
// CategoryContainer(
// categoryName: 'NGO Connect',
// icon: Icons.handshake_outlined,
// pageName: '/ngo'),
// CategoryContainer(
// categoryName: 'Faves',
// icon: Icons.star_border,
// pageName: '/fav'),
// CategoryContainer(
// categoryName: 'My Closet',
// icon: Icons.table_chart_outlined,
// pageName: '/closet'),
// ]
// ),
// ),
// SizedBox(height: 24,),
// Text('For You', style: CustomTextStyles.headingTextStyle(context),)
// ],
// )