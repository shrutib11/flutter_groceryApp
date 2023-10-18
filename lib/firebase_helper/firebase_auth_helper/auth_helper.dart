// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants/constant.dart';
import 'package:e_commerce/models/user_model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthHelper {
  static AuthHelper instance = AuthHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Notifies about changes to the user's sign-in state (such as sign-in or sign-out).
  Stream<User?> get getAuthChange => _auth.authStateChanges();

  Future<bool> login(
      String email, String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch (e) {
      showMessage(e.code.toString());
      Navigator.of(context).pop();
      return false;
    }
  }

  Future<bool> signUp(
      String name, String email, String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      UserModel userModel = UserModel(
          id: userCredential.user!.uid, name: name, email: email, image: null);

      _firestore.collection("users").doc(userModel.id).set(userModel.toJson());
      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch (e) {
      showMessage(e.code.toString());
      Navigator.of(context).pop();
      return false;
    }
  }

  void signOut() async {
    await _auth.signOut();
  }

  //Change password
  // ignore: non_constant_identifier_names
  Future<bool> ChangePassword(String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      _auth.currentUser!.updatePassword(password);
      Navigator.of(context, rootNavigator: true).pop();
      showMessage("Password changed");
      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch (e) {
      showMessage(e.code.toString());
      Navigator.of(context).pop();
      return false;
    }
  }
}
