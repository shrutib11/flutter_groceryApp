import 'package:e_commerce/constants/constant.dart';
import 'package:e_commerce/firebase_helper/firebase_auth_helper/auth_helper.dart';
import 'package:e_commerce/widgets/primary_button/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool isShowPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Change Password",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          TextFormField(
            controller: newPassword,
            obscureText: isShowPassword,
            decoration: InputDecoration(
              hintText: "New Password",
              prefixIcon: const Icon(Icons.padding_outlined),
              suffixIcon: CupertinoButton(
                onPressed: () {
                  setState(() {
                    isShowPassword = !isShowPassword;
                  });
                },
                padding: EdgeInsets.zero,
                child: const Icon(
                  Icons.visibility,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          TextFormField(
            controller: confirmPassword,
            obscureText: isShowPassword,
            decoration: const InputDecoration(
              hintText: "Confirm Password",
              prefixIcon: Icon(Icons.padding_outlined),
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          PrimaryButton(
            title: "Update",
            onPressed: () async {
              if (newPassword.text.isEmpty) {
                showMessage("New password is empty");
              } else if (confirmPassword.text.isEmpty) {
                showMessage("Confirm password is empty");
              } else if (confirmPassword.text == newPassword.text) {
                AuthHelper.instance.ChangePassword(newPassword.text, context);
              } else {
                showMessage("Confirm password is not match");
              }
            },
          )
        ],
      ),
    );
  }
}
