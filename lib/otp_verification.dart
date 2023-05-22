import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'manage/app_url.dart';
import 'manage/static_method.dart';

import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/strings.dart';
import 'values/styles.dart';

import 'profile.dart';

// void main() => runApp(OTPVerification());

class OTPVerification extends StatefulWidget {
  String? mobileNumber;
  String? pageType;

  OTPVerification(this.mobileNumber, this.pageType);

  @override
  State<OTPVerification> createState() =>
      _OTPVerificationState(mobileNumber, pageType);
}

class _OTPVerificationState extends State<OTPVerification> {
  late BuildContext ctx;
  String? mobileNumber;
  String? pageType;

  _OTPVerificationState(this.mobileNumber, this.pageType);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController otpCtrl = TextEditingController();

  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  void resendOTP() async {
    if (pageType == "register") {
      load(context);
      SharedPreferences sp = await SharedPreferences.getInstance();
      var dio = Dio();
      final formdata = FormData.fromMap(
          {"mobile": mobileNumber.toString(), "page_type": "register"});
      var response = await dio.post(resendOTPUrl(), data: formdata);
      if (globalDebugMode()) {
        print(response);
      }
      final result = response.data;
      dismissLoad(context);

      if (result['error'] != true) {
        alert(context, result['message'].toString());
      } else {
        errorAlert(context, result['message'].toString());
      }
    } else {}
  }

  void verifyOTP() async {
    if (pageType == "login") {
      load(context);
      SharedPreferences sp = await SharedPreferences.getInstance();
      var dio = Dio();
      final formdata = FormData.fromMap(
          {"mobile": mobileNumber.toString(), "otp": otpCtrl.text});
      var response = await dio.post(verifyOTPUrl(), data: formdata);
      if (globalDebugMode()) {
        print(response);
      }
      final result = response.data;
      dismissLoad(context);
      if (result['error'] != true) {
        sp.setBool("is_login", true);
        sp.setString("user_id", result['user_id'].toString());
        STM().gotoPage(context, Profile());
      } else {
        errorAlert(context, result['message'].toString());
      }
    } else {}
  }

  bool sendload = true;
  var periodicTimer;
  int totaltime = 60;
  bool resendEnabled = false;
  bool shouldStop = true;

  void resetTimer() {
    setState(() {
      totaltime = 60;
      resendEnabled = false;
      shouldStop = true;
    });
  }

  void resendOtpTimer() {
    shouldStop = false;

    periodicTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // Update user about remaining time
      setState(() {
        if (timer.isActive) {
          if (globalDebugMode()) {
            // print("Timer Active...");
          }
          if (shouldStop) {
            timer.cancel();
          }
        }
        if (totaltime <= 0) {
          resendEnabled = true;
          shouldStop = true;
          totaltime = 0;
        } else {
          totaltime--;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (globalDebugMode()) {
      // print("[i] Disposing timer periodic....");
    }
    periodicTimer?.cancel();
    if (globalDebugMode()) {
      // print("[+] Dispose executed...");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    resendOtpTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Clr().transparent,
              leading: InkWell(
                  onTap: () {
                    STM().back2Previous(ctx);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xff2E135D),
                  )),
            ),
            body: SingleChildScrollView(
                child: Form(
              key: formKey,
              child: Padding(
                  padding: EdgeInsets.all(Dim().d16),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Verification',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            foreground: Paint()
                              ..shader =  Sty().linearGradient.createShader(
                                  Rect.fromLTWH(0.0, 35.0, 200.0, 70.0))),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              'We’ve sent you the verification code on $mobileNumber',
                              style: Sty()
                                  .largeText
                                  .copyWith(fontWeight: FontWeight.w400))),
                      SizedBox(
                        height: 30,
                      ),
                      PinCodeTextField(
                        controller: otpCtrl,
                        errorAnimationController: errorController,
                        appContext: context,
                        enableActiveFill: true,
                        textStyle: Sty().largeText,
                        length: 4,
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        animationType: AnimationType.scale,
                        cursorColor: Clr().primaryColor,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(Dim().d4),
                          fieldWidth: Dim().d60,
                          fieldHeight: Dim().d56,
                          selectedFillColor: Clr().transparent,
                          activeFillColor: Clr().transparent,
                          inactiveFillColor: Clr().transparent,
                          inactiveColor: Clr().lightGrey,
                          activeColor: Clr().black,
                          selectedColor: Clr().lightGrey,
                        ),
                        animationDuration: const Duration(milliseconds: 200),
                        onChanged: (value) {},
                        // validator: (value) {
                        //   if (value!.isEmpty ||
                        //       !RegExp(r'(.{4,})').hasMatch(value)) {
                        //     return "Enter an OTP";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: InkWell(
                          onTap: () {
                            // STM().redirect2page(ctx, ResetPassword());
                            // if(formKey.currentState!.validate()){
                            if (otpCtrl.text.isNotEmpty) {
                              verifyOTP();
                            } else {
                              alert(context, "Please enter otp.");
                            }

                            // }
                            // else{
                            //   print("Something went wrong");
                            // }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: Dim().d16, horizontal: Dim().d52),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment(0, 2),
                                colors: [Color(0xFFED4120), Color(0xFFE48260)],
                              ),
                              borderRadius: BorderRadius.circular(
                                Dim().d4,
                              ),
                            ),
                            margin: EdgeInsets.all(0),
                            child: Text(
                              'Continue',
                              style: Sty().mediumText.copyWith(
                                    color: Clr().white,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      if (!resendEnabled)
                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              // STM().redirect2page(ctx, ForgetPassword());
                            },
                            child: RichText(
                                text: TextSpan(
                                    text: (totaltime == 60)
                                        ? '01:00'
                                        : (totaltime < 10)
                                            ? '00:0$totaltime'
                                            : '00:$totaltime',
                                    style: Sty().mediumBoldText.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF69A9F0)))),
                          ),
                        ),
                      SizedBox(
                        height: 8,
                      ),
                      if (resendEnabled)
                        GestureDetector(
                          onTap: () {
                            // STM().redirect2page(ctx, ForgetPassword());
                            resendOTP();
                            resetTimer();
                            resendOtpTimer();
                          },
                          child: RichText(
                            text: TextSpan(
                              text: "Didn't get it?",
                              style: Sty().smallText.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Resend OTP',
                                  style: Sty().smallText.copyWith(
                                      color: Color(0xFF69A9F0),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  )),
            ))));
  }
}
