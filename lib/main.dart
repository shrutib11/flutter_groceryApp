import 'package:e_commerce/constants/theme.dart';
import 'package:e_commerce/firebase_helper/firebase_auth_helper/auth_helper.dart';
import 'package:e_commerce/firebase_helper/firebase_options/firebase_options.dart';
import 'package:e_commerce/provider/app_provider.dart';
import 'package:e_commerce/screens/auth_ui/welcome/welcome.dart';
import 'package:e_commerce/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51NtDK4SDOv6RvfdXP2XCHfIx081PsoqUoOv2KicRljjzNg5xZTKI3lpG2KFpkEoOkWlvcvxM54Cu72U0E7NpfF1100nPS77Gat";
  await Firebase.initializeApp(
    options: DefaultFirebaseConfig.plateformOptions,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //title: 'E commerce',
        title: "Authentication",
        home: StreamBuilder(
          stream: AuthHelper.instance
              .getAuthChange, //if user leaves app and again open, user will remain logged in
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const CustomBottomBar();
            } else {
              return const Welcome();
            }
          },
        ),
        theme: themeData,
      ),
    );
  }
}
