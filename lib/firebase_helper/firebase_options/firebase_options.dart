import 'dart:io';
import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get plateformOptions {
    if (Platform.isIOS) {
      //for ios and MacOS
      return const FirebaseOptions(
          apiKey: 'AIzaSyDawMSF3prkDzu7hhRd0hlpd1emMmZ3CRE',
          appId: '1:746282759143:ios:0b1c287d85ed1d46d18342',
          messagingSenderId: '746282759143',
          projectId: 'e-commerce-51c01',
          iosBundleId: 'com.example.eCommerce');
    } else {
      //Android
      return const FirebaseOptions(
        apiKey: 'AIzaSyAscwbq6iFBqMuWblQ7xVb0DVG6VQdWPcI',
        appId: '1:746282759143:android:9d85600a35ba13aed18342',
        messagingSenderId: '746282759143',
        projectId: 'e-commerce-51c01',
      );
    }
  }
}
