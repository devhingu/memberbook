import 'package:flutter/material.dart';
import 'package:member_list_ui_challenge/constants/constants.dart';

class MemberListTile extends StatelessWidget {
  final String imagePath;
  final String name;
  final String email;
  final String phone;
  final VoidCallback onDelete;

  const MemberListTile({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.email,
    required this.phone,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Card(
        elevation: 8.0,
        color: Colors.white,
        child: _buildListTile(),
      ),
    );
  }

  Widget _buildListTile() => Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListTile(
        leading: Image.asset(
          imagePath,
          height: 40.0,
        ),
        title: Text(
          name,
          style: kNameTextStyle,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                email,
                style: const TextStyle(color: Colors.black87),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                phone,
                style: const TextStyle(color: Colors.black87),
              ),
            ],
          ),
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
            color: kBlackColor,
          ),
          onPressed: onDelete,
        ),
      ),
  );
}