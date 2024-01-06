import 'package:almeerah/Components/customTextstyle.dart';
import 'package:almeerah/Pages/RecommendationsPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'HomePage.dart';

class ProfilePage extends StatefulWidget {
  final String userId;

  const ProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late List<DocumentSnapshot> favDocuments = [];
  late List<DocumentSnapshot> closetDocuments = [];
  late String userFName = '';
  late String userLName = '';
  late String userGender = '';
  late List stylePreference = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      QuerySnapshot favSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .collection('fav')
          .orderBy('timestamp', descending: true)
          .limit(4)
          .get();
      favDocuments = favSnapshot.docs;

      QuerySnapshot closetSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .collection('mycloset')
          .limit(4)
          .get();
      closetDocuments = closetSnapshot.docs;

      DocumentSnapshot user = await FirebaseFirestore.instance.collection('users').doc(widget.userId).get();
      Map<String, dynamic>? userData = user.data() as Map<String, dynamic>?;

      if (userData != null) {
        setState(() {
          userFName = userData['firstname'] ?? '';
          userLName = userData['lastname'] ?? '';
          userGender = userData['gender'] ?? '';
          stylePreference = userData['stylepreference'] ?? [];
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text('Profile'),
        leading: IconButton(
          iconSize: 32,
          icon: Icon(Icons.chevron_left_outlined),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Details', style: CustomTextStyles.paragraphTextStyle(context)),
          SizedBox(height: 8,),
          Text('Name: $userFName $userLName', style: CustomTextStyles.paragraphTextStyle(context)),
          SizedBox(height: 8,),
          Text('Gender: $userGender', style: CustomTextStyles.paragraphTextStyle(context)),
          SizedBox(height: 8,),
          Text('Style Preference:', style: CustomTextStyles.paragraphTextStyle(context)),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 4,
            children: stylePreference.map((data) => Chip(
              backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(.25),
              label: Text(data, style: CustomTextStyles.actionTextStyle(context)),
            )).toList(),
          ),
          SizedBox(height: 16,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //fav
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Favorites',
                        style: CustomTextStyles.paragraphTextStyle(context),
                      ),
                    ),
                    favDocuments.length == 0
                        ? Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => RecommendationsPage(gender: userGender, userID: widget.userId)));
                        },
                        child: Column(
                          children: [
                            Icon(Icons.double_arrow_outlined),
                            Text('See Recommendations')
                          ],
                        ),
                      ),
                    )
                        : Container(
                      height: (MediaQuery.of(context).size.width / 2) - 16,
                      width: (MediaQuery.of(context).size.width / 2) - 16,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                        ),
                        itemCount: favDocuments.length,
                        itemBuilder: (context, index) {
                          var imageUrl = favDocuments[index]['image_url'];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, '/fav');
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'My Closet',
                        style: CustomTextStyles.paragraphTextStyle(context),
                      ),
                    ),
                    closetDocuments.length == 0
                        ? Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/closet');
                        },
                        child: Column(
                          children: [
                            Icon(Icons.collections_outlined),
                            Text('Manage Closet')
                          ],
                        ),
                      ),
                    )
                        : Container(
                      height: (MediaQuery.of(context).size.width / 2) - 16,
                      width: (MediaQuery.of(context).size.width / 2) - 16,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                        ),
                        itemCount: closetDocuments.length,
                        itemBuilder: (context, index) {
                          return FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.userId)
                                .collection('mycloset')
                                .doc(closetDocuments[index].id)
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                print('Error fetching closet image: ${snapshot.error}');
                                return Center(child: Text('Error'));
                              } else if (!snapshot.hasData || snapshot.data == null) {
                                return Center(child: Text('No data available'));
                              } else {
                                var imagePath = (snapshot.data!.data() as Map<String, dynamic>)['imagePath'];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(context, '/closet');
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      File(imagePath),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}