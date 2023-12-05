import 'package:almeerah/Pages/OutfitDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CustomGrid extends StatefulWidget {
  final String gender;
  final String userID;
  const CustomGrid({super.key, required this.gender, required this.userID});

  @override
  State<CustomGrid> createState() => _CustomGridState();
}

class _CustomGridState extends State<CustomGrid> {
  late List<bool> isFavList;
  void initState() {
    isFavList = [];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: widget.gender == 'Male' || widget.gender == 'Female'
          ? FirebaseFirestore.instance.collection('recommendations').doc(widget.gender)
          .collection('recommendations')
          .snapshots()
          : FirebaseFirestore.instance
          .collection('recommendations')
          .snapshots(),


      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        // Snapshot has data
        List<DocumentSnapshot> documents = snapshot.data!.docs;
        isFavList = List.filled(documents.length, false);
        return MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemCount: documents.length,
          //gridDelegate: const SliverMasonryGrid(crossAxisCount: 2,mainAxisSpacing: 2,crossAxisSpacing: 4,),
          itemBuilder: (context,index) {
            var imageUrl = documents[index]['image_url'];

            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context)=>OutfitDetails(itemID: documents[index].id)));
                      },
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        imageUrl,
                         fit: BoxFit.cover,
                        // width: double.infinity,
                        // height: double.infinity,
                        ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        child: isFavList[index]
                            ? Icon(Icons.favorite, color: Colors.red,size: 24,)
                            : Icon(Icons.favorite_border_outlined,size: 24,),
                        onTap: () {
                          String userId = widget.userID;
                          setState(() {
                            isFavList[index] = !isFavList[index]; // Toggle the selection state
                          });
                          if (isFavList[index]) {
                            addToFav(userId,imageUrl);
                          } else {
                            // Remove the data from the fav collection
                            removeFromFav(userId,imageUrl);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          });


      },
    );
  }
}

void addToFav(String userId, String imageUrl) {
  FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('fav')
      .add({
    'image_url': imageUrl,
    'timestamp': FieldValue.serverTimestamp(),
  })
      .then((value) {
    print('Added to fav: $imageUrl');
  })
      .catchError((error) {
    print('Error adding to fav: $error');
  });
}

void removeFromFav(String userId, String imageUrl) {
  FirebaseFirestore.instance
      .collection('users') // Replace 'users' with your user collection name
      .doc(userId)
      .collection('fav')
      .where('image_url', isEqualTo: imageUrl)
      .get()
      .then((querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      doc.reference.delete().then((value) {
        print('Removed from fav: $imageUrl');
      }).catchError((error) {
        print('Error removing from fav: $error');
      });
    });
  })
      .catchError((error) {
    print('Error getting documents: $error');
  });
}

