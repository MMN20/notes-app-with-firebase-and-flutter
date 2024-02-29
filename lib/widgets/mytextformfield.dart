import 'package:flutter/material.dart';
import 'package:flutter_firebase/utils.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.validator});
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?) validator;
  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(20);
    return TextFormField(
      cursorColor: mainButtonColorColor,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.black),
          contentPadding: const EdgeInsets.all(10),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: borderRadius,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius,
          ),
          hintText: hintText,
          prefix: const Padding(
            padding: EdgeInsets.only(left: 10),
          )),
    );
  }
}
