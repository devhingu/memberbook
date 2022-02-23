import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:member_list_ui_challenge/constants/constants.dart';
import 'dialog_button.dart';
import 'member_list_tile.dart';

class MemberStreamListView extends StatefulWidget {
  final stream;
  final FirebaseFirestore _firestore;

  const MemberStreamListView({
    Key? key,
    this.stream,
    required FirebaseFirestore firestore,
  })  : _firestore = firestore,
        super(key: key);

  @override
  State<MemberStreamListView> createState() => _MemberStreamListViewState();
}

class _MemberStreamListViewState extends State<MemberStreamListView> {
  bool isDeleted = false;

  @override
  Widget build(BuildContext context) {
    return isDeleted
        ? const Center(
            child: CircularProgressIndicator(
              color: kBlackColor,
            ),
          )
        : StreamBuilder<QuerySnapshot>(
          stream: widget.stream,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: kBlackColor,
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (ctx, index) {
                final doc = snapshot.data?.docs[index];
                return MemberListTile(
                  imagePath: "assets/user.png",
                  name: "${doc!["firstName"]} ${doc["lastName"]}",
                  email: doc["email"],
                  phone: doc["phone"],
                  onDelete: () {
                    showDeleteDialog(context, doc);
                  },
                );
              },
            );
          },
        );
  }

  showDeleteDialog(BuildContext context, QueryDocumentSnapshot<Object?> doc) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Member"),
        content: const Text("Are you sure want to delete?"),
        actions: [
          DialogButton(
            title: "Yes",
            onPressed: () {
              deleteMember(doc);
            },
          ),
          DialogButton(
            title: "No",
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );

  deleteMember(doc) async {
    final kCurrentUser = FirebaseAuth.instance.currentUser;

    setState(() {
      isDeleted = true;
    });
    Navigator.pop(context);
    await widget._firestore
        .collection("members")
        .doc(kCurrentUser?.email)
        .collection("memberDetails")
        .doc(doc.id)
        .delete();
    setState(() {
      isDeleted = false;
    });
  }
}
