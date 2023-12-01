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

import 'Pages/HomePage.dart';
import 'Pages/ZodiacOutfit.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

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
        '/fav': (context) => FavPage(),
        '/closet': (context) => MyCloset(),
        '/login': (context) => LoginPage(),
      },
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
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





