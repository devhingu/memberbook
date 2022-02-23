import 'package:flutter/material.dart';

const kYellowColor = Color(0xFFFECE2F);
const kBlackColor = Color(0xFF1A1A1A);

const kSignInTextStyle = TextStyle(
  fontSize: 35.0,
  letterSpacing: 1.2,
  fontWeight: FontWeight.bold,
  color: kBlackColor,
);

const kTextStyle = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
  color: Colors.black54,
  letterSpacing: 0.8,
);

const kHeaderTextStyle = TextStyle(
  fontSize: 16.0,
  letterSpacing: 1.0,
  fontWeight: FontWeight.bold,
  color: kBlackColor,
);

const kNameTextStyle = TextStyle(
  color: kBlackColor,
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
);

final kBoxDecoration = BoxDecoration(
  color: kBlackColor,
  borderRadius: BorderRadius.circular(15.0),
  boxShadow: [
    BoxShadow(
      offset: const Offset(4, 8),
      blurRadius: 8.0,
      color: kBlackColor.withOpacity(0.5),
    ),
  ],
);

const kPadding = EdgeInsets.all(16.0);

final kBottomNavItems = [
  const BottomNavigationBarItem(
    label: "Home",
    icon: Icon(Icons.list),
  ),
  const BottomNavigationBarItem(
    label: "Profile",
    icon: Icon(Icons.person),
  ),
];
