import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:quick_room_services/profile.dart';
import 'package:quick_room_services/sign_in.dart';
import 'package:quick_room_services/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // bool isLogin =
  // sp.getBool('is_login') != null ? sp.getBool("is_login")! : false;
  // bool isID = sp.getString('user_id') != null ? true : false;
  SharedPreferences sp = await SharedPreferences.getInstance();
  bool isLogin =
  sp.getBool('is_login') != null ? sp.getBool("is_login")! : false;
  OneSignal.shared.setAppId("fc3e9961-69d8-442b-858c-bc2a20defc7d");
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  OneSignal.shared.setNotificationOpenedHandler((value) {
    navigatorKey.currentState!.push(
      MaterialPageRoute(
        builder: (context) => Notifications(),
      ),
    );
  });
  runApp(
    MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: isLogin
            ? Profile()
            : SignIn(),
        // isLogin
        //     ? Profile()
        //     : SignIn(),
        // home: Splash(),
        ),
  );
}
