import 'package:flutter/material.dart';
import 'package:member_list_ui_challenge/constants/constants.dart';

class HeaderListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPress;

  const HeaderListTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      title: Text(
        title,
        style: kHeaderTextStyle,
      ),
      leading: Icon(
        icon,
        color: kBlackColor,
      ),
    );
  }
}
