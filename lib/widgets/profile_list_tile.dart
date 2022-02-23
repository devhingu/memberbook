import 'package:flutter/material.dart';
import 'package:member_list_ui_challenge/constants/constants.dart';

class ProfileListTile extends StatelessWidget {
  final String value;
  final String title;
  final IconData icon;

  const ProfileListTile({
    Key? key,
    required this.icon,
    required this.value,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(
          width: 15.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: kHeaderTextStyle,
            ),
            Text(
              value,
              style: kTextStyle,
            ),
          ],
        ),
      ],
    );
  }
}
