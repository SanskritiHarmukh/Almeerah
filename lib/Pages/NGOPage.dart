import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('NGO'),
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
                        vertical: 8, horizontal: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Container(
                                alignment:Alignment.center,
                                child: Text(snapshot
                                    .child('name')
                                    .value
                                    .toString(),
                                  style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w800,),textAlign: TextAlign.center,),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.teal,
                                ),
                                padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                alignment:Alignment.center,
                                child: Text(snapshot
                                    .child('location')
                                    .value
                                    .toString(),
                                  style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w800,),textAlign: TextAlign.center,),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black12,
                                ),
                                padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                alignment:Alignment.center,
                                child: Text(snapshot
                                    .child('contact')
                                    .value
                                    .toString(),
                                  style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w800,),textAlign: TextAlign.center,),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black12,
                                ),
                                padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                              ),
                              SizedBox(height: 10,),
                              Link(
                                target: LinkTarget.self,
                                uri: Uri.parse("snapshot.child('website').value.toString()"),
                                // uri: Uri.parse("www.google.com"),
                                builder: (context, followLink) =>
                                    InkWell(
                                      onTap: ()=> launch(snapshot.child('website').value.toString()),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Website',
                                              style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w800),),
                                            Icon(Icons.call_made_rounded,size: 18,color: Colors.black,),
                                          ],
                                        ),
                                        width: w*0.4,
                                        height: h*0.05,
                                        decoration: BoxDecoration(
                                          color: Colors.blueGrey,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                              ),
                            ],
                          )
                      ),
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