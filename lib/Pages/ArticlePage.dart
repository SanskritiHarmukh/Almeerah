import 'package:flutter/material.dart';

class ArticlePage extends StatelessWidget {
  final String heading;
  final String description;
  const ArticlePage({Key? key,
  required this.heading,
  required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle headingtextStyle = TextStyle(color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w900,fontSize: 24,);
    TextStyle paratextStyle = TextStyle(color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w400,fontSize: 16);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: Text('Fashion Tips',
        style: TextStyle(color: Theme.of(context).colorScheme.primary),)
        ,backgroundColor: Theme.of(context).colorScheme.background,centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
        child: Column(
          children: [
            Text(heading,style: headingtextStyle,textAlign: TextAlign.center,),
            SizedBox(height: 24,),
            Text(description,style: paratextStyle,textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }
}
