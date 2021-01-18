import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app/firestore/user.dart';

class FamilyCodeGenerator {

  static String getRandomString(int length)
      {
        final _chars = 'QWERTYUIOPASDFGHJKLZXCVBNM1234567890';
        Random _rnd = Random();
        return String.fromCharCodes(Iterable.generate(
            length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
      }

  static Future<String> generateCode() async {
    User user = FirebaseAuth.instance.currentUser;
    String code = FamilyCodeGenerator.getRandomString(5);
    ((await FirestoreUserController.getUserDataById(user.uid))['family'] as DocumentReference).set({ 'code': code, 'at': new DateTime.now() });
    return code;
  }
}
