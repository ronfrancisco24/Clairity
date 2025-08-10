import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../models/user_model.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class UserProvider extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  bool get isLoaded => _user != null;

  Future<UserModel?> getUserDetails() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final uid = user.uid;
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();

      if (doc.exists) {
        return UserModel.fromMap(uid, doc.data() as Map<String, dynamic>);
      } else {
        print('User document not found in Firestore.');
      }
    }
    return null;
  }

  Stream<UserModel?> getUserDetailsStreamById(String uid) {
    return _firestore.collection('users').doc(uid).snapshots().map((doc) {
      if (doc.exists) {
        return UserModel.fromMap(uid, doc.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    });
  }

  Future<void> loadUserData() async {
    _user = await getUserDetails();
    notifyListeners();
  }

  void clearUserData() {
    _user = null;
    notifyListeners();
  }
}

