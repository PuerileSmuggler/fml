import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final String uid;
  String url;
  double width;
  
  ProfilePicture({this.uid, this.width});

  Future<void> getURL() async {
    url = await FirebaseStorage.instance.ref().child('images').child('31iokp.jpg').getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: getURL(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          // return SomethingWentWrong();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          if (url != null) {
            return CircleAvatar(backgroundImage: NetworkImage(url), radius: width);
          }
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Image(image: AssetImage('assets/default.png'));
      },
    );
  }
}