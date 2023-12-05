import 'package:almeerah/Pages/CalendarPage.dart';
import 'package:almeerah/Pages/FashionTipsPage.dart';
import 'package:almeerah/Pages/FavPage.dart';
import 'package:almeerah/auth/LoginPage.dart';
import 'package:almeerah/Pages/MyCloset.dart';
import 'package:almeerah/auth/MainPage.dart';
import 'package:almeerah/Pages/NGOPage.dart';
import 'package:almeerah/Theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Pages/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Pages/ProfilePage.dart';
import 'Pages/ZodiacOutfit.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  String? userId = await getUserId(); // Fetch the user ID

  runApp(MyApp(userId: userId));
}

Future<String?> getUserId() async {
  // Fetch the user ID from Firebase Authentication
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    // User is signed in
    String userId = user.uid;
    return userId;
  } else {
    // User is not signed in
    return null;
  }
}

class MyApp extends StatefulWidget {
  final String? userId;

  const MyApp({Key? key, required this.userId}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      routes: {
        '/fashion': (context) => FashionTipsPage(),
        '/ngo': (context) => NGOPage(),
        '/ootd': (context) => CalendarPage(),
        '/zodiac': (context) => ZodiacOutfit(),
        '/fav': (context) => FavPage(userId: widget.userId  ?? ''),
        '/closet': (context) => MyCloset(userId: widget.userId ?? ''),
        '/login': (context) => LoginPage(),
        '/profile': (context) => ProfilePage(userId: widget.userId  ?? ''),
      },
      theme: lightMode,
      darkTheme: darkMode,
    );
  }


    // Fetch the user ID from Firebase Authentication

}
class BottomTabBar extends StatefulWidget {
  BottomTabBar({Key? key}) : super(key: key);

  @override
  State<BottomTabBar> createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  int _index = 0;
  final screens = [
    HomePage(),
    CalendarPage(),
    NGOPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[_index],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _index,
            onTap: (value) {
              setState(() {
                _index = value;
              });
            },

            backgroundColor: Color.fromARGB(255, 227, 227, 227),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                label: 'Calendar',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.pages),
                label: 'NGOs',
              ),
            ]));
  }
}