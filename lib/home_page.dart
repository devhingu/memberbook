import 'package:flutter/material.dart';
import 'package:member_list_ui_challenge/constants/functions.dart';
import 'package:member_list_ui_challenge/screens/add_member_screen.dart';
import 'package:member_list_ui_challenge/screens/home_screen.dart';
import 'package:member_list_ui_challenge/screens/user_profile_screen.dart';
import 'constants/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _children = [
    const HomeScreen(),
    const UserProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: buildFloatingActionButton(context),
      bottomNavigationBar: bottomNavBar(),
    );
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context) =>
      FloatingActionButton(
        backgroundColor: kYellowColor,
        child: const Icon(
          Icons.add,
          color: kBlackColor,
          size: 30.0,
        ),
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddMemberScreen(),
            ),
          );
          // navigatePushScreen(context, const AddMemberScreen());
        },
      );

  BottomAppBar bottomNavBar() => BottomAppBar(
        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        notchMargin: 6.0,
        child: BottomNavigationBar(
          iconSize: 32.0,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          currentIndex: _selectedIndex,
          backgroundColor: kBlackColor,
          type: BottomNavigationBarType.fixed,
          items: kBottomNavItems,
          onTap: _onItemTapped,
        ),
      );
}
