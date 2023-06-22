import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:quick_room_services/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gradient_progress_indicator/gradient_progress_indicator.dart';
import '../values/colors.dart';
import '../values/dimens.dart';
import '../values/styles.dart';
import 'app_url.dart';

bool globalDebugMode() {
  // Debug log
  // true => ON
  // false => OFF
  return true;
}

void log(printable) {
  if (globalDebugMode()) {
    print(printable);
  }
}

String? sPicture1Img, sPicture2Img, sPicture3Img;

void load(BuildContext context) {
  showDialog(
      barrierDismissible: false,
      barrierColor: Color.fromARGB(0, 0, 0, 0),
      context: context,
      builder: (context) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5, color: Colors.grey),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(30),
                  child: Container(
                    width: Dim().d100,
                    child: GradientProgressIndicator(
                      radius: 30,
                      duration: 1,
                      strokeWidth: 8.0,
                      gradientStops: const [
                        0.2,
                        100.0,
                      ],
                      gradientColors: [
                        Color(0xffED4120),
                        Color(0xffE48260),
                      ],
                      child: Text(''),
                    ),
                  )
                  // CircularProgressIndicator(
                  //     valueColor: ,
                  //     color: Colors.black,
                  //     strokeWidth: 8.0,
                  //   ),
                  ),
            ],
          ),
        );
      });
}

void dismissLoad(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}

void bottomAlert(BuildContext context, String message) {
  var sn = SnackBar(content: Text(message.toString()));
  ScaffoldMessenger.of(context).showSnackBar(sn);
}

void alert(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Alert",
            style: TextStyle(
              foreground: Paint()
                // ignore: prefer_const_constructors
                ..shader = LinearGradient(
                  colors: [Color(0xffB81736), Color(0xff2E135D)],
                  begin: Alignment.centerLeft,
                  end: Alignment.bottomRight,
                ).createShader(
                  const Rect.fromLTWH(0.0, 0.0, 320.0, 80.0),
                ),
            ),
          ),
          content: Text(message.toString()),
          elevation: 0,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "OK",
                  style: TextStyle(
                    foreground: Paint()
                      // ignore: prefer_const_constructors
                      ..shader = LinearGradient(
                        colors: [Color(0xffB81736), Color(0xff2E135D)],
                        begin: Alignment.centerLeft,
                        end: Alignment.bottomRight,
                      ).createShader(
                        const Rect.fromLTWH(0.0, 0.0, 320.0, 80.0),
                      ),
                  ),
                ))
          ],
        );
      });
}
void alertmsg(BuildContext context, String message,widget) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Alert",
            style: TextStyle(
              foreground: Paint()
              // ignore: prefer_const_constructors
                ..shader = LinearGradient(
                  colors: [Color(0xffB81736), Color(0xff2E135D)],
                  begin: Alignment.centerLeft,
                  end: Alignment.bottomRight,
                ).createShader(
                  const Rect.fromLTWH(0.0, 0.0, 320.0, 80.0),
                ),
            ),
          ),
          content: Text(message.toString()),
          elevation: 0,
          actions: [
            TextButton(
                onPressed: () {
                  STM().redirect2page(context, widget);
                },
                child: Text(
                  "OK",
                  style: TextStyle(
                    foreground: Paint()
                    // ignore: prefer_const_constructors
                      ..shader = LinearGradient(
                        colors: [Color(0xffB81736), Color(0xff2E135D)],
                        begin: Alignment.centerLeft,
                        end: Alignment.bottomRight,
                      ).createShader(
                        const Rect.fromLTWH(0.0, 0.0, 320.0, 80.0),
                      ),
                  ),
                ))
          ],
        );
      });
}
void errorAlert(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Error",
            style: TextStyle(
              foreground: Paint()
                // ignore: prefer_const_constructors
                ..shader = LinearGradient(
                  colors: [Color(0xffB81736), Color(0xff2E135D)],
                  begin: Alignment.centerLeft,
                  end: Alignment.bottomRight,
                ).createShader(
                  const Rect.fromLTWH(0.0, 0.0, 320.0, 80.0),
                ),
            ),
          ),
          content: Text(message.toString()),
          elevation: 0,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "OK",
                  style: TextStyle(
                    foreground: Paint()
                      // ignore: prefer_const_constructors
                      ..shader = LinearGradient(
                        colors: [Color(0xffB81736), Color(0xff2E135D)],
                        begin: Alignment.centerLeft,
                        end: Alignment.bottomRight,
                      ).createShader(
                        const Rect.fromLTWH(0.0, 0.0, 320.0, 80.0),
                      ),
                  ),
                ))
          ],
        );
      });
}


void successAlert(BuildContext context, String message, widget) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Success",
            style: TextStyle(
              foreground: Paint()
              // ignore: prefer_const_constructors
                ..shader = Sty().linearGradient.createShader(
                  const Rect.fromLTWH(0.0, 0.0, 320.0, 80.0),
                ),
            ),
          ),
          content: Text(message.toString()),
          elevation: 0,
          actions: [
            TextButton(
                onPressed: () {
                  STM().finishAffinity(context, widget);
                },
                child: Text(
                  "OK",
                  style: TextStyle(
                    foreground: Paint()
                    // ignore: prefer_const_constructors
                      ..shader = LinearGradient(
                        colors: [Color(0xffB81736), Color(0xff2E135D)],
                        begin: Alignment.centerLeft,
                        end: Alignment.bottomRight,
                      ).createShader(
                        const Rect.fromLTWH(0.0, 0.0, 320.0, 80.0),
                      ),
                  ),
                ),)
          ],
        );
      });
}

Future<bool> getLoginSession() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  bool isLogin =
      sp.getBool('is_login') != null ? sp.getBool("is_login")! : false;
  bool isID = sp.getString('user_id') != null ? true : false;
  return isLogin;
}

void setLoginTrue() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.setBool('is_login', true);
}

void setLoginFalse() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.setBool('is_login', false);
}

void checkLoginAndGotoHome(context) async {
  if (await getLoginSession()) {
    log("User is login : true");
    STM().redirect2page(context, Profile());
  } else {
    log("User is login : false");
  }
}

class STM {
  void redirect2page(BuildContext context, Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  void replacePage(BuildContext context, Widget widget) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => widget,
      ),
    );
  }

  void back2Previous(BuildContext context) {
    Navigator.pop(context);
  }

  void gotoPage(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => widget,
      ),
      (route) => false,
    );
  }

  void displayToast(String string) {
    Fluttertoast.showToast(msg: string, toastLength: Toast.LENGTH_SHORT);
  }

  openWeb(String url) async {
    await launchUrl(Uri.parse(url.toString()));
  }

  void finishAffinity(final BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => widget,
      ),
      (Route<dynamic> route) => false,
    );
  }

  void successDialog(context, message, widget) {
    AwesomeDialog(
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.SCALE,
            headerAnimationLoop: true,
            title: 'Success',
            desc: message,
            btnOkText: "OK",
            btnOkOnPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => widget),
              );
            },
            btnOkColor: Clr().successGreen)
        .show();
  }

  AwesomeDialog successWithButton(context, message, function) {
    return AwesomeDialog(
        dismissOnBackKeyPress: false,
        dismissOnTouchOutside: false,
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.SCALE,
        headerAnimationLoop: true,
        title: 'Success',
        desc: message,
        btnOkText: "OK",
        btnOkOnPress: function,
        btnOkColor: Clr().successGreen);
  }

  void successDialogWithAffinity(
      BuildContext context, String message, Widget widget) {
    AwesomeDialog(
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.SCALE,
            headerAnimationLoop: true,
            title: 'Success',
            desc: message,
            btnOkText: "OK",
            btnOkOnPress: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => widget,
                ),
                (Route<dynamic> route) => false,
              );
            },
            btnOkColor: Clr().successGreen)
        .show();
  }

  void successDialogWithReplace(
      BuildContext context, String message, Widget widget) {
    AwesomeDialog(
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.SCALE,
            headerAnimationLoop: true,
            title: 'Success',
            desc: message,
            btnOkText: "OK",
            btnOkOnPress: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => widget,
                ),
              );
            },
            btnOkColor: Clr().successGreen)
        .show();
  }

  void errorDialog(BuildContext context, String message) {
    AwesomeDialog(
            context: context,
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            dialogType: DialogType.ERROR,
            animType: AnimType.SCALE,
            headerAnimationLoop: true,
            title: 'Note',
            desc: message,
            btnOkText: "OK",
            btnOkOnPress: () {},
            btnOkColor: Clr().errorRed)
        .show();
  }

  void errorDialogWithReplace(
      BuildContext context, String message, Widget widget) {
    AwesomeDialog(
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.SCALE,
            headerAnimationLoop: true,
            title: 'Note',
            desc: message,
            btnOkText: "OK",
            btnOkOnPress: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => widget,
                ),
              );
            },
            btnOkColor: Clr().errorRed)
        .show();
  }

  AwesomeDialog loadingDialog(BuildContext context, String title) {
    AwesomeDialog dialog = AwesomeDialog(
      width: 250,
      context: context,
      dismissOnBackKeyPress: true,
      dismissOnTouchOutside: false,
      dialogType: DialogType.NO_HEADER,
      animType: AnimType.SCALE,
      body: WillPopScope(
        onWillPop: () async {
          displayToast('Something went wrong try again.');
          return true;
        },
        child: Container(
          height: Dim().d160,
          padding: EdgeInsets.all(Dim().d16),
          decoration: BoxDecoration(
            color: Clr().white,
            borderRadius: BorderRadius.circular(Dim().d32),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(Dim().d12),
                child: SpinKitCubeGrid(
                  color: Clr().primaryColor,
                ),
              ),
              SizedBox(
                height: Dim().d16,
              ),
              Text(
                title,
                style: Sty().mediumBoldText,
              ),
            ],
          ),
        ),
      ),
    );
    return dialog;
  }

  void alertDialog(context, message, widget) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        AlertDialog dialog = AlertDialog(
          title: Text(
            "Confirmation",
            style: Sty().largeText,
          ),
          content: Text(
            message,
            style: Sty().smallText,
          ),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {},
            ),
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
        return dialog;
      },
    );
  }

  AwesomeDialog modalDialog(context, widget, color) {
    AwesomeDialog dialog = AwesomeDialog(
      dialogBackgroundColor: color,
      context: context,
      dialogType: DialogType.NO_HEADER,
      animType: AnimType.SCALE,
      body: widget,
    );
    return dialog;
  }

  void mapDialog(BuildContext context, Widget widget) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.NO_HEADER,
      padding: EdgeInsets.zero,
      animType: AnimType.SCALE,
      body: widget,
      btnOkText: 'Done',
      btnOkColor: Clr().successGreen,
      btnOkOnPress: () {},
    ).show();
  }

  Widget setSVG(name, size, color) {
    return SvgPicture.asset(
      'assets/$name.svg',
      height: size,
      width: size,
      color: color,
    );
  }

  Widget emptyData(message) {
    return Center(
      child: Text(
        message,
        style: Sty().smallText.copyWith(
              color: Clr().primaryColor,
              fontSize: 18.0,
            ),
      ),
    );
  }

  List<BottomNavigationBarItem> getBottomList(index) {
    return [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/bn_home.svg",
        ),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/bn_tv.svg",
        ),
        label: 'Live T.V.',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/bn_short.svg",
        ),
        label: 'Shorts',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/bn_event.svg",
        ),
        label: 'Events',
      ),
    ];
  }

  //Dialer
  Future<void> openDialer(String phoneNumber) async {
    Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(Uri.parse(launchUri.toString()));
  }

  //WhatsApp
  Future<void> openWhatsApp(String phoneNumber) async {
    if (Platform.isIOS) {
      await launchUrl(Uri.parse("whatsapp:wa.me/$phoneNumber"));
    } else {
      await launchUrl(Uri.parse("whatsapp:send?phone=$phoneNumber"));
    }
  }

  Future<bool> checkInternet(context, widget) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      internetAlert(context, widget);
      return false;
    }
  }

  internetAlert(context, widget) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.NO_HEADER,
      animType: AnimType.SCALE,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      body: Padding(
        padding: EdgeInsets.all(Dim().d20),
        child: Column(
          children: [
            // SizedBox(child: Lottie.asset('assets/no_internet_alert.json')),
            Text(
              'Connection Error',
              style: Sty().largeText.copyWith(
                    color: Clr().primaryColor,
                    fontSize: 18.0,
                  ),
            ),
            SizedBox(
              height: Dim().d8,
            ),

            Text(
              'No Internet connection found.',
              style: Sty().smallText,
            ),
            SizedBox(
              height: Dim().d32,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: Sty().primaryButton,
                onPressed: () {
                  STM().checkInternet(context, widget).then((value) {
                    if (value) {
                      Navigator.pop(context);
                      STM().replacePage(context, widget);
                    }
                  });
                },
                child: Text(
                  "Try Again",
                  style: Sty().largeText.copyWith(
                        color: Clr().white,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    ).show();
  }

  String dateFormat(format, date) {
    return DateFormat(format).format(date).toString();
  }

  Future<dynamic> get(ctx, title, name) async {
    //Dialog
    AwesomeDialog dialog = STM().loadingDialog(ctx, title);
    dialog.show();
    Dio dio = Dio(
      BaseOptions(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.plain,
      ),
    );
    String url = AppUrl.mainUrl + name;
    dynamic result;
    try {
      Response response = await dio.get(url);
      if (kDebugMode) {
        print("Url = $url\nResponse = $response");
      }
      if (response.statusCode == 200) {
        dialog.dismiss();
        result = json.decode(response.data.toString());
      }
    } on DioError catch (e) {
      dialog.dismiss();
      STM().errorDialog(ctx, e.message);
    }
    return result;
  }

  Future<dynamic> getWithoutDialog(ctx, name) async {
    Dio dio = Dio(
      BaseOptions(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.plain,
      ),
    );
    String url = AppUrl.mainUrl + name;
    dynamic result;
    try {
      Response response = await dio.get(url);
      if (kDebugMode) {
        print("Url = $url\nResponse = $response");
      }
      if (response.statusCode == 200) {
        result = json.decode(response.data.toString());
      }
    } on DioError catch (e) {
      STM().errorDialog(ctx, e.message);
    }
    return result;
  }

  Future<dynamic> post(ctx, title, name, body) async {
    //Dialog
    // AwesomeDialog dialog = STM().loadingDialog(ctx, title);
    // dialog.show();
    load(ctx);
    Dio dio = Dio(
      BaseOptions(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.plain,
      ),
    );
    String url = AppUrl.mainUrl + name;
    if (kDebugMode) {
      print("Url = $url\nBody = ${body.fields}");
    }
    dynamic result;
    try {
      Response response = await dio.post(url, data: body);
      if (kDebugMode) {
        print("Response = $response");
      }
      if (response.statusCode == 200) {
        // dialog.dismiss();
        Navigator.of(ctx).pop();
        result = json.decode(response.data.toString());
      }
    } on DioError catch (e) {
      // dialog.dismiss();
      Navigator.of(ctx).pop();
      STM().errorDialog(ctx, e.message);
    }
    return result;
  }

  Future<dynamic> postWithoutDialog(ctx, name, body) async {
    //Dialog
    Dio dio = Dio(
      BaseOptions(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.plain,
      ),
    );
    String url = AppUrl.mainUrl + name;
    dynamic result;
    try {
      Response response = await dio.post(url, data: body);
      if (kDebugMode) {
        print("Url = $url\nBody = ${body.fields}\nResponse = $response");
      }
      if (response.statusCode == 200) {
        result = json.decode(response.data.toString());
      }
    } on DioError catch (e) {
      STM().errorDialog(ctx, e.message);
    }
    return result;
  }

  Widget loadingPlaceHolder() {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 0.6,
        color: Clr().primaryColor,
      ),
    );
  }
}
