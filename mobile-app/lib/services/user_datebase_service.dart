import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class UserDatabaseService {
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Fetch all users
  Stream<List<UserModel>> getUsers() {
    return _usersCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return UserModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Fetch all NON-admin users
  Stream<List<UserModel>> getNonAdminUsers() {
    return _usersCollection
        .where('role', isEqualTo: 'user')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return UserModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Add a new user (only if phoneNo is unique)
  Future<void> addUser({
    required String phoneNumber,
    required Map<String, dynamic> userData,
    required Function(String verificationId) onCodeSent,
    required Function(String error) onError,
  }) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          final userCred = await _auth.signInWithCredential(credential);
          await _saveUser(userCred.user!.uid, userData);
        },
        verificationFailed: (FirebaseAuthException e) {
          onError(e.message ?? "Verification failed");
        },
        codeSent: (String verificationId, int? resendToken) {
          onCodeSent(verificationId);
        },
        codeAutoRetrievalTimeout: (_) {},
      );
    } catch (e) {
      onError(e.toString());
    }
  }

  // Final step after OTP verification
  Future<void> verifyAndCreateUser({
    required String verificationId,
    required String smsCode,
    required Map<String, dynamic> userData,
  }) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    final userCred = await _auth.signInWithCredential(credential);
    await _saveUser(userCred.user!.uid, userData);
  }

  Future<void> _saveUser(String uid, Map<String, dynamic> userData) async {
    await _usersCollection.doc(uid).set({
      ...userData,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> editUser(String documentID, Map<String, dynamic> updatedData) async {
    await _usersCollection.doc(documentID).update(updatedData);
  }

  Future<void> deleteUser(String documentID) async {
    await _usersCollection.doc(documentID).delete();
  }
}
