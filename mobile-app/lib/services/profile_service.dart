import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//TODO: gather user details here

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<Map<String, dynamic>?> getUserDetails() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final uid = user.uid;

    DocumentSnapshot doc =
        await _firestore.collection('users').doc(uid).get();

    if (doc.exists) {
      return doc.data() as Map<String, dynamic>;
    } else {
      print('No user signed in');
    }
  }
  return null;
}
