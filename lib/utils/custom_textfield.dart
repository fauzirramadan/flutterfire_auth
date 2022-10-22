import 'package:flutter/material.dart';

class MyFormField extends StatelessWidget {
  final String title;

  final TextEditingController controller;
  final TextInputType inputType;
  const MyFormField(
      {Key? key,
      required this.title,
      required this.controller,
      required this.inputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType,
      controller: controller,
      validator: (value) => value!.isEmpty ? "Tidak boleh kosong" : null,
      decoration: InputDecoration(
          hintText: title,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12)),
          fillColor: Colors.white,
          filled: true),
    );
  }
}
