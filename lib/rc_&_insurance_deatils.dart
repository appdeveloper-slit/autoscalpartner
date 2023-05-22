import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'chassis_details.dart';
import 'customer_details.dart';
import 'manage/static_method.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

// void main() => runApp(RcInsuranceDeatils());

class RcInsuranceDeatils extends StatefulWidget {
  List<dynamic>? thePreviousData;
  RcInsuranceDeatils(this.thePreviousData);

  @override
  State<RcInsuranceDeatils> createState() =>
      _RcInsuranceDeatilsState(thePreviousData);
}

class _RcInsuranceDeatilsState extends State<RcInsuranceDeatils> {
  List<dynamic>? thePreviousData;
  _RcInsuranceDeatilsState(this.thePreviousData);

  late BuildContext ctx;
  String selectedValue = 'Orginal';
  List<String> arrayList = ['Orginal'];
  String v = "0";

  List<dynamic>? allData = [];

  String? rcDropDownSelected;
  String? rcTypeDropDownSelected;
  String? zeroDepInsuranceDropDownSelected;

  List<String> rcDropDownList = [
    "Orginal",
    "Duplicate",
    "Migrated RC",
  ];
  List<String> rcTypeDropDownList = ["Private", "Un-registered"];
  List<String> zeroDepInsuranceDropDownList = ["Original", "Xerox", "N / A"];

  @override
  void initState() {
    allData = thePreviousData;
    // TODO: implement initState
    super.initState();
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
          'Rc and Insurance Details',
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
            Align(
                alignment: Alignment.centerLeft,
                child: Text('RC ',
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
            SizedBox(
              height: 12,
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(Dim().d8)),
                        border: Border.all(
                          color: Clr().lightGrey,
                        )),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text(rcDropDownSelected ?? "Select an option"),
                        value: rcDropDownSelected,
                        isExpanded: true,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          size: 28,
                        ),
                        style: TextStyle(color: Color(0xff000000)),
                        items: rcDropDownList.map((String string) {
                          return DropdownMenuItem<String>(
                            value: string,
                            child: Text(
                              string,
                              style: TextStyle(
                                  color: Color(0xff5B5B5B), fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (v) {
                          // STM().redirect2page(ctx, Home());
                          setState(() {
                            rcDropDownSelected = v!;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Dim().d16, horizontal: Dim().d20),
                    decoration: BoxDecoration(
                      gradient: Sty().linearGradient,
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
                            '   Upload RC Photo',
                            style: Sty().mediumText.copyWith(
                                  color: Clr().white,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Align(
                alignment: Alignment.centerLeft,
                child: Text('RC Type',
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
            SizedBox(
              height: 12,
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(Dim().d8)),
                        border: Border.all(
                          color: Clr().lightGrey,
                        )),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text(rcTypeDropDownSelected ?? "Select RC Type"),
                        value: rcTypeDropDownSelected,
                        isExpanded: true,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          size: 28,
                        ),
                        style: TextStyle(color: Color(0xff000000)),
                        items: rcTypeDropDownList.map((String string) {
                          return DropdownMenuItem<String>(
                            value: string,
                            child: Text(
                              string,
                              style: TextStyle(
                                  color: Color(0xff5B5B5B), fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (v) {
                          // STM().redirect2page(ctx, Home());
                          setState(() {
                            rcTypeDropDownSelected = v!;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Dim().d16, horizontal: Dim().d20),
                    decoration: BoxDecoration(
                      gradient: Sty().linearGradient,
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
                            '   Upload RC Photo',
                            style: Sty().mediumText.copyWith(
                                  color: Clr().white,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Align(
                alignment: Alignment.centerLeft,
                child: Text('Insurance Type',
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
            SizedBox(
              height: 12,
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(Dim().d8)),
                        border: Border.all(
                          color: Clr().lightGrey,
                        )),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text(zeroDepInsuranceDropDownSelected ??
                            "Select Zero Dep Insurance"),
                        value: zeroDepInsuranceDropDownSelected,
                        isExpanded: true,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          size: 28,
                        ),
                        style: TextStyle(color: Color(0xff000000)),
                        items:
                            zeroDepInsuranceDropDownList.map((String string) {
                          return DropdownMenuItem<String>(
                            value: string,
                            child: Text(
                              string,
                              style: TextStyle(
                                  color: Color(0xff5B5B5B), fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (v) {
                          // STM().redirect2page(ctx, Home());
                          setState(() {
                            zeroDepInsuranceDropDownSelected = v!;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Dim().d16, horizontal: Dim().d20),
                    decoration: BoxDecoration(
                      gradient: Sty().linearGradient,
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
                            '   Upload Insurance Photo',
                            style: Sty().mediumText.copyWith(
                                  color: Clr().white,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Align(
                alignment: Alignment.centerLeft,
                child: Text('Expiry Date',
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12),
                // label: Text('Enter Your Number'),
                hintText: "01/09/2022",
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(
                      left: 12, right: 20, top: 16, bottom: 12),
                  child: SvgPicture.asset('assets/Calender1.svg'),
                ),

                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Color(0xffE4DFDF),
                )),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: Dim().d16, horizontal: Dim().d20),
              decoration: BoxDecoration(
                gradient: Sty().linearGradient,
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
                      child:
                          Icon(Icons.camera_alt_outlined, color: Colors.white),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset('assets/upload.svg'),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '   Upload Photo',
                      style: Sty().mediumText.copyWith(
                            color: Clr().white,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
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
                    child: InkWell(
                      onTap: () {
                        STM().redirect2page(ctx, CustomerDetails());
                      },
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
                    child: InkWell(
                      onTap: () {
                        allData!.add({});
                        STM().redirect2page(ctx, ChassisDetails());
                      },
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
      ),
    );
  }
}
