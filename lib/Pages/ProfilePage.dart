import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';

class ProfilePage extends StatefulWidget {
  final String userId;
  const ProfilePage({super.key, required this.userId});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late List<DocumentSnapshot> favDocuments;
  late List<DocumentSnapshot> closetDocuments;
  late String userFName;
  late String userLName;
  late String userGender;
  late List stylePreference;

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
      setState(() {
        userFName = user['firstname'];
        userLName = user['lastname'];
        userGender = user['gender'];
        stylePreference = user['stylepreference'];
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Details'),
          SizedBox(height: 8,),
          Text('Name: $userFName $userLName'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Favorites',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          favDocuments.length == 0 ? Center() : Container(
            height: 100,
            width: 100,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: favDocuments.length,
              itemBuilder: (context, index) {
                var imageUrl = favDocuments[index]['image_url'];
                return GestureDetector(
                  onTap: () {
                    // Handle onTap
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'My Closet',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          closetDocuments.length == 0 ? Center() : Container(
            height: 100,
            width: 100,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: closetDocuments.length,
              itemBuilder: (context, index) {
                var imageUrl = closetDocuments[index]['imagePath'];
                return GestureDetector(
                  onTap: () {
                    // Handle onTap
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
    );
  }
}

