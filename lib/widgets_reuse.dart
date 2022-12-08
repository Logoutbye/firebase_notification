import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetsReusing {
  static double button_radius = 10;

  static getSnakeBar(BuildContext context, String message,
      {GlobalKey<ScaffoldMessengerState>? scaffold}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          elevation: 0,
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          content: Text(message),
          backgroundColor: Colors.grey[800]),
    );
  }

}