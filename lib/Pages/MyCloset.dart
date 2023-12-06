import 'dart:io';
import 'package:almeerah/Components/customTextstyle.dart';
import 'package:almeerah/Pages/HomePage.dart';
import 'package:almeerah/auth/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';

class ClothingItem {
  String type;
  String color;
  String imagePath;

  ClothingItem({
    required this.type,
    required this.color,
    required this.imagePath,
  });
}

class MyCloset extends StatefulWidget {
  final String userId;

  const MyCloset({Key? key, required this.userId}) : super(key: key);

  @override
  State<MyCloset> createState() => _MyClosetState();
}

class _MyClosetState extends State<MyCloset> {
  late CollectionReference closetCollection;
  final List<ClothingItem> closet = [];

  @override
  void initState() {
    super.initState();
    closetCollection =
        FirebaseFirestore.instance.collection('users').doc(widget.userId).collection('mycloset');
    _loadClosetData();
  }

  Future<void> _loadClosetData() async {
    try {
      QuerySnapshot querySnapshot = await closetCollection.get();
      setState(() {
        closet.clear();
        closet.addAll(
          querySnapshot.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return ClothingItem(
              type: data['type'] ?? '',
              color: data['color'] ?? '',
              imagePath: data['imagePath'] ?? '',
            );
          }),
        );
      });
    } catch (e) {
      print("Error loading closet data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text('My Closet'),
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
      body: closet.length == 0
          ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
            child: GestureDetector(
              onTap: () {
                _showImagePicker(context);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_a_photo_outlined),
                  SizedBox(height: 8,),
                  Text('Add your outfits and accessories to easily manage them.',
                    textAlign: TextAlign.center,style: CustomTextStyles.paragraphTextStyle(context),)
                ],
              ),
            ),),
          )
          : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                _showImagePicker(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text('Items in Virtual Wardrobe: '),
                        Text(closet.length.toString()),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo_outlined,size: 24,),
                            Text('Add Item',style: CustomTextStyles.actionTextStyle(context),)
                          ],
                        )),
                  ],
                ),
              ),
            ),
            Expanded(
              child: MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                itemCount: closet.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8) ,
                          child: Image.file(File(closet[index].imagePath))),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(closet[index].type),
                          Text(closet[index].color)
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
        ],
      ),
          ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     _showImagePicker(context);
      //   },
      //   child: Icon(Icons.camera_alt),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Future<void> _showImagePicker(BuildContext context) async {
    try {
      final picker = ImagePicker();
      final XFile? pickedFile = await showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 4,
        context: context,
        builder: (BuildContext context) {
          return Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library_outlined),
                title: Text('Choose from Gallery'),
                onTap: () async {
                  Navigator.pop(
                    context,
                    await picker.pickImage(source: ImageSource.gallery),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera_outlined),
                title: Text('Take a Photo'),
                onTap: () async {
                  Navigator.pop(
                    context,
                    await picker.pickImage(source: ImageSource.camera),
                  );
                },
              ),
            ],
          );
        },
      );

      if (pickedFile != null) {
        _showDetailsDialog(context, pickedFile);
      }
    } catch (e) {
      print("Error showing image picker: $e");
    }
  }

  Future<void> _showDetailsDialog(BuildContext context, XFile pickedFile) async {
    String type = "";
    String color = "";

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
          scrollable: true,
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 4,
          title: Text('Enter Item Details',textAlign: TextAlign.center,),
          content: Column(
            children: [
              Image.file(File(pickedFile.path), height: 100),
              TextField(
                decoration: InputDecoration(labelText: 'Type'),
                onChanged: (value) {
                  type = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Color'),
                onChanged: (value) {
                  color = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                DocumentReference documentReference =
                await closetCollection.add({
                  'type': type,
                  'color': color,
                  'imagePath': pickedFile.path,
                });

                String documentId = documentReference.id;

                setState(() {
                  closet.add(ClothingItem(
                    type: type,
                    color: color,
                    imagePath: pickedFile.path,
                  ));
                });

                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
