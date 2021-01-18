import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/firestore/user.dart';

class FirestoreFamilyController {
  static Future<void> addFamily(String uid) { // Creates new family and adds chosen user to it
    CollectionReference families = FirebaseFirestore.instance.collection('family');
    return families
        .add({})
        .then((value) {
          FirestoreUserController.updateUserFamily(uid, value);
          })
        .catchError((error) => print("Failed to add family: $error"));
  }

  static Future<void> joinFamily(String uid, String code) async { // Add given user to family with given code
    print(code);
    CollectionReference families = FirebaseFirestore.instance.collection('family');
    String collection = (await FirebaseFirestore.instance
        .collection('family')
        .where('code', isEqualTo: code)
        .get()).docs[0].id;
    return FirestoreUserController.updateUserFamily(uid, families.doc(collection));
  }
}
