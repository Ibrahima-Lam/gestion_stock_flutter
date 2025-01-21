import 'package:flutter/material.dart';

class AppBarBackWidget extends AppBar {
  AppBarBackWidget({super.key});

  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
