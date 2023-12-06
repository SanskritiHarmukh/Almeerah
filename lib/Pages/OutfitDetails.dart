import 'package:almeerah/Components/customTextstyle.dart';
import 'package:almeerah/Pages/RecommendationsPage.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';

class OutfitDetails extends StatelessWidget {

  final String imageurl;
  final List colors;
  final List style;
  final List occasion;
  final List type;
  final List pattern;
  final List material;
  const OutfitDetails({super.key, required this.imageurl, required this.colors, required this.style, required this.occasion, required this.type, required this.pattern, required this.material});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text('Item Detail'),
        leading: IconButton(
          iconSize: 32,
          icon: Icon(Icons.chevron_left_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
              child: Image.network(imageurl)),
          SizedBox(height: 4,),
          Text('Colors',style: CustomTextStyles.paragraphTextStyle(context),),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 4,
            children: colors.map((data) => Chip(
                backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(.25),
                label: Text(data,style: CustomTextStyles.actionTextStyle(context),))).toList(),),
          Text('Style',style: CustomTextStyles.paragraphTextStyle(context),),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 4,
            children: style.map((data) => Chip(
                backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(.25),
                label: Text(data,style: CustomTextStyles.actionTextStyle(context),))).toList(),),
          Text('Occasion',style: CustomTextStyles.paragraphTextStyle(context),),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 4,
            children: occasion.map((data) => Chip(
                backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(.25),
                label: Text(data,style: CustomTextStyles.actionTextStyle(context),))).toList(),),
          Text('Type',style: CustomTextStyles.paragraphTextStyle(context),),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 4,
            children: type.map((data) => Chip(
                backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(.25),
                label: Text(data,style: CustomTextStyles.actionTextStyle(context),))).toList(),),
          Text('Patterns',style: CustomTextStyles.paragraphTextStyle(context),),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 4,
            children: pattern.map((data) => Chip(
                backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(.25),
                label: Text(data,style: CustomTextStyles.actionTextStyle(context),))).toList(),),
          Text('Material',style: CustomTextStyles.paragraphTextStyle(context),),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 4,
            children: material.map((data) => Chip(
                backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(.25),
                label: Text(data,style: CustomTextStyles.actionTextStyle(context),))).toList(),),
        ],
      ),
    );
  }
}
