import 'package:flutter/material.dart';
import 'package:flutter_app/utils/styles.dart';

class Input extends StatelessWidget {
  final String label;
  final String hintText;
  final Icon icon;
  final bool obscureText;

  Input({this.label, this.hintText, this.icon, this.obscureText = false});

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
                return 'Value can\'t be empty';
              }
              return null;
            },
            obscureText: obscureText,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: icon,
                hintText: hintText,
                hintStyle: fmlHintTextStyle),
          ))
    ]);
  }
}
