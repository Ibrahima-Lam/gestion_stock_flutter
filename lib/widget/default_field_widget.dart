import 'package:flutter/material.dart';

class Field extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  Field({super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(20)),
      child: TextField(
        controller: controller,
        // keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(8),
            hintText: hintText,
            border: InputBorder.none),
      ),
    );
  }
}
