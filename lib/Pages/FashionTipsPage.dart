import 'package:almeerah/Pages/ArticlePage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Components/customcontainer.dart';
class FashionTipsPage extends StatefulWidget {
  const FashionTipsPage({Key? key}) : super(key: key);

  @override
  State<FashionTipsPage> createState() => _FashionTipsPageState();
}

class _FashionTipsPageState extends State<FashionTipsPage> {
  final ref = FirebaseDatabase.instance.ref('FashionTips');
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    TextStyle headingtextStyle = TextStyle(color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w900,fontSize: 16);
    TextStyle paratextStyle = TextStyle(color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w400,fontSize: 12);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 2,
        title: Text('Fashion Tips',style: TextStyle(color: Theme.of(context).colorScheme.primary),),
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
                        child: InkWell(
                          onTap: (){
                            String heading = snapshot.child('heading').value.toString();
                            String description = snapshot.child('description').value.toString();
                            String image = snapshot.child('imageUrl').value.toString();
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ArticlePage(
                              heading: heading,
                              description: description,
                            image: image,)));
                          },
                          child: Column(
                            children: [
                              Container(
                                width: w-64,
                                height: h*.2,
                                alignment:Alignment.center,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                    child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/images/placeholder.png',
                                  image: snapshot.child('imageUrl').value.toString(),
                                    ),),


                                // decoration: BoxDecoration(
                                //   borderRadius: BorderRadius.circular(20),
                                //   color: Colors.teal,
                                // ),
                                //padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                              ),
                              SizedBox(height: 16,),
                              Container(
                                alignment:Alignment.center,
                                child: Text(snapshot
                                    .child('heading')
                                    .value
                                    .toString(),
                                  style: headingtextStyle,textAlign: TextAlign.center,),
                                // decoration: BoxDecoration(
                                //   borderRadius: BorderRadius.circular(20),
                                //   color: Colors.black12,
                                // ),
                                // padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                              ),
                              SizedBox(height: 16,),
                              Container(
                                alignment:Alignment.center,
                                child: Text(snapshot
                                    .child('description')
                                    .value
                                    .toString(),
                                  style: paratextStyle,textAlign: TextAlign.left,maxLines: 4,overflow: TextOverflow.ellipsis,),
                                // decoration: BoxDecoration(
                                //   borderRadius: BorderRadius.circular(20),
                                //   color: Colors.black12,
                                // ),
                                // padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                              ),
                              // SizedBox(height: 10,),
                              // Link(
                              //   target: LinkTarget.self,
                              //   uri: Uri.parse("snapshot.child('website').value.toString()"),
                              //   // uri: Uri.parse("www.google.com"),
                              //   builder: (context, followLink) =>
                              //       InkWell(
                              //         onTap: ()=> launch(snapshot.child('website').value.toString()),
                              //         child: CustomContainer(
                              //           child: Row(
                              //             mainAxisAlignment: MainAxisAlignment.center,
                              //             children: [
                              //               Text('Website',
                              //                 style: paratextStyle,),
                              //               Icon(Icons.call_made_rounded,size: 18,color: Theme.of(context).colorScheme.primary,),
                              //             ],
                              //           ),
                              //           vpad: 16,
                              //           hpad: 8,
                              //           width: w*0.4,
                              //         ),
                              //       ),
                              // ),
                            ],
                          ),
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
