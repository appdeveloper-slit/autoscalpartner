import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'values/colors.dart';

import 'Inspection.dart';
import 'manage/static_method.dart';
import 'my_orders.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

// void main() => runApp(FinalPage());

class FinalPage extends StatefulWidget {
  @override
  State<FinalPage> createState() => _FinalPageState();
}

class _FinalPageState extends State<FinalPage> {
  late BuildContext ctx;

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
          '#123456',
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
            Container(
              margin: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffE4DFDF)),
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ShaderMask(
                            child: SvgPicture.asset("assets/Car.svg"),
                            shaderCallback: (bounds) => LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                Color(0xff000000),
                                Color(0xff000000),
                                Color.fromARGB(255, 207, 36, 79),
                                Color.fromARGB(255, 220, 51, 93),
                                Color.fromARGB(255, 255, 44, 97),
                              ],
                            ).createShader(Rect.fromLTWH(0, 0, 45, 45)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(Dim().d8),
                          child: Text(
                            'Car Details',
                            style: Sty().mediumBoldText.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
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
                          padding: EdgeInsets.all(Dim().d8),
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
                          padding: EdgeInsets.all(Dim().d8),
                          child: Text('Mahindra'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(Dim().d8),
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
                          padding: EdgeInsets.all(Dim().d8),
                          child: Text('ALTROZ'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(Dim().d8),
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
                          padding: EdgeInsets.all(Dim().d8),
                          child: Text('2017'),
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
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ShaderMask(
                            child: SvgPicture.asset("assets/Car.svg"),
                            shaderCallback: (bounds) => LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                Color(0xff000000),
                                Color(0xff000000),
                                Color.fromARGB(255, 207, 36, 79),
                                Color.fromARGB(255, 220, 51, 93),
                                Color.fromARGB(255, 255, 44, 97),
                              ],
                            ).createShader(Rect.fromLTWH(0, 0, 45, 45)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(Dim().d8),
                          child: Text(
                            'Supplier Details',
                            style: Sty().mediumBoldText.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
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
                          padding: EdgeInsets.all(Dim().d8),
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
                          padding: EdgeInsets.all(Dim().d8),
                          child: Text('Aniket Mahakal'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(Dim().d8),
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
                          padding: EdgeInsets.all(Dim().d8),
                          child: Text('3251513511'),
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
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ShaderMask(
                            child: SvgPicture.asset("assets/location (2).svg"),
                            shaderCallback: (bounds) => LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                Color(0xff000000),
                                Color(0xff000000),
                                Color.fromARGB(255, 207, 36, 79),
                                Color.fromARGB(255, 220, 51, 93),
                                Color.fromARGB(255, 255, 44, 97),
                              ],
                            ).createShader(Rect.fromLTWH(0, 0, 45, 45)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(Dim().d8),
                          child: Text(
                            'Supplier Address',
                            style: Sty().mediumBoldText.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                        'Vasant Lawns , DP Road, Opp. TCS , Subhash Nagar , Thane West , Thane , Maharashtra 400606'),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(4),
                            bottomRight: Radius.circular(4)),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: <Color>[
                              // [Color(0xff000000),
                              Color(0xff34135b),
                              Color(0xffA9163A),
                            ])),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: Dim().d8,
                              bottom: Dim().d8,
                              left: Dim().d12,
                              right: Dim().d12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'View Map',
                                style:
                                    TextStyle(color: Clr().white, fontSize: 16),
                              ),
                              // SizedBox(
                              //   width: Dim().d200,
                              // ),
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
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: Dim().d16, horizontal: Dim().d44),
              decoration: BoxDecoration(
                gradient: Sty().linearGradient,
                borderRadius: BorderRadius.circular(
                  Dim().d4,
                ),
              ),
              margin: EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () {
                  // STM().redirect2page(ctx, MyOrder());
                },
                child: Text(
                  'View Details',
                  style: Sty().mediumText.copyWith(
                      color: Clr().white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
