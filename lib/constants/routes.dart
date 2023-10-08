import 'package:flutter/material.dart';

class Routes {
  static Routes instance = Routes();
  Future<dynamic> pushNamedAndRemoveUntil(Widget widget, BuildContext context) {
    return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => widget), (route) => false);
  }

  Future<dynamic> push(Widget widget, BuildContext context) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => widget));
  }
}
