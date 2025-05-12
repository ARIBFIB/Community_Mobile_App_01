import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companio_community_chat_firebase/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required String name,
    required String email,
    required String phoneNumber,
    required bool isOnline,
    required String uid,
    required String status,
    required String profileUrl,
  }) : super(
    name: name,
    email: email,
    phoneNumber: phoneNumber,
    isOnline: isOnline,
    uid: uid,
    status: status,
    profileUrl: profileUrl,
  );

  // Factory constructor to create an instance from a Firestore snapshot
  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return UserModel(
      name: data['name'] ?? '', // Provide default value if null
      email: data['email'] ?? '', // Provide default value if null
      phoneNumber: data['phoneNumber'] ?? '', // Provide default value if null
      uid: data['uid'] ?? '', // Provide default value if null
      isOnline: data['isOnline'] ?? false, // Default to false if null
      profileUrl: data['profileUrl'] ?? '', // Provide default value if null
      status: data['status'] ?? '', // Provide default value if null
    );
  }

  // Method to convert the UserModel to a Map for Firestore
  Map<String, dynamic> toDocument() {
    return {
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "uid": uid,
      "isOnline": isOnline,
      "profileUrl": profileUrl,
      "status": status,
    };
  }
}
