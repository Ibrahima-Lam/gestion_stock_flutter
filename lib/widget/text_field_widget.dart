import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final bool obscure;

  final TextEditingController controller;

  TextFieldWidget(
      {super.key,
      required this.hintText,
      required this.obscure,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(fontSize: 16),
      obscureText: obscure,
      decoration: InputDecoration(
          suffixIcon: !obscure
              ? null
              : IconButton(
                  icon: Icon(Icons.remove_red_eye),
                  onPressed: () {},
                ),
          border: InputBorder.none,
          hintText: hintText,
          contentPadding: EdgeInsets.all(10)),
    );
  }
}
