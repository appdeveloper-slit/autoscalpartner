import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'manage/app_url.dart';
import 'values/colors.dart';

import 'manage/static_method.dart';
import 'values/styles.dart';

// void main() => runApp(Notifications());

class Notifications extends StatefulWidget {
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  late BuildContext ctx;
  List<dynamic> notificationList = [];

  void getNotifications() async {
    load(context);
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("date", DateTime.now().toString());
    var dio = Dio();
    final formdata = FormData.fromMap({
      "user_id": sp.getString("user_id"),
    });
    var response = await dio.post(notificationsUrl(), data: formdata);
    if (globalDebugMode()) {
      print(response);
    }
    final result = response.data;
    dismissLoad(context);
    // if(result['error'] != true){
    setState(() {
      notificationList = result;
    });
    // }
    // else{
    //   errorAlert(context, result['message'].toString());
    // }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getNotifications();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;

    return Scaffold(
      // bottomNavigationBar: bottomBarLayout(ctx, 0),
      appBar: AppBar(
        backgroundColor: Color(0xffffffff),
        leading: InkWell(
          onTap: () {
            STM().back2Previous(ctx);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Color(0xff2E135D),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Notifications',
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
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: notificationList.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Card(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notificationList[index]['title'].toString(),
                                  style: Sty().mediumText.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  notificationList[index]['message'].toString(),
                                  style: Sty().mediumText.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  notificationList[index]['created_at']
                                      .toString(),
                                  style: Sty().mediumText.copyWith(
                                      fontSize: 12, color: Clr().grey),
                                ),
                              ],
                            ),
                          )),
                          // SvgPicture.asset('assets/call.svg')
                        ],
                      )
                    ],
                  ),
                ));
              },
            )
          ],
        ),
      ),
    );
  }
}
