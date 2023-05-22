import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'manage/app_url.dart';
import 'manage/static_method.dart';
import 'notification.dart';
import 'order_details.dart';
import 'profile.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/strings.dart';
import 'values/styles.dart';

// void main() => runApp(MyOrder());

class MyOrder extends StatefulWidget {
  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  late BuildContext ctx;
  int selected = 1;
  List<dynamic> ongoingOrder = [];
  List<dynamic> completedOrder = [];
  int? notificationCount;
  var id;

  void myorders() async {
    //Input
    SharedPreferences sp = await SharedPreferences.getInstance();
    FormData body = FormData.fromMap({
      "user_id": sp.getString("user_id"),
      'date': sp.getString('date') ?? "0000-00-00 00:00:00"
    });
    if (!mounted) return;
    var result =
        await STM().post(ctx, Str().processing, "partner_orders", body);
    var error = result['error'];
    if (!error) {
      setState(() {
        ongoingOrder = result['ongoing_order'];
        completedOrder = result['completed_order'];
        notificationCount = result['count'];
      });
    } else {
      errorAlert(context, "Something went wrong (Server 500)");
    }
  }

  initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        myorders();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    Widget orderCard(ctx, index, list) {
      return Container(
        margin: EdgeInsets.only(top: 10),
        child: InkWell(
          onTap: () {
            STM().redirect2page(
              ctx,
              OrderDetail(list[index]['id'].toString(), list[index]['flag']),
            );
            print(list[index]['id'].toString());
          },
          child: Container(
            // margin: const EdgeInsets.all(0),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xffE4DFDF)),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(Dim().d8),
                              child: Text('Name'),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(':'),
                          SizedBox(
                            width: 40,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(Dim().d8),
                              child: Text(list[index]['seller_name']),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(Dim().d8),
                              child: Text('Lead ID'),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(':'),
                          SizedBox(
                            width: 40,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(Dim().d8),
                              child: Text('${list[index]['order_no']}'),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(Dim().d8),
                              child: Text('Status'),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(':'),
                          SizedBox(
                            width: 40,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(Dim().d8),
                              child: Text(
                                '${list[index]['status']}',
                                style: Sty().mediumText.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: list[index]['status'] == 'Ongoing'
                                          ? Clr().ongoingcolor
                                          : list[index]['status'] == 'Pending'
                                              ? Clr().pendingcolor
                                              : list[index]['status'] ==
                                                      'Rejected'
                                                  ? Clr().pendingcolor
                                                  : list[index]['status'] ==
                                                          'Completed'
                                                      ? Clr().completedcolor
                                                      : list[index]['status'] ==
                                                              'Under Review'
                                                          ? Clr().ongoingcolor
                                                          : Clr().black,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(Dim().d8),
                              child: Text('Brand'),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(':'),
                          SizedBox(
                            width: 40,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(Dim().d8),
                              child: Text(list[index]['brand']),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(Dim().d8),
                              child: Text('Model'),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(':'),
                          SizedBox(
                            width: 40,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(Dim().d8),
                              child: Text(list[index]['model_no']),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(Dim().d8),
                              child: Text('Contact'),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(':'),
                          SizedBox(
                            width: 40,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(Dim().d8),
                              child: Text(list[index]['contact_no'].toString()),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Dim().d8),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffffffff),
        leading: Container(
          margin: EdgeInsets.only(left: Dim().d12),
          child: Image.asset(
            'assets/profilelogo.png',
            fit: BoxFit.fitWidth,
            // height: 20,
            // width: 20,
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: Dim().d20),
            child: GestureDetector(
              onTap: () {
                STM().redirect2page(ctx, Profile());
              },
              child: SvgPicture.asset('assets/homeuser.svg',
                  height: Dim().d20, color: Color(0xffE88B6B)),
            ),
          ),
          Container(
            child: GestureDetector(
              onTap: () {
                STM().redirect2page(ctx, Notifications());
              },
              child: notificationCount != 0
                  ? SvgPicture.asset('assets/notification1.svg',
                      height: Dim().d20, color: Color(0xffE88B6B))
                  : SvgPicture.asset('assets/Notification.svg',
                      height: Dim().d20, color: Color(0xffE88B6B)),
            ),
          ),
          SizedBox(width: Dim().d20),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    // STM().redirect2page(ctx, ExteriorBackSide());
                    setState(() {
                      selected = 1;
                      print("set 1");
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Dim().d16, horizontal: Dim().d20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffE88B6B)),
                      gradient: selected == 1
                          ? Sty().linearGradient
                          : LinearGradient(
                              colors: [Colors.white, Colors.white]),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          bottomLeft: Radius.circular(4)),
                    ),
                    child: Text(
                      'Ongoing Lead',
                      style: Sty().mediumText.copyWith(
                          color:
                              selected == 1 ? Clr().white : Color(0xffE88B6B),
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // STM().redirect2page(ctx, Interior());
                    setState(() {
                      selected = 2;
                      print("set 2");
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Dim().d16, horizontal: Dim().d20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffE88B6B)),
                      gradient: selected == 2
                          ? Sty().linearGradient
                          : LinearGradient(
                              colors: [Colors.white, Colors.white]),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(4),
                          bottomRight: Radius.circular(4)),
                    ),

                    child: Text(
                      'Completed Lead',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: selected == 2 ? Clr().white : Color(0xffE88B6B),
                      ),
                    ),
                    // child: Text(
                    //   'Completed Order',
                    //   style: Sty().mediumText.copyWith(
                    //       color: Clr().white,
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w400),
                    // ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 20,
            ),
            // for(int i = 0; i < 10; i++) orderCard("sf","sf","sdfsd","sdf","sdfsdf")
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount:
                    selected == 1 ? ongoingOrder.length : completedOrder.length,
                itemBuilder: (context, index) {
                  if (selected == 1) {
                    return orderCard(ctx, index, ongoingOrder);
                  } else if (selected == 2) {
                    return orderCard(ctx, index, completedOrder);
                  }
                  return Container(
                    child: Text(""),
                  );
                })
          ],
        ),
      ),
    );
  }
}
