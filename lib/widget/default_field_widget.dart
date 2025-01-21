import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Field extends StatelessWidget {
  TextEditingController? controller;
  Function? onChanged;
  final String hintText;

  Field({super.key, this.controller, this.onChanged, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(20)),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            hintText: hintText,
            border: InputBorder.none),
        onChanged: (v) {
          onChanged!(v);
        },
      ),
    );
  }
}
