import 'package:firebase_notification/widgets_reuse.dart';
import 'package:flutter/material.dart';


class SecondNotificationScreen extends StatefulWidget {
  final String notification_title;
  const SecondNotificationScreen({required this.notification_title});

  @override
  State<SecondNotificationScreen> createState() => _SecondNotificationScreenState();
}

class _SecondNotificationScreenState extends State<SecondNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.notification_title}"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          WidgetsReusing.getSnakeBar(context, "meee");
        },
        child: Icon(Icons.message),
      ),
      body: Container(),
    );
  }
}
