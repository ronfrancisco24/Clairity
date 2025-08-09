import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatabaseService {
  final CollectionReference _usersCollection =
  FirebaseFirestore.instance.collection('users');

  // Fetch all users
  Stream<List<Map<String, dynamic>>> getUsers() {
    return _usersCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'documentID': doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();
    });
  }

  // Fetch all NON-admin users
  Stream<List<Map<String, dynamic>>> getNonAdminUsers() {
    return _usersCollection
        .where('role', isNotEqualTo: 'admin') // filter out admin users
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'documentID': doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();
    });
  }

  // Add a new user (only if phoneNo is unique)
  Future<void> addUser(Map<String, dynamic> userData) async {
    final existingUser = await _usersCollection
        .where('phoneNo', isEqualTo: userData['phoneNo'])
        .get();

    if (existingUser.docs.isNotEmpty) {
      throw Exception('Phone number already exists.');
    }

    await _usersCollection.doc(userData['documentID']).set({
      ...userData,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Edit user (restricted fields not editable)
  Future<void> editUser(String documentID, Map<String, dynamic> updatedData) async {
    updatedData.remove('role');
    updatedData.remove('phoneNo');
    updatedData.remove('createdAt');

    await _usersCollection.doc(documentID).update(updatedData);
  }

  // Delete user
  Future<void> deleteUser(String documentID) async {
    await _usersCollection.doc(documentID).delete();
  }
}
