import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../models/user_model.dart';
import '../services/user_datebase_service.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class UserProvider extends ChangeNotifier {
  // User details-related
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

  // User management database
  final UserDatabaseService _userService = UserDatabaseService();

  // Live users list
  Stream<List<UserModel>> get usersStream => _userService.getUsers();

  // Live non-admin list
  Stream<List<UserModel>> get nonAdminUsersStream => _userService.getNonAdminUsers();

  // Add user
  Future<void> addUser({
    required String phoneNumber,
    required Map<String, dynamic> userData,
    required Function(String verificationId) onCodeSent,
    required Function(String error) onError,
  }) async {
    await _userService.addUser(
      phoneNumber: phoneNumber,
      userData: userData,
      onCodeSent: onCodeSent,
      onError: onError,
    );
  }

  // Verify the creation of the user
  Future<void> verifyAndCreateUser({
    required String verificationId,
    required String smsCode,
    required Map<String, dynamic> userData,
  }) async {
    await _userService.verifyAndCreateUser(
      verificationId: verificationId,
      smsCode: smsCode,
      userData: userData,
    );
  }

  // Edit user
  Future<void> editUser(String id, Map<String, dynamic> data) async {
    await _userService.editUser(id, data);
  }

  // Delete user
  Future<void> deleteUser(String id) async {
    await _userService.deleteUser(id);
  }
}

