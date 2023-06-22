import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Inspection.dart';
import 'manage/static_method.dart';
import 'my_orders.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/strings.dart';
import 'values/styles.dart';

class OrderDetail extends StatefulWidget {
  final String sOrderID;
  final bool flag;

  const OrderDetail(this.sOrderID, this.flag, {Key? key}) : super(key: key);

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  late BuildContext ctx;
  bool isLoaded = false;
  dynamic resultData;

  @override
  initState() {
    Future.delayed(Duration.zero, () {
      getData();
    });
    super.initState();
  }

  // Api Method
  getData() async {
    //Input
    FormData body = FormData.fromMap({
      'id': widget.sOrderID,
    });
    //Output
    var result =
        await STM().post(context, Str().loading, "order_details", body);
    if (!mounted) return;
    setState(() {
      isLoaded = true;
      resultData = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
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
          resultData != null ? '#${resultData['order_no']}' : "",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              foreground: Paint()
                ..shader = Sty().linearGradient.createShader(Rect.fromLTWH(0.0, 35.0, 200.0, 70.0))),
        ),
      ),
      body: resultData != null ? bodyLayout() : Container(),
    );
  }

  //Body
  Widget bodyLayout() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(0),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xffE4DFDF)),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ShaderMask(
                          child: SvgPicture.asset("assets/Car.svg"),
                          shaderCallback: (bounds) => Sty().linearGradient.createShader(Rect.fromLTWH(0, 0, 45, 45)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Dim().d8),
                        child: Text('Car Details',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: Dim().d8, bottom: Dim().d8),
                        child: Text('Brand'),
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(':'),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: Dim().d8, bottom: Dim().d8),
                        child: Text(resultData['brand']),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: Dim().d8, bottom: Dim().d8),
                        child: Text('Car Model'),
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(':'),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: Dim().d8, bottom: Dim().d8),
                        child: Text(resultData['model']),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: Dim().d8, bottom: Dim().d8),
                        child: Text('Manufacturing Year'),
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(':'),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: Dim().d8, bottom: Dim().d8),
                        child: Text(resultData['manfacturing_year']),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dim().d8)
              ],
            ),
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            margin: const EdgeInsets.all(0),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xffE4DFDF)),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ShaderMask(
                          child: SvgPicture.asset("assets/Car.svg"),
                          shaderCallback: (bounds) => Sty().linearGradient.createShader(Rect.fromLTWH(0, 0, 45, 45)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Dim().d8),
                        child: Text(
                          'Seller Details',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: Dim().d8, bottom: Dim().d8),
                        child: Text('Name'),
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(':'),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: Dim().d8, bottom: Dim().d8),
                        child: Text(resultData['seller_name']),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: Dim().d8, bottom: Dim().d8),
                        child: Text('Contact Number'),
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(':'),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: Dim().d8, bottom: Dim().d8),
                        child: Text(resultData['contact_no']),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dim().d8)
              ],
            ),
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            margin: const EdgeInsets.all(0),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xffE4DFDF)),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ShaderMask(
                          child: SvgPicture.asset("assets/location (2).svg"),
                          shaderCallback: (bounds) => Sty().linearGradient.createShader(Rect.fromLTWH(0, 0, 45, 45)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Dim().d8),
                        child: Text(
                          'Seller Address',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
                  child: Text(
                      '${resultData['landmark']},${resultData['house_no']},${resultData['state']},${resultData['pincode']}'),
                ),
                InkWell(
                  onTap: () {
                    MapsLauncher.launchQuery(
                        '${resultData['landmark']},${resultData['house_no']},${resultData['state']},${resultData['pincode']}');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(4),
                            bottomRight: Radius.circular(4)),
                        gradient: Sty().linearGradient),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: Dim().d8,
                              bottom: Dim().d8,
                              left: Dim().d12,
                              right: Dim().d12),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'View Map',
                                  style: TextStyle(
                                      color: Clr().white, fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                width: Dim().d200,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 22,
                                color: Clr().white,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          resultData['status'] == "Completed"
              ? Container(
                  margin: const EdgeInsets.all(0),
                  padding: EdgeInsets.all(
                    Dim().d20,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffE4DFDF)),
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Column(
                    children: [
                      Text(
                        'report status : ${resultData['document_status']}',
                        style: Sty().mediumText.copyWith(
                              fontWeight: FontWeight.bold,
                              color: resultData['document_status'] == 'Ongoing'
                                  ? Clr().ongoingcolor
                                  : resultData['document_status'] ==
                                          'Under Review'
                                      ? Clr().ongoingcolor
                                      : resultData['document_status'] ==
                                              'Pending'
                                          ? Clr().pendingcolor
                                          : resultData['document_status'] ==
                                                  'Rejected'
                                              ? Clr().pendingcolor
                                              : resultData['document_status'] ==
                                                      'Approved'
                                                  ? Clr().completedcolor
                                                  : resultData[
                                                              'document_status'] ==
                                                          'Under Review'
                                                      ? Clr().ongoingcolor
                                                      : Clr().black,
                            ),
                      )
                    ],
                  ),
                )
              : resultData['status'] == "Under Review"
                  ? Column(
                      children: [
                        resultData['document_status'] == "Rejected"
                            ? Padding(
                                padding: EdgeInsets.all(Dim().d20),
                                child: Container(
                                  margin: const EdgeInsets.all(0),
                                  padding: EdgeInsets.all(
                                    Dim().d20,
                                  ),
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xffE4DFDF)),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4))),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Reason : ${resultData['reason']}',
                                        style: Sty().mediumBoldText,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: Dim().d20, horizontal: Dim().d8),
                                child: Text(
                                  'Report Status : ${resultData['document_status']}',
                                  style: Sty().mediumText.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: resultData['document_status'] ==
                                                'Ongoing'
                                            ? Clr().ongoingcolor
                                            : resultData['document_status'] ==
                                                    'Under Review'
                                                ? Clr().ongoingcolor
                                                : resultData['document_status'] ==
                                                        'Pending'
                                                    ? Clr().pendingcolor
                                                    : resultData[
                                                                'document_status'] ==
                                                            'Rejected'
                                                        ? Clr().pendingcolor
                                                        : resultData[
                                                                    'document_status'] ==
                                                                'Completed'
                                                            ? Clr().completedcolor
                                                            : resultData[
                                                                        'document_status'] ==
                                                                    'Under Review'
                                                                ? Clr()
                                                                    .ongoingcolor
                                                                : Clr().black,
                                      ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                STM().redirect2page(
                                    ctx, Inspection(true, widget.sOrderID));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dim().d40, vertical: Dim().d20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                  gradient: Sty().linearGradient,
                                ),
                                child: Center(
                                  child: Text(
                                    'Edit',
                                    style: Sty()
                                        .mediumBoldText
                                        .copyWith(color: Clr().white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : resultData['flag']
                      ? Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  cancelorder();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: Dim().d16,
                                      horizontal: Dim().d52),
                                  decoration: BoxDecoration(
                                    gradient: Sty().linearGradient,
                                    borderRadius: BorderRadius.circular(
                                      Dim().d4,
                                    ),
                                  ),
                                  margin: EdgeInsets.only(right: 10),
                                  child: Center(
                                    child: Text(
                                      'Cancel',
                                      style: Sty().mediumText.copyWith(
                                          color: Clr().white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  STM().redirect2page(
                                      ctx, Inspection(false, widget.sOrderID));
                                  inspection();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: Dim().d16,
                                      horizontal: Dim().d60),
                                  decoration: BoxDecoration(
                                    gradient: Sty().linearGradient,
                                    borderRadius: BorderRadius.circular(
                                      Dim().d4,
                                    ),
                                  ),
                                  // margin: EdgeInsets.all(20),
                                  child: Center(
                                    child: Text(
                                      'Start',
                                      style: Sty().mediumText.copyWith(
                                          color: Clr().white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : InkWell(
                          onTap: () {
                            STM().redirect2page(
                                ctx, Inspection(false, widget.sOrderID));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: Dim().d16, horizontal: Dim().d60),
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
                            // margin: EdgeInsets.all(20),
                            child: Center(
                              child: Text(
                                'View Form',
                                style: Sty().mediumText.copyWith(
                                    color: Clr().white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
          // resultData['document_status'] == "Under Review"
          //     ? Column(
          //         children: [
          //           resultData['document_status'] == "Rejected"
          //               ?
          // Padding(
          //                         padding: EdgeInsets.all(Dim().d20),
          //                         child: Container(
          //                           margin: const EdgeInsets.all(0),
          //                           padding: EdgeInsets.all(
          //                             Dim().d20,
          //                           ),
          //                           decoration: BoxDecoration(
          //                               border: Border.all(color: Color(0xffE4DFDF)),
          //                               borderRadius:
          //                                   BorderRadius.all(Radius.circular(4))),
          //                           child: Column(
          //                             children: [
          //                               Text(
          //                                 'Reason : ${resultData['reason']}',
          //                                 style: Sty().mediumBoldText,
          //                               )
          //                             ],
          //                           ),
          //                         ),
          //                       )
          //               : Container(),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Container(
          //                 margin: const EdgeInsets.all(0),
          //                 padding: EdgeInsets.all(
          //                   Dim().d20,
          //                 ),
          //                 decoration: BoxDecoration(
          //                     border: Border.all(color: Color(0xffE4DFDF)),
          //                     borderRadius:
          //                         BorderRadius.all(Radius.circular(4))),
          //                 child: Column(
          //                   children: [
          //                     Text(
          //                       'Status : ${resultData['document_status']}',
          //                       style: Sty().mediumText.copyWith(
          //                             fontWeight: FontWeight.bold,
          //                             color: resultData['document_status'] == 'Ongoing'
          //                                 ? Clr().ongoingcolor
          //                                 : resultData['document_status'] ==
          //                                         'Under Review'
          //                                     ? Clr().ongoingcolor
          //                                     : resultData['document_status'] ==
          //                                             'Pending'
          //                                         ? Clr().pendingcolor
          //                                         : resultData['document_status'] ==
          //                                                 'Rejected'
          //                                             ? Clr().pendingcolor
          //                                             : resultData['document_status'] ==
          //                                                     'Completed'
          //                                                 ? Clr().completedcolor
          //                                                 : resultData[
          //                                                             'document_status'] ==
          //                                                         'Under Review'
          //                                                     ? Clr()
          //                                                         .ongoingcolor
          //                                                     : Clr().black,
          //                           ),
          //                     )
          //                   ],
          //                 ),
          //               ),
          //               resultData['document_status'] == "Completed"
          //                   ? Container()
          //                   : InkWell(
          //                       onTap: () {
          //                         STM().redirect2page(
          //                             ctx, EditInspection(widget.sOrderID));
          //                       },
          //                       child: Container(
          //                         padding: EdgeInsets.symmetric(
          //                             horizontal: Dim().d48,
          //                             vertical: Dim().d20),
          //                         decoration: BoxDecoration(
          //                           borderRadius: BorderRadius.all(
          //                             Radius.circular(4),
          //                           ),
          //                           gradient: LinearGradient(
          //                             begin: Alignment.centerLeft,
          //                             end: Alignment.centerRight,
          //                             colors: <Color>[
          //                               // [Color(0xff000000),
          //                               Color(0xff34135b),
          //                               Color(0xffA9163A),
          //                             ],
          //                           ),
          //                         ),
          //                         child: Center(
          //                           child: Text(
          //                             'Edit',
          //                             style: Sty()
          //                                 .mediumBoldText
          //                                 .copyWith(color: Clr().white),
          //                           ),
          //                         ),
          //                       ),
          //                     ),
          //             ],
          //           ),
          //         ],
          //       )
          //     : resultData['document_status'] == "Completed"
          //         ? Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Container(
          //                 margin: const EdgeInsets.all(0),
          //                 padding: EdgeInsets.all(
          //                   Dim().d20,
          //                 ),
          //                 decoration: BoxDecoration(
          //                     border: Border.all(color: Color(0xffE4DFDF)),
          //                     borderRadius:
          //                         BorderRadius.all(Radius.circular(4))),
          //                 child: Column(
          //                   children: [
          //                     Text(
          //                       'Status : ${resultData['document_status']}',
          //                       style: Sty().mediumText.copyWith(
          //                             fontWeight: FontWeight.bold,
          //                             color: resultData['document_status'] == 'Ongoing'
          //                                 ? Clr().ongoingcolor
          //                                 : resultData['document_status'] == 'Pending'
          //                                     ? Clr().pendingcolor
          //                                     : resultData['document_status'] ==
          //                                             'Rejected'
          //                                         ? Clr().pendingcolor
          //                                         : resultData['document_status'] ==
          //                                                 'Completed'
          //                                             ? Clr().completedcolor
          //                                             : resultData['document_status'] ==
          //                                                     'Under Review'
          //                                                 ? Clr().ongoingcolor
          //                                                 : Clr().black,
          //                           ),
          //                     )
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           )
          //         : resultData['flag']
          //             ? Row(
          //                 children: [
          //                   Expanded(
          //                     child: InkWell(
          //                       onTap: () {
          //                         cancelorder();
          //                       },
          //                       child: Container(
          //                         padding: EdgeInsets.symmetric(
          //                             vertical: Dim().d16,
          //                             horizontal: Dim().d52),
          //                         decoration: BoxDecoration(
          //                           gradient: LinearGradient(
          //                             colors: [
          //                               Color(0xFF2E135D),
          //                               Color(0xFFB81736)
          //                             ],
          //                           ),
          //                           borderRadius: BorderRadius.circular(
          //                             Dim().d4,
          //                           ),
          //                         ),
          //                         margin: EdgeInsets.only(right: 10),
          //                         child: Center(
          //                           child: Text(
          //                             'Cancel',
          //                             style: Sty().mediumText.copyWith(
          //                                 color: Clr().white,
          //                                 fontSize: 15,
          //                                 fontWeight: FontWeight.w400),
          //                           ),
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                   Expanded(
          //                     child: InkWell(
          //                       onTap: () {
          //                         STM().redirect2page(
          //                             ctx, Inspection(widget.sOrderID));
          //                         inspection();
          //                       },
          //                       child: Container(
          //                         padding: EdgeInsets.symmetric(
          //                             vertical: Dim().d16,
          //                             horizontal: Dim().d60),
          //                         decoration: BoxDecoration(
          //                           gradient: LinearGradient(
          //                             colors: [
          //                               Color(0xFF2E135D),
          //                               Color(0xFFB81736)
          //                             ],
          //                           ),
          //                           borderRadius: BorderRadius.circular(
          //                             Dim().d4,
          //                           ),
          //                         ),
          //                         // margin: EdgeInsets.all(20),
          //                         child: Center(
          //                           child: Text(
          //                             'Start',
          //                             style: Sty().mediumText.copyWith(
          //                                 color: Clr().white,
          //                                 fontSize: 16,
          //                                 fontWeight: FontWeight.w400),
          //                           ),
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                 ],
          //               )
          //             : InkWell(
          //                 onTap: () {
          //                   STM().redirect2page(
          //                       ctx, Inspection(widget.sOrderID));
          //                 },
          //                 child: Container(
          //                   padding: EdgeInsets.symmetric(
          //                       vertical: Dim().d16, horizontal: Dim().d60),
          //                   decoration: BoxDecoration(
          //                     gradient: LinearGradient(
          //                       colors: [Color(0xFF2E135D), Color(0xFFB81736)],
          //                     ),
          //                     borderRadius: BorderRadius.circular(
          //                       Dim().d4,
          //                     ),
          //                   ),
          //                   // margin: EdgeInsets.all(20),
          //                   child: Center(
          //                     child: Text(
          //                       'View Form',
          //                       style: Sty().mediumText.copyWith(
          //                           color: Clr().white,
          //                           fontSize: 16,
          //                           fontWeight: FontWeight.w400),
          //                     ),
          //                   ),
          //                 ),
          //               ),
        ],
      ),
    );
  }

  cancelorder() async {
    //Input
    SharedPreferences sp = await SharedPreferences.getInstance();
    FormData body = FormData.fromMap({
      "order_id": widget.sOrderID,
    });
    if (!mounted) return;
    var result =
        await STM().post(ctx, Str().processing, "customer_order_cancel", body);
    var error = result['error'];
    var message = result['message'];
    if (!error) {
      STM().displayToast("Success");
      successAlert(ctx, message, MyOrder());
    } else {
      STM().errorDialog(ctx, message);
    }
  }

  inspection() async {
    //Input
    SharedPreferences sp = await SharedPreferences.getInstance();
    FormData body = FormData.fromMap({
      "order_id": widget.sOrderID,
    });
    if (!mounted) return;
    var result =
        await STM().post(ctx, Str().processing, "start_inspection", body);
    var error = result['error'];
    var message = result['message'];
    if (!error) {
      STM().displayToast(message);
    } else {
      STM().errorDialog(ctx, message);
    }
  }
}
