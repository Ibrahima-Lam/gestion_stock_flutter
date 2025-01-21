import 'package:flutter/material.dart';

class RowItem extends StatelessWidget {
  final String title;
  final String content;
  const RowItem({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(content),
      ],
    );
  }
}
