import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:quick_room_services/values/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'manage/static_method.dart';
import 'profile.dart';
import 'sign_in.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    getSessionData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3F4F0),
      body: Center(
        child: GifView.asset(
          'assets/splashgif.gif',
          height: 200,
          width: 200,
          frameRate: 30, // default is 15 FPS
        ),
      ),
    );
  }

  //Get detail
  getSessionData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool isLogin =
    sp.getBool('is_login') != null ? sp.getBool("is_login")! : false;
    Timer(const Duration(seconds: 8), () {
      STM().finishAffinity(
        context,
        isLogin
            ? Profile()
            : SignIn(),
      );
    });
  }
}
