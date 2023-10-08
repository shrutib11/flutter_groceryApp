// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:e_commerce/constants/constant.dart';
import 'package:e_commerce/constants/routes.dart';
import 'package:e_commerce/firebase_helper/firebase_auth_helper/auth_helper.dart';
import 'package:e_commerce/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:e_commerce/widgets/primary_button/primary_button.dart';
import 'package:e_commerce/widgets/top_titles/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignupState();
}

class _SignupState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  bool isShowPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopTitles(
                subtitle: "Welcome to App",
                title: "Create Account",
              ),
              SizedBox(
                height: 46,
              ),
              TextFormField(
                controller: name,
                decoration: const InputDecoration(
                  hintText: "Name",
                  prefixIcon: Icon(Icons.person_2_outlined),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: "E-mail",
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: phone,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: "Phone",
                  prefixIcon: Icon(Icons.phone_android_outlined),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: password,
                obscureText: isShowPassword,
                decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(Icons.padding_outlined),
                  suffixIcon: CupertinoButton(
                    onPressed: () {
                      setState(() {
                        isShowPassword = !isShowPassword;
                      });
                    },
                    padding: EdgeInsets.zero,
                    child: Icon(
                      Icons.visibility,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 36,
              ),
              PrimaryButton(
                title: "Create An account",
                onPressed: () async {
                  bool isValidated = signUpValidation(
                      email.text, password.text, name.text, phone.text);
                  if (isValidated) {
                    bool isLoggedIn = await AuthHelper.instance
                        .signUp(name.text, email.text, password.text, context);
                    if (isLoggedIn) {
                      Routes.instance
                          .pushNamedAndRemoveUntil(CustomBottomBar(), context);
                    }
                  }
                },
              ),
              SizedBox(
                height: 25,
              ),
              const Center(
                child: Text("Have you already account ? "),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: CupertinoButton(
                    child: Text(
                      "Login",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
