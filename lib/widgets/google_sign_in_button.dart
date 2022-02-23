import 'package:flutter/material.dart';
import 'package:member_list_ui_challenge/constants/constants.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPress;

  const GoogleSignInButton({
    Key? key,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        decoration: kBoxDecoration,
        child: _signInWithGoogleRow(),
      ),
    );
  }

  Row _signInWithGoogleRow() => Row(
        children: [
          Image.asset(
            "assets/google.png",
            height: 40.0,
          ),
          const SizedBox(
            width: 10.0,
          ),
          const Text(
            "Sign in with Google",
            style: TextStyle(color: Colors.white70, fontSize: 18.0),
          )
        ],
      );
}
