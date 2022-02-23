import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:member_list_ui_challenge/constants/constants.dart';
import 'package:member_list_ui_challenge/constants/functions.dart';
import 'package:member_list_ui_challenge/widgets/text_field_widget.dart';

class AddMemberScreen extends StatefulWidget {
  const AddMemberScreen({Key? key}) : super(key: key);

  @override
  _AddMemberScreenState createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  late FocusNode _firstNameFocusNode;
  late FocusNode _lastNameFocusNode;
  late FocusNode _emailFocusNode;
  late FocusNode _phoneFocusNode;
  final _firestore = FirebaseFirestore.instance;
  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    _firstNameFocusNode = FocusNode();
    _lastNameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add Member"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildSizedBox(),
              firstNameField(),
              buildSizedBox(),
              lastNameField(),
              buildSizedBox(),
              emailField(),
              buildSizedBox(),
              phoneField(),
              const SizedBox(
                height: 15.0,
              ),
              saveButton(),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector saveButton() => GestureDetector(
        onTap: uploadData,
        child: Container(
          padding: kPadding,
          margin: kPadding,
          decoration: kBoxDecoration,
          child: Center(
            child: isSaved
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white70,
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
          ),
        ),
      );

  void uploadData() async {
    final kCurrentUser = FirebaseAuth.instance.currentUser;

    if (_firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty) {
      setState(() {
        isSaved = true;
      });

      await _firestore
          .collection('members')
          .doc(kCurrentUser?.email)
          .collection("memberDetails")
          .add({
            'firstName': _firstNameController.text,
            'lastName': _lastNameController.text,
            'email': _emailController.text,
            'phone': _phoneController.text,
          })
          .then((value) => setState(() {
                isSaved = false;
              }))
          .then((value) => showMessage(context, "Data successfully added!"));
    } else {
      showMessage(context, "Please fill remaining fields!");
    }

    _firstNameController.clear();
    _lastNameController.clear();
    _emailController.clear();
    _phoneController.clear();
  }

  Widget firstNameField() => TextFieldWidget(
        controller: _firstNameController,
        label: 'FIRST NAME',
        hintText: "Enter First Name",
        textInputType: TextInputType.text,
        focusNode: _firstNameFocusNode,
        onChanged: (String value) {
          _firstNameFocusNode.unfocus();
          FocusScope.of(context).requestFocus(_lastNameFocusNode);
        },
      );

  Widget lastNameField() => TextFieldWidget(
        controller: _lastNameController,
        label: 'LAST NAME',
        hintText: "Enter Last Name",
        textInputType: TextInputType.text,
        focusNode: _lastNameFocusNode,
        onChanged: (String value) {
          _lastNameFocusNode.unfocus();
          FocusScope.of(context).requestFocus(_emailFocusNode);
        },
      );

  Widget emailField() => TextFieldWidget(
        controller: _emailController,
        label: 'EMAIL',
        hintText: "Enter Email",
        textInputType: TextInputType.emailAddress,
        focusNode: _emailFocusNode,
        onChanged: (String value) {
          _emailFocusNode.unfocus();
          FocusScope.of(context).requestFocus(_phoneFocusNode);
        },
      );

  Widget phoneField() => TextFieldWidget(
        controller: _phoneController,
        label: 'PHONE',
        hintText: "Enter Phone",
        textInputType: TextInputType.phone,
        focusNode: _phoneFocusNode,
        onChanged: (String value) {
          _phoneFocusNode.unfocus();
        },
      );

  SizedBox buildSizedBox() {
    return const SizedBox(
      height: 8.0,
    );
  }
}
