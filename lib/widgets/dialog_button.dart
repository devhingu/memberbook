import 'package:flutter/material.dart';
import 'package:member_list_ui_challenge/constants/constants.dart';

class DialogButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;

  const DialogButton({
    Key? key,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(color: kBlackColor),
      ),
    );
  }
}