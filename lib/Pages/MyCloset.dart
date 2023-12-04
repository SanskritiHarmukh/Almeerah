import 'dart:io';
import 'package:almeerah/Pages/HomePage.dart';
import 'package:almeerah/auth/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    // Initialize the closet collection for the specific user
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
      appBar: AppBar(
        title: Text('MY CLOSET'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: closet.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(closet[index].type),
                  subtitle: Text(closet[index].color),
                  leading: Image.file(File(closet[index].imagePath)),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showImagePicker(context);
        },
        child: Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Future<void> _showImagePicker(BuildContext context) async {
    try {
      final picker = ImagePicker();
      final XFile? pickedFile = await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from Gallery'),
                onTap: () async {
                  Navigator.pop(
                    context,
                    await picker.pickImage(source: ImageSource.gallery),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
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
          title: Text('Enter Clothing Details'),
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
