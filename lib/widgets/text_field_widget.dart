import 'package:flutter/material.dart';
import 'package:member_list_ui_challenge/constants/constants.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final String hintText;
  final TextInputType textInputType;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String value) onChanged;

  const TextFieldWidget({
    Key? key,
    required this.controller,
    required this.label,
    required this.hintText,
    required this.textInputType, required this.focusNode, required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: kHeaderTextStyle,
        ),
        const SizedBox(height: 8.0),
        TextField(
          onSubmitted: onChanged,
          focusNode: focusNode,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          maxLines: 1,
          keyboardType: textInputType,
        ),
      ],
    );
  }
}
