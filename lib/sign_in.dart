import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'manage/static_method.dart';
import 'otp_verification.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/strings.dart';
import 'values/styles.dart';

// void main() => runApp(SignIn());

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late BuildContext ctx;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController mobileCtrl = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    checkLoginAndGotoHome(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;

    return Scaffold(
        backgroundColor: Image.asset('images/bg_car.png').color,
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.all(Dim().d16),
              child: Column(children: [
                SizedBox(
                  height: 80,
                ),
                Text(
                  'Welcome Back',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      foreground: Paint()
                        ..shader = Sty().linearGradient.createShader(Rect.fromLTWH(0.0, 35.0, 200.0, 70.0))),
                ),
                SizedBox(
                  height: 70,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Enter Mobile Number',
                        style: Sty()
                            .largeText
                            .copyWith(fontWeight: FontWeight.w500))),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  maxLength: 10,
                  keyboardType: TextInputType.phone,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  textInputAction: TextInputAction.done,
                  controller: mobileCtrl,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    // label: Text('Enter Your Number'),
                    hintText: "Enter Mobile Number",

                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Clr().black,
                        )),
                  ),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'([5-9]{1}[0-9]{9})').hasMatch(value)) {
                      return Str().invalidMobile;
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: Dim().d20),
                InkWell(
                  onTap: () {
                    // STM().redirect2page(ctx, OTPVerification());
                    if (formKey.currentState!.validate()) {
                      STM().checkInternet(context, widget).then((value) {
                        if (value) {
                          sendOtp();
                        }
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Dim().d16, horizontal: Dim().d48),
                    decoration: BoxDecoration(
                      gradient: Sty().linearGradient,
                      borderRadius: BorderRadius.circular(
                        Dim().d4,
                      ),
                    ),

                    child: Text(
                      'Send OTP',
                      style: Sty().mediumText.copyWith(
                          color: Clr().white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     // STM().redirect2page(ctx, Register());
                //   },
                //   child: RichText(
                //     text: TextSpan(
                //       text: 'Don’t have an account? ',
                //       style: Sty().smallText.copyWith(
                //           fontSize: 16,
                //           fontWeight: FontWeight.w400
                //       ),
                //       children: <TextSpan>[
                //         TextSpan(
                //           text: 'Sign Up',
                //           style: Sty().smallText.copyWith(
                //             color: Color(0xFF2D135B),
                //             fontWeight: FontWeight.w600,
                //             fontSize: 16,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ]),
            ),
          ),
        ),
      );
  }

  //Api method
  void sendOtp() async {
    //Input
    FormData body = FormData.fromMap({
      'page_type': "login",
      'mobile': mobileCtrl.text,
    });
    //Output
    var result = await STM().post(ctx, Str().sendingOtp, "partner_sendOtp", body);
    if (!mounted) return;
    if (!result['error']) {
      STM().redirect2page(
        ctx,
        OTPVerification(mobileCtrl.text.toString(), "login"),
      );
    } else {
      var message = result['message'];
      STM().errorDialog(ctx, message);
    }
  }
}
