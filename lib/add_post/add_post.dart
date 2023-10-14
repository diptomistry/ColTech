import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coltech/HomeNavigationBaruser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  TextEditingController postEdit = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
        elevation: 0,
        actions: [
          InkWell(
            onTap: () async {
              FirebaseFirestore firestore = FirebaseFirestore.instance;
              CollectionReference posts = firestore.collection('posts');
              User? user = FirebaseAuth.instance.currentUser;

              if (user != null) {
                String uid = user.uid;

                await posts.add({
                  'userID': uid, // Set the UID explicitly
                  'text': postEdit.text,
                  'time': DateTime.now(),
                }).then((_) {
                  Get.to(UserNav());
                  print("posted");
                }).catchError((error) {
                  print("Failed to add post: $error");
                });
                CollectionReference users = FirebaseFirestore.instance.collection('users');
              } else {
                print("User is not signed in.");
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(18.0),
              child: Text('Post'),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        SizedBox(
        height: 20,
      ),
      Container(
        margin: EdgeInsets.only(left: 18),
        padding: EdgeInsets.only(left: 18),
        height: 100,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1)),],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0),
        child: TextField(
          style: TextStyle(color: Colors.black),
          controller: postEdit,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: 'Write...',
          ),
        ),
      ),
    ),
    SizedBox(
    height: 20,
    ),
    ],
    ),
    );
  }
}
