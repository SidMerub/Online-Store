import 'package:flutter/material.dart';
class Routes{
  static Routes instance= Routes();
  Future<dynamic> pushAndRemoveUntil(
  {required BuildContext context, required Widget widget}) {
   return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => widget),
          (Route<dynamic> route) => false,
    );
  }
  Future<dynamic> push({required BuildContext context, required Widget widget}) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => widget),

    );
  }
}