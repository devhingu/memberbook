// ignore_for_file: avoid_print, unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:member_list_ui_challenge/constants/constants.dart';
import 'package:member_list_ui_challenge/constants/functions.dart';
import 'package:member_list_ui_challenge/firebase/firebase_service.dart';
import 'package:member_list_ui_challenge/screens/sign_in_screen.dart';
import 'package:member_list_ui_challenge/widgets/profile_list_tile.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  String name = "";
  String email = "";
  String phone = "";
  String photoUrl = "";

  void getCurrentUser() async {
    try {
      final kCurrentUser = FirebaseAuth.instance.currentUser;
      if (kCurrentUser != null) {
        photoUrl = kCurrentUser.photoURL!;
        name = kCurrentUser.displayName!;
        email = kCurrentUser.email!;
        phone = kCurrentUser.phoneNumber!;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("User Profile"),
      ),
      body: Padding(
        padding: kPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            userImageContainer(),
            spaceBox(),
            userDetailContainer(),
            spaceBox(),
            TextButton(
              onPressed: () {
                logoutFromApp(context);
              },
              child: const Text(
                "LOGOUT",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container userImageContainer() => Container(
        height: 180.0,
        width: 180.0,
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.grey,
          image: photoUrl != null
              ? DecorationImage(
                  image: NetworkImage(photoUrl),
                  fit: BoxFit.cover,
                )
              : const DecorationImage(
                  image: AssetImage("assets/user.png"),
                  fit: BoxFit.cover,
                ),
        ),
      );

  Container userDetailContainer() => Container(
        padding: kPadding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              offset: const Offset(4, 8),
              blurRadius: 10.0,
              color: kBlackColor.withOpacity(0.2),
            ),
          ],
        ),
        child: Column(
          children: [
            _profileNameListTile(),
            spaceBox(),
            profileEmailListTile(),
            spaceBox(),
            _profilePhoneListTile(),
          ],
        ),
      );

  ProfileListTile _profilePhoneListTile() => ProfileListTile(
        icon: Icons.phone,
        title: "PHONE",
        value: phone.toString(),
      );

  ProfileListTile profileEmailListTile() => ProfileListTile(
        icon: Icons.mail,
        title: "EMAIL",
        value: email,
      );

  ProfileListTile _profileNameListTile() => ProfileListTile(
        icon: Icons.person,
        title: "NAME",
        value: name,
      );

  SizedBox spaceBox() => const SizedBox(
        height: 15.0,
      );
}
