import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:member_list_ui_challenge/screens/sign_in_screen.dart';
import 'package:member_list_ui_challenge/firebase/firebase_service.dart';

navigatePushReplacementScreen(context, screen) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );

navigatePushScreen(context, screen) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );

Future<void> logoutFromApp(context) async {
  FirebaseService service = FirebaseService();
  try {
    await service.signOutFromGoogle();
    navigatePushReplacementScreen(context, const SignInScreen());
  } catch (e) {
    if (e is FirebaseAuthException) {
      showMessage(context, e.message!);
    }
  }
}

void showMessage(context, String message) => showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
              child: const Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
