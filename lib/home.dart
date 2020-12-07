import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/form/input.dart';
import 'package:flutter_app/components/profilePicture.dart';
import 'package:flutter_app/firestore/user.dart';

import 'main.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
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

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  _LoginData _data = new _LoginData();

  void submit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    }
  }

  void createUser() async {
    User user = FirebaseAuth.instance.currentUser; // TODO: Check if user exists
// (await FirestoreUserController.getUser(user.uid)).docs.forEach((element) {print(element.data().entries.);});
  }

  Function logout(BuildContext context) {
    return () async {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return MyHomePage(title: 'Flutter Demo Home Page');
      }));
      print('Logged out');
    };
  }

  Widget _buildLoginButton(String text) {
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
                Text('Logged in',
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
                          _buildLoginButton('LOGIN')
                        ])),
              ],
            ),
          ))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your fammily'),
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Fammily',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            onTap: logout(context),
            leading: Icon(Icons.logout),
            title: Text('Logout'),
          ),
        ],
      )),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Profile',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              Divider(thickness: 2),
              Row(
                children: [
                  SizedBox(width: 120, child: ProfilePicture(uid: 'test', width: 60.0,)),

                  Text('Henlo'),
                  Text('Henlo'),
                ],
              ),
              RaisedButton(
                  onPressed: createUser,
                  elevation: 5.0,
                  padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  color: Colors.white,
                  child: Text(
                    'Create user collection',
                    style: TextStyle(
                        color: Color(0xFF30afe3),
                        letterSpacing: 1.5,
                        fontSize: 18.0,
                        fontFamily: 'OpenSans'),
                  )),
              Text('Your fammily',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              Divider(thickness: 2)
            ],
          ),
        ),
      ),
    );
  }
}
