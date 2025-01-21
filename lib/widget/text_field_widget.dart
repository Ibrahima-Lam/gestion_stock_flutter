import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String hintText;
  final bool obscure;

  final TextEditingController controller;

  const TextFieldWidget({
    super.key,
    required this.hintText,
    required this.obscure,
    required this.controller,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      style: const TextStyle(fontSize: 16),
      obscureText: widget.obscure && !visible,
      decoration: InputDecoration(
          suffixIcon: !widget.obscure
              ? null
              : IconButton(
                  icon: !visible
                      ? const Icon(
                          Icons.visibility_off,
                          color: Colors.grey,
                        )
                      : const Icon(
                          Icons.visibility,
                          color: Colors.blue,
                        ),
                  onPressed: () {
                    _visible();
                  },
                ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 0.5, color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: widget.hintText,
          contentPadding: const EdgeInsets.all(10)),
    );
  }

  void _visible() {
    setState(() {
      visible = !visible;
    });
  }
}
