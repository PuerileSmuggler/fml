import 'package:flutter/material.dart';
import 'package:flutter_app/components/form/input.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  Widget buildLoginButton() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: RaisedButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              print('Validated');
            }
          },
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
                              icon: Icon(Icons.email, color: Colors.white)),
                          SizedBox(height: 20.0),
                          Input(
                            label: 'Password',
                            hintText: 'Enter your password',
                            icon: Icon(Icons.lock, color: Colors.white),
                            obscureText: true,
                          ),
                          buildLoginButton()
                        ])),
              ],
            ),
          ))
    ]));
  }
}
