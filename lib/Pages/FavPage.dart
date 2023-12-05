import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../Components/customTextstyle.dart';
import 'HomePage.dart';
import 'OutfitDetails.dart';
class FavPage extends StatefulWidget {
  final String userId;
  const FavPage({super.key, required this.userId});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text('Favourites'),
        centerTitle: true,
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(widget.userId)
            .collection('fav')
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
          List<DocumentSnapshot> favs = snapshot.data!.docs;
          if (favs.length == 0){
            return Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_photo_alternate_outlined),
                    SizedBox(height: 8,),
                    Text("You haven't added anything in favourites",
                      textAlign: TextAlign.center,style: CustomTextStyles.paragraphTextStyle(context),),
                    Text("Explore and add to favourites",
                      textAlign: TextAlign.center,style: CustomTextStyles.paragraphTextStyle(context),)
                  ],
                ),
              ),
            );
          }else{
            return MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                itemCount: favs.length,
                //gridDelegate: const SliverMasonryGrid(crossAxisCount: 2,mainAxisSpacing: 2,crossAxisSpacing: 4,),
                itemBuilder: (context,index) {
                  var imageUrl = favs[index]['image_url'];
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context)=>OutfitDetails(itemID: favs[index].id)));
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
                                child: Icon(Icons.favorite, color: Colors.red,size: 24,),
                                onTap: () {
                                  removeFromFav(widget.userId,imageUrl);
                                }
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
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