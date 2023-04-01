import 'package:flutter/material.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/sizes.dart';

class InputBox extends StatelessWidget {
   InputBox({
    Key? key,
    required this.controller,
    required this.label,
    required this.textInputType,
    required this.style
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final TextInputType textInputType;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: defaultSpacing),
      child: TextFormField(
        controller: controller,
        validator: (value)=> value!.isEmpty? 'Enter your $label': null,
        style: style,
        keyboardType: textInputType,
        obscureText: label == 'Password' ? true : false,
        maxLines: 1,
        decoration: InputDecoration(
          hintText: label,
          hintStyle: TextStyle(color: Colors.grey[400]),
        ),
      ),
    );
  }
}