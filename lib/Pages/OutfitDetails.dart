import 'package:almeerah/Pages/RecommendationsPage.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';

class OutfitDetails extends StatelessWidget {
  final String itemID;
  const OutfitDetails({super.key, required this.itemID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 32,
          icon: Icon(Icons.chevron_left_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(child: Text('outfit details page')),
    );
  }
}
