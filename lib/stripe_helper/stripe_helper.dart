// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:e_commerce/constants/routes.dart';
import 'package:e_commerce/firebase_helper/firebase_firestore_helper/firestore_helper.dart';
import 'package:e_commerce/provider/app_provider.dart';
import 'package:e_commerce/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class StripeHelper {
  static StripeHelper instance = StripeHelper();
  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment(String amount, BuildContext context) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'USD');

      var gpay = const PaymentSheetGooglePay(
          merchantCountryCode: "US", currencyCode: "USD", testEnv: true);

      //initialize payment sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret:
                paymentIntent!['client_secret'], //Gotton from payment intent

            style: ThemeMode.light,
            merchantDisplayName: 'Shruti',
            googlePay: gpay,
          ))
          .then((value) {});

      //display payment sheet
      displayPaymentSheet(context);
    } catch (e) {
      print(e);
    }
  }

  displayPaymentSheet(BuildContext context) async {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    bool value = await FirestoreHelper.instance.uploadOrderdProductFirebase(
        appProvider.getBuyProductList, context, "Paid");
    print(value);
    appProvider.clearBuyProduct();
    if (value) {
      Future.delayed(const Duration(seconds: 2), () {
        Routes.instance.push(const CustomBottomBar(), context);
      });
    }
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        print("Payment Successfully");
      });
    } catch (e) {
      print(e);
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {'amount': amount, 'currency': currency};

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51NtDK4SDOv6RvfdXf9Ekug87ETb5hUNjFqiXx27vWSp4ItrbmQkbbVlQRzAI26HPfYJeSANG3RZujCa7BOXzd1Ta000zHZ5dDZ',
          'Content-type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
