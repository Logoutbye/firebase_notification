import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notification/second_notification_screen.dart';
import 'package:firebase_notification/widgets_reuse.dart';
import 'package:flutter/material.dart';

Future<void> firebaseOnBackgroundMessage(RemoteMessage message) async {
  try {
    print("Firebase onBgMsg ${message.notification?.title}");
    print("Firebase onBgMsg ${message.notification?.body}");
  } catch (e) {
    print("Firebase onBgMsg ${e.toString()}");
  }
}

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(firebaseOnBackgroundMessage);

    runApp(FirebaseNotification());
  } catch (e) {
    print("FirebaseMessagingtoken error ${e.toString()}");
  }
}

class FirebaseNotification extends StatefulWidget {
  const FirebaseNotification({super.key});

  @override
  State<FirebaseNotification> createState() => _FirebaseNotificationState();
}

class _FirebaseNotificationState extends State<FirebaseNotification> {
  final GlobalKey<NavigatorState> navigatorState = GlobalKey<NavigatorState>();

  void FirebaseOnMessageNotificationHandler() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Firebase onMessage ${message.notification?.title}");
      print("Firebase onMessage ${message.notification?.body}");
      if (message != null) {
        notificationhandler(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Firebase onMessageOpenedApp ${message.notification?.title}");
      print("Firebase onMessageOpenedApp ${message.notification?.body}");
      if (message != null) {
        notificationhandler(message);
      }
    });
  }

  void notificationhandler(RemoteMessage message) {
    // WidgetsReusing.getSnakeBar(navigatorState.currentState!.context, "${message.notification!.title}");
   try{
     print("eeeeee${message.data}");
     print("eeeeee${message.data["roll_no"]}");
     print("eeeeee${message.data["notification_type"]}");

       navigatorState.currentState!.pushNamed("/SecondNotificationScreen",
           arguments: message.data["notification_type"]);






   }catch(e){
     print("eeeeee${e.toString()}");
   }
  }

  @override
  void initState() {
    super.initState();

    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    firebaseMessaging.getToken().then((value) {
      print("FirebaseMessagingtoken ::${value}");
    });
    FirebaseOnMessageNotificationHandler();
  }

  @override
  Widget build(BuildContext context) {
    // final GlobalKey<NavigatorState> navigatorState = GlobalKey<NavigatorState>() ;
    return MaterialApp(
      navigatorKey: navigatorState,
      title: "Notification",
      // routes: {
      //   "/": (context) =>
      //       Scaffold(
      //         appBar: AppBar(
      //           title: Text("First Screen"),
      //         ),
      //         floatingActionButton: FloatingActionButton(
      //           onPressed: () {
      //             WidgetsReusing.getSnakeBar(
      //                 navigatorState.currentState!.context, "message");
      //           },
      //           child: Icon(Icons.message),
      //         ),
      //         body: Container(),
      //       ),
      // },
      //   "/notificationhandler" : (context) => SecondNotificationScreen()
      onGenerateRoute: GenerateRoute,
    );
  }

  MaterialPageRoute GenerateRoute(RouteSettings settings) {
    if (settings.name == "/SecondNotificationScreen") {
      return MaterialPageRoute(
        builder: (builder) => SecondNotificationScreen(
          notification_title: settings.arguments.toString(),
        ),
      );
    } else {
      return MaterialPageRoute(
          builder: (builder) => Scaffold(
                appBar: AppBar(
                  title: Text("First Screen"),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    WidgetsReusing.getSnakeBar(
                        navigatorState.currentState!.context, "message");
                  },
                  child: Icon(Icons.message),
                ),
                body: Container(),
              ));

    }
  }
}
