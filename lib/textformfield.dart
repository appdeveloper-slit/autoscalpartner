import 'package:flutter/material.dart';

Widget textField(ctrl) {
  return TextFormField(
    controller: ctrl,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.all(8),
      // label: Text('Enter Your Number'),
      // hintText: "Aniket Mahakal",

      border: OutlineInputBorder(
          borderSide: BorderSide(
        color: Color(0xffE4DFDF),
      )),
    ),
  );
}
