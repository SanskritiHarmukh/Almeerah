import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Components/customcontainer.dart';

class NGOPage extends StatefulWidget {
  const NGOPage({Key? key}) : super(key: key);

  @override
  State<NGOPage> createState() => _NGOPageState();
}

class _NGOPageState extends State<NGOPage> {
  final ref = FirebaseDatabase.instance.ref('NGO');
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    TextStyle headingtextStyle = TextStyle(color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w900,fontSize: 16);
    TextStyle paratextStyle = TextStyle(color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w400,fontSize: 14);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 2,
        title: Text('NGO',style: TextStyle(color: Theme.of(context).colorScheme.primary),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                      child: CustomContainer(
                        child: Column(
                          children: [
                            Container(
                              alignment:Alignment.center,
                              child: Text(snapshot
                                  .child('name')
                                  .value
                                  .toString(),
                                style: headingtextStyle,textAlign: TextAlign.center,),
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(20),
                              //   color: Colors.teal,
                              // ),
                              //padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              alignment:Alignment.center,
                              child: Text(snapshot
                                  .child('location')
                                  .value
                                  .toString(),
                                style: paratextStyle,textAlign: TextAlign.center,),
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(20),
                              //   color: Colors.black12,
                              // ),
                              // padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              alignment:Alignment.center,
                              child: Text(snapshot
                                  .child('contact')
                                  .value
                                  .toString(),
                                style: paratextStyle,textAlign: TextAlign.center,),
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(20),
                              //   color: Colors.black12,
                              // ),
                              // padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                            ),
                            SizedBox(height: 10,),
                            Link(
                              target: LinkTarget.self,
                              uri: Uri.parse("snapshot.child('website').value.toString()"),
                              // uri: Uri.parse("www.google.com"),
                              builder: (context, followLink) =>
                                  InkWell(
                                    onTap: ()=> launch(snapshot.child('website').value.toString()),
                                    child: CustomContainer(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Website',
                                            style: paratextStyle,),
                                          Icon(Icons.call_made_rounded,size: 18,color: Theme.of(context).colorScheme.primary,),
                                        ],
                                      ),
                                      vpad: 16,
                                      hpad: 8,
                                      width: w*0.4,
                                    ),
                                  ),
                            ),
                          ],
                        ),
                        width: w-32,
                        vpad: 16,
                        hpad: 16,
                      ),
                  );
                  }
            ),
          )
        ],
      ),
    );
  }
}