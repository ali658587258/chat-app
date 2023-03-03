import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
 final String label;
 final bool isPassword;
 final IconData iconData;
 final controller;


  MyTextField({required this.label,this.isPassword=false,required this.iconData,required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border:OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        prefixIcon: Icon(iconData),
        labelText: label,
      ),
      obscureText: isPassword,
    );
  }
}
