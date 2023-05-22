import 'package:flutter/material.dart';
import 'package:quick_room_services/test_drive.dart';

import 'interior.dart';

import 'manage/static_method.dart';
import 'special_features.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

// void main() => runApp(EngineCompartment());

class EngineCompartment extends StatefulWidget {
  @override
  State<EngineCompartment> createState() => _EngineCompartmentState();
}

class _EngineCompartmentState extends State<EngineCompartment> {
  late BuildContext ctx;
  String selectedValue = 'Yes';
  List<String> arrayList = ['Yes'];
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
          'Engine Compartment',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              foreground: Paint()
                ..shader = LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(0.3, 12),
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
        child: Container(
          child: Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Tappet Noise',
                      style: Sty()
                          .largeText
                          .copyWith(fontWeight: FontWeight.w400))),
              SizedBox(
                height: 12,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(Dim().d8)),
                    border: Border.all(
                      color: Clr().lightGrey,
                    )),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
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
                          style:
                              TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
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
                  child: Text('Engine overheating',
                      style: Sty()
                          .largeText
                          .copyWith(fontWeight: FontWeight.w400))),
              SizedBox(
                height: 12,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(Dim().d8)),
                    border: Border.all(
                      color: Clr().lightGrey,
                    )),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
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
                          style:
                              TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
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
                  child: Text('Engine oil sludge',
                      style: Sty()
                          .largeText
                          .copyWith(fontWeight: FontWeight.w400))),
              SizedBox(
                height: 12,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(Dim().d8)),
                    border: Border.all(
                      color: Clr().lightGrey,
                    )),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
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
                          style:
                              TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
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
                  child: Text('Engine oil Condition',
                      style: Sty()
                          .largeText
                          .copyWith(fontWeight: FontWeight.w400))),
              SizedBox(
                height: 12,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(Dim().d8)),
                    border: Border.all(
                      color: Clr().lightGrey,
                    )),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
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
                          style:
                              TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
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
                  child: Text('Coolent',
                      style: Sty()
                          .largeText
                          .copyWith(fontWeight: FontWeight.w400))),
              SizedBox(
                height: 12,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(Dim().d8)),
                    border: Border.all(
                      color: Clr().lightGrey,
                    )),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
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
                          style:
                              TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
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
                  child: Text('Timeing side Noise',
                      style: Sty()
                          .largeText
                          .copyWith(fontWeight: FontWeight.w400))),
              SizedBox(
                height: 12,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(Dim().d8)),
                    border: Border.all(
                      color: Clr().lightGrey,
                    )),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
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
                          style:
                              TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
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
                  child: Text('Alternater Condition',
                      style: Sty()
                          .largeText
                          .copyWith(fontWeight: FontWeight.w400))),
              SizedBox(
                height: 12,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(Dim().d8)),
                    border: Border.all(
                      color: Clr().lightGrey,
                    )),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
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
                          style:
                              TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
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
                  child: Text('Battery Condition',
                      style: Sty()
                          .largeText
                          .copyWith(fontWeight: FontWeight.w400))),
              SizedBox(
                height: 12,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(Dim().d8)),
                    border: Border.all(
                      color: Clr().lightGrey,
                    )),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
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
                          style:
                              TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
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
                  child: Text('Ac compressor',
                      style: Sty()
                          .largeText
                          .copyWith(fontWeight: FontWeight.w400))),
              SizedBox(
                height: 12,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(Dim().d8)),
                    border: Border.all(
                      color: Clr().lightGrey,
                    )),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
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
                          style:
                              TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
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
                  child: Text('Starter motor Noise',
                      style: Sty()
                          .largeText
                          .copyWith(fontWeight: FontWeight.w400))),
              SizedBox(
                height: 12,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(Dim().d8)),
                    border: Border.all(
                      color: Clr().lightGrey,
                    )),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
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
                          style:
                              TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
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
                  child: Text('Air Filter Assy',
                      style: Sty()
                          .largeText
                          .copyWith(fontWeight: FontWeight.w400))),
              SizedBox(
                height: 12,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(Dim().d8)),
                    border: Border.all(
                      color: Clr().lightGrey,
                    )),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
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
                          style:
                              TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
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
                  child: Text('Video Url',
                      style: Sty()
                          .largeText
                          .copyWith(fontWeight: FontWeight.w400))),
              SizedBox(
                height: 12,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(Dim().d8)),
                    border: Border.all(
                      color: Clr().lightGrey,
                    )),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Video Url',
                      hintStyle: Sty().mediumText.copyWith(
                            color: Clr().drkcolor,
                            fontSize: 14,
                          )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        STM().redirect2page(ctx, TestDrive());
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
                        STM().redirect2page(ctx, SpecialFeatures());
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
        ),
      ),
    );
  }
}
