import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'exterior_front_side.dart';
import 'front_glass.dart';
import 'manage/static_method.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

// void main() => runApp(Bonnet());

class Bonnet extends StatefulWidget {
  @override
  State<Bonnet> createState() => _BonnetState();
}

class _BonnetState extends State<Bonnet> {
  late BuildContext ctx;
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
  // String v = "0";

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return  Scaffold(
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
            'Bonnet',
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
                      Color(0xff000000)
                    ],
                  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Container(
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Bonnet',
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
                            style: TextStyle(
                                color: Color(0xff5B5B5B), fontSize: 14),
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
                SizedBox(height: 20,),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Photo of Scratches, dent & repair ',
                        style: Sty()
                            .largeText
                            .copyWith(fontWeight: FontWeight.w400))),
                SizedBox(height: 12,),

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
                SizedBox(height: 380,),


                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          STM().redirect2page(ctx, ExteriorFrontSide());
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
                          child:  Center(
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
                          STM().redirect2page(ctx, FrontGlass());
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
