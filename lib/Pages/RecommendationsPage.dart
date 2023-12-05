import 'package:almeerah/Components/customStaggeredGrid.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';
class RecommendationsPage extends StatefulWidget {
  final String gender;
  final String userID;
  const RecommendationsPage({super.key, required this.gender, required this.userID});

  @override
  State<RecommendationsPage> createState() => _RecommendationsPageState();
}

class _RecommendationsPageState extends State<RecommendationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: IconButton(
          iconSize: 32,
          icon: Icon(Icons.chevron_left_outlined,),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        title: Text('Recommendations'),centerTitle: true,
        elevation: 1,
        backgroundColor: Theme.of(context).colorScheme.background,),
      body: CustomGrid(gender: widget.gender, userID: widget.userID),
    );
  }
}
