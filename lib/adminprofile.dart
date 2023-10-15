import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminProfile extends StatefulWidget {
  @override
  _AdminProfileState createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  CollectionReference _userCollection =
  FirebaseFirestore.instance.collection('users'); // Replace with your user collection name
  CollectionReference _expertCollection =
  FirebaseFirestore.instance.collection('experts'); // Replace with your expert collection name

  Future<List<DocumentSnapshot>> getData(CollectionReference collectionRef) async {
    QuerySnapshot querySnapshot = await collectionRef.get();
    return querySnapshot.docs;
  }

  void deleteUserProfile(CollectionReference collectionRef, String userId) async {
    await collectionRef.doc(userId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Profile'),
        backgroundColor:  Color(0xFF214062),
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: getData(_userCollection),
        builder: (BuildContext context, AsyncSnapshot<List<DocumentSnapshot>> userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (userSnapshot.hasError) {
            return Center(
              child: Text('Error: ${userSnapshot.error}'),
            );
          } else {
            List<DocumentSnapshot<Object?>>? userProfiles = userSnapshot.data;

            return FutureBuilder<List<DocumentSnapshot>>(
              future: getData(_expertCollection),
              builder: (BuildContext context, AsyncSnapshot<List<DocumentSnapshot>> expertSnapshot) {
                if (expertSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (expertSnapshot.hasError) {
                  return Center(
                    child: Text('Error: ${expertSnapshot.error}'),
                  );
                } else {
                  List<DocumentSnapshot<Object?>>? expertProfiles = expertSnapshot.data;

                  return ListView(
                    children: [
                      ListTile(
                        title: Text(
                  'User Profiles',
                    style: TextStyle(
                      color: Colors.blueAccent, // Change the text color
                      fontWeight: FontWeight.bold, // Make the text bold
                    ),
                    // Add the subtitle if needed
                    // subtitle: Text('Manage expert profiles'),
                  )
                        //subtitle: Text('Manage user profiles'),
                      ),
                      for (DocumentSnapshot userProfile in userProfiles!)
                        ListTile(
                          title: Text(userProfile.get('Name') ?? 'Name not available'),
                          trailing: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete User Profile'),
                                    content: Text('Are you sure you want to delete this user profile?'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text('Delete'),
                                        onPressed: () {
                                          deleteUserProfile(_userCollection, userProfile.id);
                                          Navigator.of(context).pop();
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text('Delete'),
                          ),
                        ),
                      ListTile(
                        title:Text(
                          'Expert Profiles',
                          style: TextStyle(
                            color: Colors.blueAccent, // Change the text color
                            fontWeight: FontWeight.bold, // Make the text bold
                          ),
                          // Add the subtitle if needed
                          // subtitle: Text('Manage expert profiles'),
                        )

                      ),
                      for (DocumentSnapshot expertProfile in expertProfiles!)
                        ListTile(
                          title: Text(expertProfile.get('Name') ?? 'Name not available'),
                          trailing: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete Expert Profile'),
                                    content: Text('Are you sure you want to delete this expert profile?'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text('Delete'),
                                        onPressed: () {
                                          deleteUserProfile(_expertCollection, expertProfile.id);
                                          Navigator.of(context).pop();
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text('Delete'),
                          ),
                        ),
                    ],
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
