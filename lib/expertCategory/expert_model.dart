import 'package:cloud_firestore/cloud_firestore.dart';

class Expert {
  final String name;
  final String profession;
  final String skill;
  final String email;

  Expert(this.name, this.profession, this.skill, this.email);

  // Factory constructor to create an Expert object from Firestore data
  factory Expert.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Expert(
      data['Name'] ?? '',
      data['Profession'] ?? '',
      data['Skill'] ?? '',
      data['Email'] ?? '',
    );
  }
}

// Method to fetch a list of Expert objects from Firestore
Future<List<Expert>> fetchExperts() async {
  try {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('experts').get();
    List<Expert> experts =
        querySnapshot.docs.map((doc) => Expert.fromFirestore(doc)).toList();
    // print(experts.length);
    return experts;
  } catch (e) {
    print("Error fetching experts from Firestore: $e");
    return [];
  }
}
