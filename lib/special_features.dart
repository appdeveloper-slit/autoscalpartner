import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'any_damage.dart';
import 'manage/static_method.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

// void main() => runApp(SpecialFeatures());

class SpecialFeatures extends StatefulWidget {
  @override
  State<SpecialFeatures> createState() => _SpecialFeaturesState();
}

class _SpecialFeaturesState extends State<SpecialFeatures> {
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
          'Special Features',
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
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      // label: Text('Enter Your Number'),
                      hintText: "Comment",

                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color(0xffE4DFDF),
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
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
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/upload.svg'),
                    ],
                  ),
                ),
                SizedBox(
                  width: 8,
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
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          // //STM().filePicker("p1", true);
                        },
                        child: Icon(Icons.camera_alt_outlined,
                            color: Colors.white, size: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      // label: Text('Enter Your Number'),
                      hintText: "Comment",

                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color(0xffE4DFDF),
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
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
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/upload.svg'),
                    ],
                  ),
                ),
                SizedBox(
                  width: 8,
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
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          // //STM().filePicker("p1", true);
                        },
                        child: Icon(Icons.camera_alt_outlined,
                            color: Colors.white, size: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      // label: Text('Enter Your Number'),
                      hintText: "Comment",

                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color(0xffE4DFDF),
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
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
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/upload.svg'),
                    ],
                  ),
                ),
                SizedBox(
                  width: 8,
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
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          // //STM().filePicker("p1", true);
                        },
                        child: Icon(Icons.camera_alt_outlined,
                            color: Colors.white, size: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      // label: Text('Enter Your Number'),
                      hintText: "Comment",

                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color(0xffE4DFDF),
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
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
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/upload.svg'),
                    ],
                  ),
                ),
                SizedBox(
                  width: 8,
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
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          // //STM().filePicker("p1", true);
                        },
                        child: Icon(Icons.camera_alt_outlined,
                            color: Colors.white, size: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      // label: Text('Enter Your Number'),
                      hintText: "Comment",

                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color(0xffE4DFDF),
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
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
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/upload.svg'),
                    ],
                  ),
                ),
                SizedBox(
                  width: 8,
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
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          // //STM().filePicker("p1", true);
                        },
                        child: Icon(Icons.camera_alt_outlined,
                            color: Colors.white, size: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      // label: Text('Enter Your Number'),
                      hintText: "Comment",

                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color(0xffE4DFDF),
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
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
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/upload.svg'),
                    ],
                  ),
                ),
                SizedBox(
                  width: 8,
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
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          // //STM().filePicker("p1", true);
                        },
                        child: Icon(Icons.camera_alt_outlined,
                            color: Colors.white, size: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      // label: Text('Enter Your Number'),
                      hintText: "Comment",

                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color(0xffE4DFDF),
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
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
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/upload.svg'),
                    ],
                  ),
                ),
                SizedBox(
                  width: 8,
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
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          // //STM().filePicker("p1", true);
                        },
                        child: Icon(Icons.camera_alt_outlined,
                            color: Colors.white, size: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      // label: Text('Enter Your Number'),
                      hintText: "Comment",

                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color(0xffE4DFDF),
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
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
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/upload.svg'),
                    ],
                  ),
                ),
                SizedBox(
                  width: 8,
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
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          // //STM().filePicker("p1", true);
                        },
                        child: Icon(Icons.camera_alt_outlined,
                            color: Colors.white, size: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      // STM().redirect2page(ctx, TestDrive());
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
                      STM().redirect2page(ctx, AnyDamage());
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
    );
  }
}
