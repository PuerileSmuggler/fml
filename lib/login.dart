import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/form/input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/firestore/user.dart';

class LoginScreen extends StatefulWidget {
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

class _RegisterData {
  String name = '';
  String email = '';
  String password = '';
  String lastName = '';
  void setEmail(String value) {
    this.email = value;
  }

  void setPassword(String value) {
    this.password = value;
  }

  void setName(String value) {
    this.name = value;
  }

  void setLastName(String value) {
    this.lastName = value;
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _registerFormKey = GlobalKey<FormState>();
  _LoginData _data = new _LoginData();
  _RegisterData _registerData = new _RegisterData();

  void submit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        User user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: _data.email, password: _data.password))
            .user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
  }

  void register() async {
    if (_registerFormKey.currentState.validate()) {
      _registerFormKey.currentState.save();
      try {
        User user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: _registerData.email, password: _registerData.password))
            .user;
        FirestoreUserController.addUser(
            user.uid, _registerData.name, _registerData.lastName);
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

  Widget _buildLoginButton(String text, Function onSubmit) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: RaisedButton(
            onPressed: onSubmit,
            elevation: 5.0,
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            color: Colors.white,
            child: Text(
              text,
              style: TextStyle(
                  color: Color(0xFF30afe3),
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontFamily: 'OpenSans'),
            )));
  }

  Widget _buildLoginForm() {
    return Stack(children: <Widget>[
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
                          _buildLoginButton('LOGIN', submit)
                        ])),
              ],
            ),
          ))
    ]);
  }

  Widget _buildRegisterForm() {
    return Stack(children: <Widget>[
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
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 30.0),
                Form(
                    key: _registerFormKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Input(
                            label: 'Email',
                            hintText: 'Enter your email',
                            icon: Icon(Icons.email, color: Colors.white),
                            onSaveFunc: this._registerData.setEmail,
                          ),
                          SizedBox(height: 20.0),
                          Input(
                              label: 'Password',
                              hintText: 'Enter your password',
                              icon: Icon(Icons.lock, color: Colors.white),
                              obscureText: true,
                              onSaveFunc: this._registerData.setPassword),
                          SizedBox(height: 20.0),
                          Input(
                              label: 'Name',
                              hintText: 'Enter your name',
                              icon: Icon(Icons.person, color: Colors.white),
                              onSaveFunc: this._registerData.setName),
                          SizedBox(height: 20.0),
                          Input(
                              label: 'Last name',
                              hintText: 'Enter your last name',
                              icon: Icon(Icons.person, color: Colors.white),
                              onSaveFunc: this._registerData.setLastName),
                          _buildLoginButton('REGISTER', register)
                        ])),
              ],
            ),
          ))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
                bottom:
                    TabBar(tabs: [Tab(text: 'Login'), Tab(text: 'Register')])),
            body: TabBarView(
                children: [_buildLoginForm(), _buildRegisterForm()])));
  }
}
