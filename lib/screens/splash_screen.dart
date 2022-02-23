import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:member_list_ui_challenge/constants/constants.dart';
import 'package:member_list_ui_challenge/constants/functions.dart';
import 'package:member_list_ui_challenge/screens/sign_in_screen.dart';
import '../home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation, _animation;
  late AnimationController controller;

  void animationListener() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
    _animation = Tween(begin: 70.0, end: 170.0).animate(animation);

    _animation.addListener(() {
      setState(() {});
    });
    controller.forward();
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        final kCurrentUser = FirebaseAuth.instance.currentUser;
        if (kCurrentUser?.email == null) {
          navigatePushReplacementScreen(context, const SignInScreen());
        } else {
          navigatePushReplacementScreen(context, const HomePage());
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    animationListener();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Opacity(
        opacity: animation.value,
        child: _animatedLogo(),
      ),
    );
  }

  Align _animatedLogo() => Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: "list",
              child: Image.asset(
                "assets/list.png",
                height: _animation.value,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Member Book",
                style: kNameTextStyle,
              ),
            )
          ],
        ),
      );
}
