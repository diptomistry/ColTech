import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ExpertPage extends StatefulWidget {
  @override
  _ExpertPageState createState() => _ExpertPageState();
}

class _ExpertPageState extends State<ExpertPage> {
  CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection('experts'); // Replace 'experts' with your actual collection name

  Future<List<Map<String, dynamic>>?> getData() async {
    try {
      QuerySnapshot querySnapshot = await _collectionRef.get();

      // Get data from docs and convert to List of maps
      final allData = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return allData;
    } catch (e) {
      print('Error retrieving data: $e');
      return null;
    }
  }

  void contactExpert(String email) async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );

    if (await canLaunch(_emailLaunchUri.toString())) {
      await launch(_emailLaunchUri.toString());
    } else {
      throw 'Could not launch email';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Experts'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>?>(
        future: getData(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError || !snapshot.hasData) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            // Data retrieval is complete, and you have the data in the snapshot.data
            // You can display the data as needed here
            List<Map<String, dynamic>>? allData = snapshot.data;

            if (allData == null || allData.isEmpty) {
              return Center(
                child: Text('No experts found.'),
              );
            }

            return ListView.builder(
              itemCount: allData.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> expertData = allData[index];
                return ListTile(
                  title: Text(expertData['Name'] ?? 'Name not available'),
                  subtitle: Text(expertData['Profession'] ?? 'Profession not available'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      String email = expertData['Email'] ?? '';
                      if (email.isNotEmpty) {
                        contactExpert(email);
                      }
                    },
                    child: Text('Contact'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
