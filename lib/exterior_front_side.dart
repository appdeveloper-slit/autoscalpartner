import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'bonnet.dart';
import 'exterior_rhs_side.dart';
import 'manage/static_method.dart';
import 'upload_photos.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

// void main() => runApp(ExteriorFrontSide());

class ExteriorFrontSide extends StatefulWidget {
  @override
  State<ExteriorFrontSide> createState() => _ExteriorFrontSideState();
}

class _ExteriorFrontSideState extends State<ExteriorFrontSide> {
  late BuildContext ctx;
  String? frontBumperDropDownSelected;
  List<String> frontBumperDropDownList = [
    "Original",
    "Minor Scratches",
    "Minor Dent",
    "Repainted",
    "Major Scratches",
    "Major Dent",
    "Replace",
    "Repair"
  ];
  String? bonnetDropDownSelected;
  List<String> bonnetDropDownList = [
    "Original",
    "Minor Scratches",
    "Minor Dent",
    "Repainted",
    "Major Scratches",
    "Major Dent",
    "Replace",
    "Repair",
    "Rusted"
  ];
  String? selectedValue;
  List<String> arrayList = ['Original'];
  String v = "0";
  String? selectedValueroof;
  List<String> arrayListroof = ['Original'];
  String vroof = "0";
  // String v = "0";

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
          'Exterior Front Side',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              foreground: Paint()
                ..shader = Sty().linearGradient.createShader(Rect.fromLTWH(0.0, 35.0, 200.0, 70.0))),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Container(
          child: Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Front Bumper',
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
                    hint: Text(
                        frontBumperDropDownSelected ?? "Select front bumper"),
                    value: frontBumperDropDownSelected,
                    isExpanded: true,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 28,
                    ),
                    style: TextStyle(color: Color(0xff000000)),
                    items: frontBumperDropDownList.map((String string) {
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
                        frontBumperDropDownSelected = v!;
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
                  child: Text('Photo of Scratches, dent & repair ',
                      style: Sty()
                          .largeText
                          .copyWith(fontWeight: FontWeight.w400))),
              SizedBox(
                height: 12,
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
                        'Upload Photo',
                        style: Sty().mediumText.copyWith(
                              color: Clr().white,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Dim().d20,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Bonnet',
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
                    hint: Text(bonnetDropDownSelected ?? "Select bonnet"),
                    value: bonnetDropDownSelected,
                    isExpanded: true,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 28,
                    ),
                    style: TextStyle(color: Color(0xff000000)),
                    items: bonnetDropDownList.map((String string) {
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
                        bonnetDropDownSelected = v!;
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
                  child: Text('Photo of Scratches, dent & repair ',
                      style: Sty()
                          .largeText
                          .copyWith(fontWeight: FontWeight.w400))),
              SizedBox(
                height: 12,
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
                        'Upload Photo',
                        style: Sty().mediumText.copyWith(
                              color: Clr().white,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Dim().d20,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Front Glass',
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
                    hint: Text("Please select front glass"),
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
                  child: Text('Photo of Scratches, dent & repair ',
                      style: Sty()
                          .largeText
                          .copyWith(fontWeight: FontWeight.w400))),
              SizedBox(
                height: 12,
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
                        'Upload Photo',
                        style: Sty().mediumText.copyWith(
                              color: Clr().white,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(
              //   height: 30,
              // ),
              // Container(
              //   padding: EdgeInsets.symmetric(
              //       vertical: Dim().d16, horizontal: Dim().d120),
              //   decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //       colors: [Color(0xFF2E135D), Color(0xFFB81736)],
              //     ),
              //     borderRadius: BorderRadius.circular(
              //       Dim().d4,
              //     ),
              //   ),
              //   // margin: EdgeInsets.all(20),
              //   child: InkWell(
              //     onTap: () {
              //       // STM().redirect2page(ctx, ExteriorFrontSide());
              //     },
              //     child: Text(
              //       'Save',
              //       style: Sty().mediumText.copyWith(
              //           color: Clr().white,
              //           fontSize: 16,
              //           fontWeight: FontWeight.w400),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: Dim().d20,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Roof',
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
                    hint: Text("Select Roof"),
                    value: selectedValueroof,
                    isExpanded: true,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 28,
                    ),
                    style: TextStyle(color: Color(0xff000000)),
                    items: arrayListroof.map((String string) {
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
                        selectedValueroof = v!;
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
                  child: Text('Photo of Scratches, dent & repair ',
                      style: Sty()
                          .largeText
                          .copyWith(fontWeight: FontWeight.w400))),
              SizedBox(
                height: 12,
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
                        'Upload Photo',
                        style: Sty().mediumText.copyWith(
                              color: Clr().white,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Dim().d32,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        STM().redirect2page(ctx, UploadPhotos());
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
                        STM().redirect2page(ctx, ExteriorRhsSide());
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
