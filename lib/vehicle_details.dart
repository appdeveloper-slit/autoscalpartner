import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'chassis_details.dart';
import 'manage/static_method.dart';
import 'upload_photos.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

// void main() => runApp(VehicleDetails());

class VehicleDetails extends StatefulWidget {
  @override
  State<VehicleDetails> createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  late BuildContext ctx;
  String? selectedValue;
  // = 'MH 05';
  List<String> arrayList = ['MH 05'];
  String v = "0";

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
            'Vehicle Details',
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
                  child: Text('Vehicle State ',
                      style: Sty()
                          .largeText
                          .copyWith(fontWeight: FontWeight.w400))),
              SizedBox(
                height: 12,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(Dim().d8)),
                          border: Border.all(
                            color: Clr().lightGrey,
                          )),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint:Text("Select Vehicle State"),
                          value: selectedValue,
                          isExpanded: true,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            size: 28,
                          ),
                          style: TextStyle(color: Color(0xff000000)),
                          items: arrayList.map((String string) {
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
                              selectedValue = v!;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Vehicle Number',
                          style: Sty()
                              .largeText
                              .copyWith(fontWeight: FontWeight.w400)),
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
                            borderRadius: BorderRadius.circular(Dim().d8),
                            borderSide: BorderSide(
                              color: Color(0xffE4DFDF),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Vehicle Make',
                            style: Sty()
                                .largeText
                                .copyWith(fontWeight: FontWeight.w400))),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(Dim().d8)),
                          border: Border.all(
                            color: Clr().lightGrey,
                          )),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint:Text("Select Vehicle Make"),
                          value: selectedValue,
                          isExpanded: true,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            size: 28,
                          ),
                          style: TextStyle(color: Color(0xff000000)),
                          items: arrayList.map((String string) {
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
                              selectedValue = v!;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Vehicle Model',
                            style: Sty()
                                .largeText
                                .copyWith(fontWeight: FontWeight.w400))),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(Dim().d8)),
                          border: Border.all(
                            color: Clr().lightGrey,
                          )),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint:Text("Select Vehicle Model"),
                          value: selectedValue,
                          isExpanded: true,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            size: 28,
                          ),
                          style: TextStyle(color: Color(0xff000000)),
                          items: arrayList.map((String string) {
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
                              selectedValue = v!;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Variant',
                            style: Sty()
                                .largeText
                                .copyWith(fontWeight: FontWeight.w400))),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(Dim().d8)),
                          border: Border.all(
                            color: Clr().lightGrey,
                          )),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint:Text("Select Variant"),
                          value: selectedValue,
                          isExpanded: true,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            size: 28,
                          ),
                          style: TextStyle(color: Color(0xff000000)),
                          items: arrayList.map((String string) {
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
                              selectedValue = v!;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text('MFG Year',
                            style: Sty()
                                .largeText
                                .copyWith(fontWeight: FontWeight.w400))),
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
                            borderRadius: BorderRadius.circular(Dim().d8),
                            borderSide: BorderSide(
                              color: Color(0xffE4DFDF),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text('REG Year',
                            style: Sty()
                                .largeText
                                .copyWith(fontWeight: FontWeight.w400))),
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
                            borderRadius: BorderRadius.circular(Dim().d8),
                            borderSide: BorderSide(
                              color: Color(0xffE4DFDF),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Tax Validity',
                            style: Sty()
                                .largeText
                                .copyWith(fontWeight: FontWeight.w400))),
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
                            borderRadius: BorderRadius.circular(Dim().d8),
                            borderSide: BorderSide(
                              color: Color(0xffE4DFDF),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Vehicle Colour',
                            style: Sty()
                                .largeText
                                .copyWith(fontWeight: FontWeight.w400))),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(Dim().d8)),
                          border: Border.all(
                            color: Clr().lightGrey,
                          )),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint:Text("Select Vehicle Colour"),
                          value: selectedValue,
                          isExpanded: true,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            size: 28,
                          ),
                          style: TextStyle(color: Color(0xff000000)),
                          items: arrayList.map((String string) {
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
                              selectedValue = v!;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Engine Cubic Capacity',
                          style: Sty()
                              .largeText
                              .copyWith(fontWeight: FontWeight.w400)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        // label: Text('Enter Your Number'),
                        hintText: "1197",

                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dim().d8),
                            borderSide: BorderSide(
                              color: Color(0xffE4DFDF),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Fuel Type',
                            style: Sty()
                                .largeText
                                .copyWith(fontWeight: FontWeight.w400))),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(Dim().d8)),
                          border: Border.all(
                            color: Clr().lightGrey,
                          )),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint:Text("Select Fuel Type"),
                          value: selectedValue,
                          isExpanded: true,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            size: 28,
                          ),
                          style: TextStyle(color: Color(0xff000000)),
                          items: arrayList.map((String string) {
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
                              selectedValue = v!;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Owner Serial No',
                          style: Sty()
                              .largeText
                              .copyWith(fontWeight: FontWeight.w400)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        // label: Text('Enter Your Number'),
                        hintText: "01",

                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dim().d8),
                            borderSide: BorderSide(
                              color: Color(0xffE4DFDF),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Odometer Reading',
                          style: Sty()
                              .largeText
                              .copyWith(fontWeight: FontWeight.w400)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        // label: Text('Enter Your Number'),
                        hintText: "001",

                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dim().d8),
                            borderSide: BorderSide(
                              color: Color(0xffE4DFDF),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Special Comments',
                          style: Sty()
                              .largeText
                              .copyWith(fontWeight: FontWeight.w400)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        // label: Text('Enter Your Number'),
                        // hintText: "01",

                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dim().d8),
                            borderSide: BorderSide(
                              color: Color(0xffE4DFDF),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              STM().redirect2page(ctx, ChassisDetails());
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: Dim().d16, horizontal: Dim().d44),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Color(0xFF2E135D), Color(0xFFB81736)],
                                ),
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
                              STM().redirect2page(ctx, UploadPhotos());
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: Dim().d16, horizontal: Dim().d64),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Color(0xFF2E135D), Color(0xFFB81736)],
                                ),
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
              ),
            ],
          ),
        ),
      );
  }
}
