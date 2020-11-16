import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/form/input.dart';

class LoginScreen extends StatefulWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;

  LoginScreen() {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginData {
  String email = '';
  String password = '';
  void setEmail(String value) {
    this.email = value;
  }

  void setPassword(String value) {
    this.password = value;
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  _LoginData _data = new _LoginData();

  void submit () async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      // try {
      //   UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      //       email: "barry.allen@example.com",
      //       password: "SuperSecretPassword!"
      //   );
      // } on FirebaseAuthException catch (e) {
      //   if (e.code == 'user-not-found') {
      //     print('No user found for that email.');
      //   } else if (e.code == 'wrong-password') {
      //     print('Wrong password provided for that user.');
      //   }
      // }
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: "barry.allen@example.com",
            password: "SuperSecretPassword!"
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Widget buildLoginButton() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: RaisedButton(
            onPressed: submit,
            elevation: 5.0,
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            color: Colors.white,
            child: Text(
              'LOGIN',
              style: TextStyle(
                  color: Color(0xFF30afe3),
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontFamily: 'OpenSans'),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color(0xFF30afe3),
              Color(0xFF009ddb),
              Color(0xFF0066e8)
            ],
                stops: [
              0.1,
              0.5,
              0.9
            ])),
      ),
      Container(
          height: double.infinity,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 120.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Sign in',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 30.0),
                Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Input(
                            label: 'Email',
                            hintText: 'Enter your email',
                            icon: Icon(Icons.email, color: Colors.white),
                            onSaveFunc: this._data.setEmail,
                          ),
                          SizedBox(height: 20.0),
                          Input(
                              label: 'Password',
                              hintText: 'Enter your password',
                              icon: Icon(Icons.lock, color: Colors.white),
                              obscureText: true,
                              onSaveFunc: this._data.setPassword),
                          buildLoginButton()
                        ])),
              ],
            ),
          ))
    ]));
  }
}
