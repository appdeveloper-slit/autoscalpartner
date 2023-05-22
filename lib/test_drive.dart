import 'package:flutter/material.dart';

import 'engine_compartment.dart';
import 'exterior_lhs_side.dart';
import 'interior.dart';
import 'manage/static_method.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

// void main() => runApp(TestDrive());

class TestDrive extends StatefulWidget {
  @override
  State<TestDrive> createState() => _TestDriveState();
}

class _TestDriveState extends State<TestDrive> {
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
            'Test Drive',
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
          child: Container(
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(' Front Suspension Noise',
                        style: Sty()
                            .largeText
                            .copyWith(fontWeight: FontWeight.w400))),
                SizedBox(height: 12,),
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
                SizedBox(height: 20,),


                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Axle Noise ',
                        style: Sty()
                            .largeText
                            .copyWith(fontWeight: FontWeight.w400))),
                SizedBox(height: 12,),
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
                // SizedBox(height: 20,),
                // Align(
                //     alignment: Alignment.centerLeft,
                //     child: Text('Music System',
                //         style: Sty()
                //             .largeText
                //             .copyWith(fontWeight: FontWeight.w400))),
                // SizedBox(height: 12,),
                // Container(
                //   padding:
                //   EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                //   decoration: BoxDecoration(
                //       borderRadius:
                //       BorderRadius.all(Radius.circular(Dim().d8)),
                //       border: Border.all(
                //         color: Clr().lightGrey,
                //       )),
                //   child: DropdownButtonHideUnderline(
                //     child: DropdownButton<String>(
                //       value: selectedValue,
                //       isExpanded: true,
                //       icon: Icon(
                //         Icons.keyboard_arrow_down,
                //         size: 28,
                //       ),
                //       style: TextStyle(color: Color(0xff000000)),
                //       items: arrayList.map((String string) {
                //         return DropdownMenuItem<String>(
                //           value: string,
                //           child: Text(
                //             string,
                //             style: TextStyle(
                //                 color: Color(0xff5B5B5B), fontSize: 14),
                //           ),
                //         );
                //       }).toList(),
                //       onChanged: (v) {
                //         // STM().redirect2page(ctx, Home());
                //         setState(() {
                //           selectedValue = v!;
                //         });
                //       },
                //     ),
                //   ),
                // ),
                SizedBox(height: 20,),


                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Rear suspension Noise ',
                        style: Sty()
                            .largeText
                            .copyWith(fontWeight: FontWeight.w400))),
                SizedBox(height: 12,),
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
                SizedBox(height: 20,),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Clutch Condition ',
                        style: Sty()
                            .largeText
                            .copyWith(fontWeight: FontWeight.w400))),
                SizedBox(height: 12,),
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
                SizedBox(height: 20,),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Automatic Gear Box',
                        style: Sty()
                            .largeText
                            .copyWith(fontWeight: FontWeight.w400))),
                SizedBox(height: 12,),
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
                SizedBox(height: 20,),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Gear Box',
                        style: Sty()
                            .largeText
                            .copyWith(fontWeight: FontWeight.w400))),
                SizedBox(height: 12,),
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
                SizedBox(height: 20,),


                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Gear Box noise',
                        style: Sty()
                            .largeText
                            .copyWith(fontWeight: FontWeight.w400))),
                SizedBox(height: 12,),
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
                SizedBox(height: 20,),


                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Gear Shifting',
                        style: Sty()
                            .largeText
                            .copyWith(fontWeight: FontWeight.w400))),
                SizedBox(height: 12,),
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
                SizedBox(height: 20,),


                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('W/A',
                        style: Sty()
                            .largeText
                            .copyWith(fontWeight: FontWeight.w400))),
                SizedBox(height: 12,),
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
                SizedBox(height: 20,),


                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Steering Noise',
                        style: Sty()
                            .largeText
                            .copyWith(fontWeight: FontWeight.w400))),
                SizedBox(height: 12,),
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
                SizedBox(height: 20,),


                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Steering Colum Noise',
                        style: Sty()
                            .largeText
                            .copyWith(fontWeight: FontWeight.w400))),
                SizedBox(height: 12,),
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
                SizedBox(height: 20,),


                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Speedometer Knob',
                        style: Sty()
                            .largeText
                            .copyWith(fontWeight: FontWeight.w400))),
                SizedBox(height: 12,),
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
                SizedBox(height: 20,),


                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Odometer Reading',
                        style: Sty()
                            .largeText
                            .copyWith(fontWeight: FontWeight.w400))),
                SizedBox(height: 12,),
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
                SizedBox(height: 40,),



                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          STM().redirect2page(ctx, Interior());
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
                          STM().redirect2page(ctx, EngineCompartment());
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
        ),
      );
  }
}