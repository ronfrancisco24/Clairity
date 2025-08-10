import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String firstName;
  final String lastName;
  final String role;
  final String phoneNo;
  final String username;
  final DateTime createdAt;
  final String? building;

  UserModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.phoneNo,
    required this.username,
    required this.createdAt,
    this.building,
  });

  factory UserModel.fromMap(String uid, Map<String, dynamic> map) {
    return UserModel(
      uid: uid,
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      role: map['role'] ?? 'user',
      phoneNo: map['phoneNo'] ?? '',
      username: map['username'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      building: map['building'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'role': role,
      'phoneNo': phoneNo,
      'username': username,
      'createdAt': createdAt.toIso8601String(),
      'building': building ?? '',
    };
  }
}