import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

/// Controls the social interaction of the app
class SocialController extends GetxController {
  late FirebaseFirestore _auth;

  @override
  void onInit() {
    _auth = FirebaseFirestore.instance;
    super.onInit();
  }

  /// TODO: Function to fetch name from the collection
}
