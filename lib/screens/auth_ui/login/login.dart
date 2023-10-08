// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:e_commerce/constants/constant.dart';
import 'package:e_commerce/constants/routes.dart';
import 'package:e_commerce/firebase_helper/firebase_auth_helper/auth_helper.dart';
import 'package:e_commerce/screens/home/home.dart';
import 'package:e_commerce/widgets/primary_button/primary_button.dart';
import 'package:e_commerce/widgets/top_titles/top_titles.dart';
import 'package:e_commerce/screens/auth_ui/sign_up/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
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
                subtitle: "Welcome back to App",
                title: "Login",
              ),
              SizedBox(
                height: 46,
              ),
              TextFormField(
                controller: email,
                decoration: const InputDecoration(
                  hintText: "E-mail",
                  prefixIcon: Icon(Icons.email_outlined),
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
                title: "Login",
                onPressed: () async {
                  bool isValidated = loginValidation(email.text, password.text);
                  if (isValidated) {
                    bool isLoggedIn = await AuthHelper.instance
                        .login(email.text, password.text, context);
                    if (isLoggedIn) {
                      Routes.instance.pushNamedAndRemoveUntil(Home(), context);
                    }
                  }
                },
              ),
              SizedBox(
                height: 25,
              ),
              const Center(
                child: Text("Don't have account ? "),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: CupertinoButton(
                    child: Text(
                      "Create an account",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    onPressed: () {
                      Routes.instance.push(const SignUp(), context);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
