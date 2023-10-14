import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coltech/add_post/add_photo.dart';
import 'package:coltech/add_post/add_post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../models/post.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({Key? key});

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  bool isLoading = false;
  DocumentSnapshot? lastPostDocument;
  ScrollController _scrollController = ScrollController();
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
  }

  Future<User?> fetchUserWithID(String userID) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');

    DocumentSnapshot userSnapshot = await users.doc(userID).get();

    if (userSnapshot.exists) {
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;
      return User.fromMap(userData);
    } else {
      return null; // User not found
    }
  }

  Future<String?> getUserName(String userID) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');

    QuerySnapshot userSnapshot =
        await users.where('userID', isEqualTo: userID).get();

    if (userSnapshot.size > 0) {
      // Assuming there's only one document with the specified 'userID'
      QueryDocumentSnapshot userData = userSnapshot.docs[0];
      Map<String, dynamic> userDataMap =
          userData.data() as Map<String, dynamic>;

      // Make sure 'ownerName' is the correct field name in your Firestore document
      return userDataMap['ownerName'] ?? 'Name';
    } else {
      return null;
    }
  }

  Future<List<Post>> getPosts() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference posts = firestore.collection('posts');

    QuerySnapshot querySnapshot = await posts.get();

    List<Post> postList = [];
    querySnapshot.docs.forEach((doc) {
      postList.add(Post.fromMap(doc.data() as Map<String, dynamic>));
    });

    return postList;
  }

  Future<List<User?>?> fetchUserNames(List<Post> posts) async {
    List<User?> userNames = [];

    for (int i = 0; i < posts.length; i++) {
      User? user = await fetchUserWithID(posts[i].userID);
      userNames.add(user);
    }

    return userNames;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddPhotoPage(),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.add_circle_outline,
                    size: 30,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: FutureBuilder<List<Post>>(
                future: getPosts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Center(
                        child: Text('Error fetching posts ${snapshot.error}'));
                  } else if (!snapshot.hasData) {
                    return Center(child: Text('No posts found'));
                  } else {
                    List<Post> posts = snapshot.data!;

                    return FutureBuilder(
                      future: fetchUserNames(posts),
                      builder: (context, userNamesSnapshot) {
                        if (userNamesSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: posts.length,
                            itemBuilder: (context, index) {
                              Post post = posts[index];
                              User? _user = userNamesSnapshot.data?[index];
                              return Card(
                                elevation:
                                    4, // Add elevation for a shadow effect
                                margin: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8), // Adjust margins for spacing
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      12.0), // Add rounded corners
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      contentPadding: EdgeInsets.all(
                                          12), // Add padding to ListTile
                                      leading: CircleAvatar(
                                        backgroundColor:
                                            Colors.blue, // Set background color
                                        child: Icon(Icons.question_mark,
                                            color: Colors.white), // Icon color
                                      ),
                                      title: Text(
                                        _user?.ownerName ?? 'Unknown',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18, // Increase font size
                                          fontWeight: FontWeight
                                              .bold, // Add bold font weight
                                        ),
                                      ),
                                      subtitle: Text(
                                        "At ${DateFormat('h:mm a, d MMMM').format(post.time)}",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14, // Reduce font size
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(
                                          12), // Add padding to the text
                                      child: Text(
                                        post.text ?? 'Unknown',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16, // Increase font size
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 110,
        height: 40, // Set the desired width
        child: FloatingActionButton(
          onPressed: () {
            Get.to(() => AddPost());
            // Add your onPressed function here
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(
                4.0)), // Adjust the radius for the desired shape
          ),
          child: Center(child: Text('Add Question')),
        ),
      ),
    );
  }
}
