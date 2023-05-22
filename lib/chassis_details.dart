import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'manage/static_method.dart';
import 'rc_&_insurance_deatils.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';
import 'vehicle_details.dart';

// void main() => runApp(ChassisDetails());

class ChassisDetails extends StatefulWidget {
  @override
  State<ChassisDetails> createState() => _ChassisDetailsState();
}

class _ChassisDetailsState extends State<ChassisDetails> {
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
            'Chassis Details',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                foreground: Paint()
                  ..shader = LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Color(0xff34135B),
                      Color(0xffA9163A),
                      // Color(0xff000000)
                    ],
                  ).createShader(Rect.fromLTWH(0.0, 35.0, 200.0, 70.0))),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Chassis Number',
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  // label: Text('Enter Your Number'),
                  hintText: "MAHTUS066775756",

                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color(0xffE4DFDF),
                  )),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Engine No',
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  // label: Text('Enter Your Number'),
                  hintText: "GAUYTU076767",

                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color(0xffE4DFDF),
                  )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: Dim().d16, horizontal: Dim().d20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment(0, 2),
                          colors: <Color>[
                            Color(0xFFED4120),
                            Color(0xFFE48260),
                            // Color(0xff000000)
                          ],
                        ),
                  borderRadius: BorderRadius.circular(
                    Dim().d4,
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    // STM().redirect2page(ctx, Profile());
                  },
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          // //STM().filePicker("p1", true);
                        },
                        child: Icon(Icons.camera_alt_outlined,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SvgPicture.asset('assets/upload.svg'),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Upload Chassis Photo',
                        style: Sty().mediumText.copyWith(
                              color: Clr().white,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 320,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        // STM().redirect2page(ctx, RcInsuranceDeatils());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Dim().d16, horizontal: Dim().d44),
                        decoration: BoxDecoration(
                          gradient: Sty().linearGradient,
                          borderRadius: BorderRadius.circular(
                            Dim().d4,
                          ),
                        ),
                        margin: EdgeInsets.only(right: 10),
                        child: Center(
                          child: Text(
                            'Previous',
                            style: Sty().mediumText.copyWith(
                                color: Clr().white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        STM().redirect2page(ctx, VehicleDetails());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Dim().d16, horizontal: Dim().d64),
                        decoration: BoxDecoration(
                          gradient: Sty().linearGradient,
                          borderRadius: BorderRadius.circular(
                            Dim().d4,
                          ),
                        ),
                        // margin: EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            'Next',
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
            ],
          ),
        )
        );
  }
}
