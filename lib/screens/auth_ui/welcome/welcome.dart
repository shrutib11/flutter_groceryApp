import 'package:e_commerce/constants/asset_image.dart';
import 'package:e_commerce/constants/routes.dart';
import 'package:e_commerce/screens/auth_ui/login/login.dart';
import 'package:e_commerce/screens/auth_ui/sign_up/sign_up.dart';
import 'package:e_commerce/widgets/primary_button/primary_button.dart';
import 'package:e_commerce/widgets/top_titles/top_titles.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TopTitles(
            subtitle: "Buy any items from using this app",
            title: "Welcome",
          ),
          Center(
            child: Image.asset(
              AssetsImages.instance.welcomeImage,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          PrimaryButton(
            title: "Login",
            onPressed: () {
              Routes.instance.push(const Login(), context);
            },
          ),
          const SizedBox(
            height: 18.0,
          ),
          PrimaryButton(
            title: "Sign Up",
            onPressed: () {
              Routes.instance.push(const SignUp(), context);
            },
          ),
        ],
      ),
    ));
  }
}
