// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:member_list_ui_challenge/constants/constants.dart';
import 'package:member_list_ui_challenge/constants/functions.dart';

import 'package:member_list_ui_challenge/widgets/header_list_tile.dart';
import 'package:member_list_ui_challenge/widgets/member_stream_list_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _firestore = FirebaseFirestore.instance;
  var stream;
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

  Stream<QuerySnapshot<Object?>>? newStream() {
    return _firestore
        .collection("members")
        .doc(email)
        .collection("memberDetails")
        .snapshots();
  }

  Future<void> _onRefresh() async {
    stream = newStream();
    print("data updated");
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    stream = newStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Member List"),
      ),
      drawer: buildDrawer(),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MemberStreamListView(stream: stream, firestore: _firestore),
        ),
      ),
    );
  }

  Drawer buildDrawer() => Drawer(
        child: ListView(
          children: [
            drawerHeader(),
            HeaderListTile(
              onPress: () {
                logoutFromApp(context);
              },
              icon: Icons.logout,
              title: "Logout",
            ),
          ],
        ),
      );

  UserAccountsDrawerHeader drawerHeader() => UserAccountsDrawerHeader(
        currentAccountPicture: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 35.0,
          backgroundImage: NetworkImage(photoUrl),
        ),
        accountEmail: Text(
          email,
          style: kHeaderTextStyle,
        ),
        accountName: Text(
          name,
          style: kHeaderTextStyle,
        ),
        decoration: const BoxDecoration(
          color: kYellowColor,
        ),
      );
}
