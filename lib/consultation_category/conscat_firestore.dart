import 'package:cloud_firestore/cloud_firestore.dart';

class ConsCat {
  String id;
  String name;
  String image;

  ConsCat({
    required this.id,
    required this.name,
    required this.image,
  });

  factory ConsCat.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ConsCat(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      image: data['image'] ?? '',
    );
  }
}

Future<List<ConsCat>> fetchConsCats() async {
  String collectionName = 'consCat';

  try {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(collectionName).get();
    List<ConsCat> consCats =
        querySnapshot.docs.map((doc) => ConsCat.fromDocument(doc)).toList();
    return consCats;
  } catch (e) {
    print("Error fetching data from Firestore: $e");
    return [];
  }
}
