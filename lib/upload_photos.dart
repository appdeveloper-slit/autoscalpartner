import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'exterior_front_side.dart';
import 'manage/static_method.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';
import 'vehicle_details.dart';

// void main() => runApp(UploadPhotos());

class UploadPhotos extends StatefulWidget {
  @override
  State<UploadPhotos> createState() => _UploadPhotosState();
}

class _UploadPhotosState extends State<UploadPhotos> {
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
          'Upload Photos',
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
              child: Text('Front View',
                  style: Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
            ),
            SizedBox(
              height: 8,
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
                      'Upload Front View Photo',
                      style: Sty().mediumText.copyWith(
                            color: Clr().white,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Front Glass',
                  style: Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
            ),
            SizedBox(
              height: 8,
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
                      'Upload Front Glass Photo',
                      style: Sty().mediumText.copyWith(
                            color: Clr().white,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Engine Compartment',
                  style: Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: Dim().d16, horizontal: Dim().d12),
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
                     SizedBox(
                      width: 10,
                    ),
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
                    SizedBox(
                      width: Dim().d220,
                      child: Text(
                        'Upload Engine Compartment Photo',
                        style: Sty().mediumText.copyWith(
                              color: Clr().white,
                              overflow: TextOverflow.ellipsis
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Roof',
                  style: Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
            ),
            SizedBox(
              height: 8,
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
                      'Upload Roof Photo',
                      style: Sty().mediumText.copyWith(
                            color: Clr().white,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Front Rhs side Triangle View',
                  style: Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              padding: EdgeInsets.only(
                top: 16,
                bottom: 16,
                left: 12,
              ),
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
                     SizedBox(
                      width: 10,
                    ),
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
                    SizedBox(
                      width: Dim().d220,
                      child: Text(
                        'Upload Front Rhs side Triangle View Photo',
                        style: Sty().smallText.copyWith(
                              color: Clr().white,
                              overflow: TextOverflow.ellipsis
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Front Rhs tyre',
                  style: Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
            ),
            SizedBox(
              height: 8,
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
                      'Upload Front Rhs tyre Photo',
                      style: Sty().mediumText.copyWith(
                            color: Clr().white,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Rhs Side View',
                  style: Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
            ),
            SizedBox(
              height: 8,
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
                      'Upload Rhs Side View Photo',
                      style: Sty().mediumText.copyWith(
                            color: Clr().white,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Rhs Side Interior View',
                  style: Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
            ),
            SizedBox(
              height: 8,
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
                      'Upload Rhs Side Interior Photo',
                      style: Sty().mediumText.copyWith(
                            color: Clr().white,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Rear Rhs tyre',
                  style: Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
            ),
            SizedBox(
              height: 8,
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
                      'Upload Rear Rhs Tyre Photo',
                      style: Sty().mediumText.copyWith(
                            color: Clr().white,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Back Side View',
                  style: Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
            ),
            SizedBox(
              height: 8,
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
                      'Upload Back Side Photo',
                      style: Sty().mediumText.copyWith(
                            color: Clr().white,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Dicky Door Open View',
                  style: Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
            ),
            SizedBox(
              height: 8,
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
                      'Upload Dicky Door Open Photo',
                      style: Sty().mediumText.copyWith(
                            color: Clr().white,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Dicky Floor View',
                  style: Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
            ),
            SizedBox(
              height: 8,
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
                      'Upload Dicky Floor Photo',
                      style: Sty().mediumText.copyWith(
                            color: Clr().white,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Rear Glass',
                  style: Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
            ),
            SizedBox(
              height: 8,
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
                      'Upload Rear Glass Photo',
                      style: Sty().mediumText.copyWith(
                            color: Clr().white,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Spare Wheel tyre',
                  style: Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
            ),
            SizedBox(
              height: 8,
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
                      'Upload Spare Wheel tyre Photo',
                      style: Sty().mediumText.copyWith(
                            color: Clr().white,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Rear LHS Side Triangle View',
                  style: Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
            ),
            SizedBox(
              height: 8,
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
                      'Upload LHS Side Triangle Photo',
                      style: Sty().mediumText.copyWith(
                            color: Clr().white,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Rear LHS tyre',
                  style: Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
            ),
            SizedBox(
              height: 8,
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
                      'Upload Rear LHS tyre Photo',
                      style: Sty().mediumText.copyWith(
                            color: Clr().white,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('LHS Side View',
                  style: Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
            ),
            SizedBox(
              height: 8,
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
                      'Upload LHS Side View Photo',
                      style: Sty().mediumText.copyWith(
                            color: Clr().white,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Rear Interior View ',
                  style: Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
            ),
            SizedBox(
              height: 8,
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
                      'Upload Rear Interior Photo',
                      style: Sty().mediumText.copyWith(
                            color: Clr().white,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Front LHS tyre',
                  style: Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
            ),
            SizedBox(
              height: 8,
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
                      'Upload Front LHS tyre Photo',
                      style: Sty().mediumText.copyWith(
                            color: Clr().white,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Dashboard View',
                  style: Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
            ),
            SizedBox(
              height: 8,
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
                      'Upload Dashboard View Photo',
                      style: Sty().mediumText.copyWith(
                            color: Clr().white,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Odometer View',
                  style: Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
            ),
            SizedBox(
              height: 8,
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
                      'Odometer View Photo',
                      style: Sty().mediumText.copyWith(
                            color: Clr().white,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      STM().redirect2page(ctx, VehicleDetails());
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
                      STM().redirect2page(ctx, ExteriorFrontSide());
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
