import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'aboutus.dart';
import 'contactus.dart';
import 'documents.dart';
import 'edit_profile.dart';
import 'manage/app_url.dart';
import 'manage/static_method.dart';
import 'my_orders.dart';
import 'notification.dart';
import 'sign_in.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

// void main() => runApp(Profile());

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late BuildContext ctx;
  String? name;
  String? email;
  String? mobile;

  final Uri _url = Uri.parse('https://autoscal.in/privacy');
  final Uri refund = Uri.parse('https://autoscal.in/refund');
  final Uri _urlterms = Uri.parse('https://autoscal.in/terms');
  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $_url';
    }
  }
  void getProfileData() async {
    load(context);
    SharedPreferences sp = await SharedPreferences.getInstance();
    final status = await OneSignal.shared.getDeviceState();
    var dio = Dio();
    final formdata = FormData.fromMap({
      "user_id": sp.getString("user_id"),
      "uuid": status?.userId,
    });
    var response = await dio.post(profileGetUrl(), data: formdata);
    if (globalDebugMode()) {
      print(response);
    }
    final result = response.data;
    dismissLoad(context);
    // if(result['error'] != true){
    setState(() {});
    setState(() {
      name = result['name'];
      email = result['email'];
      mobile = result['mobile'];
    });

    // }
    // else{
    //   errorAlert(context, result['message'].toString());
    // }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getProfileData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffffffff),
        // leading: InkWell(
        //   onTap: () {
        //     STM().back2Previous(ctx);
        //   },
        //   child: Icon(
        //     Icons.arrow_back_ios,
        //     color: Color(0xff2E135D),
        //   ),
        // ),
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              foreground: Paint()
                ..shader = Sty().linearGradient.createShader(Rect.fromLTWH(0.0, 35.0, 200.0, 70.0))),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name.toString(),
                          style: Sty().mediumText.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        InkWell(
                          onTap: () {
                            STM().redirect2page(ctx, EditProfile());
                          },
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: SvgPicture.asset('assets/edit.svg')),
                        ),
                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Image.asset('assets/car.png'),
                        // ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: Sty().linearGradient,
                        ),
                        width: 20,
                        height: 4,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: SvgPicture.asset("assets/mail (2).svg")),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(Dim().d8),
                          child: Text(email.toString()),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: SvgPicture.asset("assets/call (8).svg")),
                      SizedBox(
                        width: Dim().d4,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(Dim().d8),
                          child: Text(mobile.toString()),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dim().d20)
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Card(
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {
                          STM().redirect2page(ctx, Documents());
                        },
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: SvgPicture.asset(
                                'assets/docs.svg',
                                color: Color(0xffE88B6B),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Text(
                                'Documents',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child:
                                    Icon(Icons.arrow_forward_ios_rounded),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          STM().redirect2page(ctx, Notifications());
                        },
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: SvgPicture.asset(
                                'assets/bell.svg',
                                  color: Color(0xffE88B6B),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Text(
                                'Notifications',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Expanded(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                        Icons.arrow_forward_ios_rounded)))
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          STM().redirect2page(ctx, MyOrder());
                        },
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: SvgPicture.asset(
                                'assets/order.svg',
                                color: Color(0xffE88B6B),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Text(
                                'My Leads',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Expanded(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                        Icons.arrow_forward_ios_rounded)))
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          STM().redirect2page(ctx, Contactus());
                        },
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: SvgPicture.asset(
                                'assets/phone.svg',
                                height: Dim().d20,
                                color: Color(0xffE88B6B),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Text(
                                'Contact Us',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Expanded(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                        Icons.arrow_forward_ios_rounded)))
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          _launchUrl(_url);
                        },
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: SvgPicture.asset(
                                'assets/privacy.svg',
                                height: Dim().d20,
                                color: Color(0xffE88B6B),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Text(
                                'Privacy Policy',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Expanded(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                        Icons.arrow_forward_ios_rounded)))
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          _launchUrl(refund);
                        },
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: SvgPicture.asset(
                                'assets/refund.svg',
                                height: Dim().d20,
                                color: Color(0xffE88B6B),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                'Refund Policy',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Expanded(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                        Icons.arrow_forward_ios_rounded)))
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          _launchUrl(_urlterms);
                        },
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: SvgPicture.asset(
                                'assets/terms.svg',
                                height: Dim().d20,
                                color: Color(0xffE88B6B),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                'Terms & Condition',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Expanded(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                        Icons.arrow_forward_ios_rounded),),),
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          STM().redirect2page(ctx, Aboutus());
                        },
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: SvgPicture.asset(
                                'assets/about.svg',
                                height: Dim().d20,
                                color: Color(0xffE88B6B),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                'About Us',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Expanded(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                        Icons.arrow_forward_ios_rounded)))
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          setLoginFalse();
                          STM().gotoPage(ctx, SignIn());
                        },
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: SvgPicture.asset(
                                'assets/log_out.svg',
                                color: Color(0xffE88B6B),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Text(
                                'Log Out',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Expanded(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                        Icons.arrow_forward_ios_rounded)))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
