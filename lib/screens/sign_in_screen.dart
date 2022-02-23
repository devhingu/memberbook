import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:member_list_ui_challenge/constants/constants.dart';
import 'package:member_list_ui_challenge/constants/functions.dart';
import 'package:member_list_ui_challenge/firebase/firebase_service.dart';
import 'package:member_list_ui_challenge/home_page.dart';
import 'package:member_list_ui_challenge/widgets/google_sign_in_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            signInTopWidget(),
            GoogleSignInButton(
              onPress: _googleSignIn,
            )
          ],
        ),
      ),
    );
  }

  void _googleSignIn() async {
    FirebaseService service = FirebaseService();
    try {
      await service.signInWithGoogle();
      navigatePushReplacementScreen(context, const HomePage());
    } catch (e) {
      if (e is FirebaseAuthException) {
        showMessage(context, e.message!);
      }
    }
  }

  Column signInTopWidget() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: "list",
            child: Image.asset(
              "assets/list.png",
              height: 150.0,
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          const Text(
            "Hey There",
            style: kSignInTextStyle,
          ),
          const Text(
            "Welcome Back,",
            style: kSignInTextStyle,
          ),
          const SizedBox(
            height: 4.0,
          ),
          const Text(
            "Login to your account to continue",
            style: kTextStyle,
          ),
        ],
      );
}
