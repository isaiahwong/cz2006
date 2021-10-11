import 'package:cloud_firestore/cloud_firestore.dart';

import 'course.dart';

class CourseRepo {
  CollectionReference collection;

  CourseRepo()
      : collection = FirebaseFirestore.instance.collection('/coordinates');
  Future<List<Course>> getCoordinates() async {
    final snapshot = await collection.get();
    return snapshot.docs
        .map<Course>(
            (doc) => Course.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
