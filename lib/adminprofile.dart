import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class AdminProfile extends StatefulWidget {
  @override
  _AdminProfileState createState() => _AdminProfileState();
}

class EmailMessage {
  final String subject;
  final String message;
  final List<String> recipients;

  EmailMessage({
  required this.subject,
  required this .message,
  required this.recipients,
});
}

class _AdminProfileState extends State<AdminProfile> {
  final CollectionReference _userCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference _expertCollection = FirebaseFirestore.instance.collection('experts');

  Future<List<DocumentSnapshot>> getData(CollectionReference collectionRef) async {
    QuerySnapshot querySnapshot = await collectionRef.get();
    return querySnapshot.docs;
  }

  List<String> selectedEmails = [];

  void toggleEmailSelection(String email) {
    if (selectedEmails.contains(email)) {
      setState(() {
        selectedEmails.remove(email);
      });
    } else {
      setState(() {
        selectedEmails.add(email);
      });
    }
  }

  void sendSelectedEmails() {
    if (selectedEmails.isNotEmpty) {
      String subject = 'Notification from Admin';
      String message = ''; // You can retrieve the message from a text field

      final emailMessage = EmailMessage(
        subject: subject,
        message: message,
        recipients: selectedEmails,
      );

      try {
        sendEmail(emailMessage);
        print('Email sent');
      } catch (error) {
        print('Error sending email: $error');
      }
    }
  }

  Future<void> sendEmail(EmailMessage emailMessage) async {
    final Email email = Email(
      subject: emailMessage.subject,
      body: emailMessage.message,
      recipients: emailMessage.recipients,
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }

  void deleteUserProfile(CollectionReference collectionRef, String userId) async {
    await collectionRef.doc(userId).delete();
    setState(() {
      selectedEmails.removeWhere((email) => email.contains(userId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Profile',
          style: TextStyle(
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF214062),
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
                      // User profiles
                      ListTile(
                        title: Text(
                          'User Profiles',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      for (DocumentSnapshot userProfile in userProfiles!)
                        ListTile(
                          title: Text(userProfile.get('Name') ?? 'Name not available'),
                          subtitle: Text(userProfile.get('Email') ?? 'Email not available'),
                          leading: Checkbox(
                            value: selectedEmails.contains(userProfile.get('Email')),
                            onChanged: (value) {
                              toggleEmailSelection(userProfile.get('Email'));
                            },
                          ),
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

                      // Expert profiles
                      ListTile(
                        title: Text(
                          'Expert Profiles',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      for (DocumentSnapshot expertProfile in expertProfiles!)
                        ListTile(
                          title: Text(expertProfile.get('Name') ?? 'Name not available'),
                          subtitle: Text(expertProfile.get('Email') ?? 'Email not available'),
                          leading: Checkbox(
                            value: selectedEmails.contains(expertProfile.get('Email')),
                            onChanged: (value) {
                              toggleEmailSelection(expertProfile.get('Email'));
                            },
                          ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: sendSelectedEmails,
        child: Icon(
          Icons.email,
          color: Colors.white,
        ),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
