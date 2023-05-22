import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_room_services/values/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'manage/app_url.dart';
import 'manage/static_method.dart';
import 'profile.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

// void main() => runApp(Documents());

class Documents extends StatefulWidget {
  @override
  State<Documents> createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  late BuildContext ctx;

  String? adhaarFront;
  String? adhaarBack;
  String? panCard;

  //File uploading
  void filePicker(type, userWantsCamera) async {
    bool isCamera = userWantsCamera;
    FilePickerResult? result;
    ImagePicker _picker = ImagePicker();
    XFile? photo;
    if (isCamera == true) {
      photo =
          await _picker.pickImage(source: ImageSource.camera, imageQuality: 40);
    } else {
      photo = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 40);
    }

    final image;
    if (result != null || photo != null) {
      if (isCamera == true) {
        image = await photo!.readAsBytes();
      } else {
        image = await photo!.readAsBytes();
      }
      setState(() {
        switch (type) {
          case "af":
            adhaarFront = base64Encode(image);
            break;
          case "ab":
            adhaarBack = base64Encode(image);
            break;
          case "pc":
            panCard = base64Encode(image);
            break;
        }
      });
    }
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
          'Documents',
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
              child: Text(
                'Upload Aadhar Card',
                style: TextStyle(
                  color: Color(0xff120D26),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: Dim().d16, horizontal: Dim().d20),
              decoration: BoxDecoration(
                color: Color(0xffFBF7F6),
                borderRadius: BorderRadius.circular(
                  Dim().d4,
                ),
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      filePicker('af', true);
                    },
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: Color(0xffE88B6B),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        filePicker('af', false);
                      },
                      child: SvgPicture.asset('assets/upload.svg',)),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    adhaarFront != null
                        ? 'Adhar Front Selected'
                        : 'Upload Aadhar Front Side',
                    style: Sty().mediumText.copyWith(
                        foreground: Paint()
                          ..shader = Sty().linearGradient.createShader(
                              Rect.fromLTWH(0.0, 35.0, 200.0, 70.0))),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: Dim().d16, horizontal: Dim().d20),
              decoration: BoxDecoration(
                color: Color(0xffFBF7F6),
                borderRadius: BorderRadius.circular(
                  Dim().d4,
                ),
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      filePicker('ab', true);
                    },
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: Color(0xffE88B6B),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        filePicker('ab', false);
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    adhaarBack != null
                        ? 'Adhar Back Selected'
                        : 'Upload Aadhar Back Side',
                    style: Sty().mediumText.copyWith(
                        foreground: Paint()
                          ..shader = Sty().linearGradient.createShader(
                              Rect.fromLTWH(0.0, 35.0, 200.0, 70.0))),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Upload Pan Card',
                style: TextStyle(
                  color: Color(0xff120D26),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: Dim().d16, horizontal: Dim().d20),
              decoration: BoxDecoration(
                color: Color(0xffFBF7F6),
                borderRadius: BorderRadius.circular(
                  Dim().d4,
                ),
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      filePicker('pc', true);
                    },
                    // ignore: prefer_const_constructors
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: Color(0xffE88B6B),
                    ),
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        filePicker('pc', false);
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    panCard != null ? 'Pan Card Selected' : 'Upload Pan Card',
                    style: Sty().mediumText.copyWith(
                        foreground: Paint()
                          ..shader = Sty().linearGradient.createShader(
                              Rect.fromLTWH(0.0, 35.0, 200.0, 70.0))),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            InkWell(
              onTap: () {
                // STM().redirect2page(ctx, Profile());
                if (adhaarFront != null &&
                    adhaarBack != null &&
                    panCard != null) {
                  adddocuments();
                } else {
                  errorAlert(context,
                      "Please select all the required documents in order to continue");
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: Dim().d16, horizontal: Dim().d120),
                decoration: BoxDecoration(
                  gradient: Sty().linearGradient,
                  borderRadius: BorderRadius.circular(
                    Dim().d4,
                  ),
                ),
                child: Text(
                  'Save',
                  style: Sty().mediumText.copyWith(
                      color: Clr().white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Api
  adddocuments() async {
    //Input
    SharedPreferences sp = await SharedPreferences.getInstance();
    FormData body = FormData.fromMap({
      "user_id": sp.getString("user_id"),
      "aadhar_front": adhaarFront,
      "aadhar_back": adhaarBack,
      "pan_card": panCard,
    });
    if (!mounted) return;
    var result =
        await STM().post(ctx, Str().processing, "update_document", body);
    var error = result['error'];
    var message = result['message'];
    if (!error) {
      STM().displayToast("Success");
      successAlert(ctx, message, Profile());
    } else {
      STM().errorDialog(ctx, message);
    }
  }
}
