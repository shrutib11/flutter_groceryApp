// ignore_for_file: avoid_unnecessary_containers

import 'package:e_commerce/constants/routes.dart';
import 'package:e_commerce/firebase_helper/firebase_auth_helper/auth_helper.dart';
import 'package:e_commerce/screens/about_us.dart/about_us.dart';
import 'package:e_commerce/screens/change_password/change_password.dart';
import 'package:e_commerce/screens/edit_profile/edit_profile.dart';
import 'package:e_commerce/screens/favourite_screen/favourite_screen.dart';
import 'package:e_commerce/screens/order_screen/order_screen.dart';
import 'package:e_commerce/widgets/primary_button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Account",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  appProvider.getUserInformation.image == null
                      ? const Icon(
                          Icons.person_outline,
                          size: 120,
                        )
                      : CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                              appProvider.getUserInformation.image!),
                        ),
                  Text(
                    appProvider.getUserInformation.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    appProvider.getUserInformation.email,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: 120,
                    height: 40,
                    child: PrimaryButton(
                      title: "Edit Profile",
                      onPressed: () {
                        Routes.instance.push(const EditProfile(), context);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Routes.instance.push(const OrderScreen(), context);
                    },
                    leading: const Icon(Icons.shopping_bag_outlined),
                    title: const Text("Your Orders"),
                  ),
                  ListTile(
                    onTap: () {
                      Routes.instance.push(const FavouriteScreen(), context);
                    },
                    leading: const Icon(Icons.favorite_outline),
                    title: const Text("Favourite"),
                  ),
                  ListTile(
                    onTap: () {
                      Routes.instance.push(const AboutUs(), context);
                    },
                    leading: const Icon(Icons.info_outline),
                    title: const Text("About us"),
                  ),
                  ListTile(
                    onTap: () {
                      Routes.instance.push(const ChangePassword(), context);
                    },
                    leading: const Icon(Icons.change_circle_outlined),
                    title: const Text("Change Password"),
                  ),
                  ListTile(
                    onTap: () {
                      AuthHelper.instance.signOut();
                      setState(() {});
                    },
                    leading: const Icon(Icons.exit_to_app),
                    title: const Text("Logout"),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text("version 1.0.0"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
