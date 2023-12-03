import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CustomGrid extends StatelessWidget {
  final String gender;
  const CustomGrid({super.key, required this.gender});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: gender == 'Male' || gender == 'Female'
          ? FirebaseFirestore.instance.collection('recommendations').doc(gender)
          .collection('recommendations')
          .snapshots()
          : FirebaseFirestore.instance
          .collection('recommendations')
          .snapshots(),
      // FirebaseFirestore.instance
      //     .collection('recommendation')
      //     .doc(gender)
      //     .collection('recommendations')
      //     .snapshots(),

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
        return MasonryGridView.builder(
          itemCount: documents.length,
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,),
          itemBuilder: (context,index) {
            var imageUrl = documents[index]['image_url'];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                      // Handle onTap
                      },
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(
                        imageUrl,
                         fit: BoxFit.cover,
                        // width: double.infinity,
                        // height: double.infinity,
                        ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        icon: Icon(Icons.favorite_border_outlined),
                      onPressed: () {
                      // Handle fav button press
                      },
                      ),
                    ),
                  ],
                ),
              ),
            );
          });

        // return StaggeredGridView.countBuilder(
        //   crossAxisCount: 4,
        //   itemCount: documents.length,
        //   itemBuilder: (BuildContext context, int index) {
        //     // Build your grid item using documents[index]
        //     return YourGridItemWidget(data: documents[index]);
        //   },
        //   staggeredTileBuilder: (int index) =>
        //       StaggeredTile.count(2, index.isEven ? 2 : 1),
        //   mainAxisSpacing: 4.0,
        //   crossAxisSpacing: 4.0,
        // );
      },
    );
  }
}

// class YourGridItemWidget extends StatelessWidget {
//   final DocumentSnapshot data;
//
//   YourGridItemWidget({required this.data});
//
//   @override
//   Widget build(BuildContext context) {
//     // Customize how you want to display each grid item using the data
//     return Container(
//       // Your grid item content
//     );
//   }
// }
// body: FutureBuilder<QuerySnapshot>(
// future: widget.userGender == 'male' || widget.userGender == 'female'
// ? FirebaseFirestore.instance
//     .collection('recommendations')
//     .doc(widget.userGender)
//     .collection('recommendations')
//     .get()
//     : FirebaseFirestore.instance
//     .collection('recommendations')
//     .get(),
// builder: (context, snapshot) {
// if (snapshot.connectionState == ConnectionState.waiting) {
// return CircularProgressIndicator();
// } else if (snapshot.hasError) {
// return Text('Error: ${snapshot.error}');
// } else {
// var data = snapshot.data!.docs;
//
// return StaggeredGridView.builder(
// gridDelegate: SliverStaggeredGridDelegateWithMaxCrossAxisExtent(
// maxCrossAxisExtent: 200,
// mainAxisSpacing: 8,
// crossAxisSpacing: 8,
// ),
// itemCount: data.length,
// itemBuilder: (context, index) {
// var imageUrl = data[index]['image_url'];
// return GestureDetector(
// onTap: () {
// // Handle onTap
// },
// child: Stack(
// children: [
// // Your image here
// Image.network(
// imageUrl,
// fit: BoxFit.cover,
// width: double.infinity,
// height: double.infinity,
// ),
// // Fav button on top
// Positioned(
// top: 8,
// right: 8,
// child: IconButton(
// icon: Icon(Icons.favorite),
// onPressed: () {
// // Handle fav button press
// },
// color: Colors.red,
// ),
// ),
// ],
// ),
// );
// },
// );
// }
// },
// ),
