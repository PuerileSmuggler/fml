import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreUserController {
  static Future<void> addUser(String uid, String name, String lastName) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    // Call the user's CollectionReference to add a new user
    return users
        .add({'uid': uid, 'name': name, 'lastName': lastName})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  static Future<QuerySnapshot> getUser(String uid) {
    return FirebaseFirestore.instance.collection('users').where('uid', isEqualTo: uid).get();
  }
}
