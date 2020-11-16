import 'package:flutter/material.dart';
import 'package:flutter_app/utils/styles.dart';

class Input extends StatefulWidget {
  final String label;
  final String hintText;
  final Icon icon;
  final bool obscureText;
  final void Function(String) onSaveFunc;
  Input(
      {this.label,
      this.hintText,
      this.icon,
      this.obscureText = false,
      this.onSaveFunc});
  @override
  _InputState createState() => _InputState(
      hintText: hintText,
      icon: icon,
      label: label,
      obscureText: obscureText,
      onSaveFunc: onSaveFunc);
}

class _InputState extends State<Input> {
  final String label;
  final String hintText;
  final Icon icon;
  final bool obscureText;
  final void Function(String) onSaveFunc;
  String error;

  _InputState(
      {this.label,
      this.hintText,
      this.icon,
      this.obscureText = false,
      this.onSaveFunc});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: fmlLabelStyle),
      SizedBox(height: 10.0),
      Container(
          alignment: Alignment.centerLeft,
          decoration: fmlBoxDecorationStyle,
          child: TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                setState(() {
                  this.error = 'This field is required';
                });
              } else {
                setState(() {
                  error = null;
                });
              }
              return null;
            },
            onSaved: (String value) {
              onSaveFunc(value);
            },
            obscureText: obscureText,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                errorStyle: TextStyle(height: 0.0, color: Color(0x00FFFFFF)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: icon,
                hintText: hintText,
                hintStyle: fmlHintTextStyle),
          )),
      if (this.error != null)
        Container(
          child: Text(this.error,
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.0,
                  fontStyle: FontStyle.italic)),
          padding: EdgeInsets.only(top: 10.0, left: 8.0),
        ),
    ]);
  }
}
