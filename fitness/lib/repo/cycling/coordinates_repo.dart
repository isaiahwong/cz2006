import 'package:cloud_firestore/cloud_firestore.dart';

import 'coordinates.dart';

class CoordinatesRepo {
  CollectionReference collection;

  CoordinatesRepo()
      : collection = FirebaseFirestore.instance.collection('/coordinates');
  Future<List<Coordinates>> getCoordinates() async {
    final snapshot = await collection.get();
    return snapshot.docs
        .map<Coordinates>(
            (doc) => Coordinates.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
