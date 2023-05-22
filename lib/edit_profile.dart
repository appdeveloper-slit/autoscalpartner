import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';

import 'manage/app_url.dart';
import 'manage/static_method.dart';
import 'profile.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

// void main() => runApp(EditProfile());

class EditProfile extends StatefulWidget {
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late BuildContext ctx;

  String? name;
  String? email;
  String? mobile;

  final formKey = GlobalKey<FormState>();

  TextEditingController updateUserMobileNumberController =
      TextEditingController();
  TextEditingController updateUserOtpController = TextEditingController();

  // change update state to send otp and vice versa
  void updateMobileNumber() {
    bool otpsend = false;
    updateUserMobileNumberController.text = "";
    updateUserOtpController.text = "";
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              title: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Color(0xff34135B),
                          Color(0xffA9163A),
                          // Color(0xff000000)
                        ],
                      ).createShader(Rect.fromLTWH(0.0, 0.0, 50.0, 15.0)),
                  child: const Text("Change Mobile Number",
                      style: TextStyle(color: Colors.white))),
              content: SizedBox(
                height: 120,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                            visible: !otpsend,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "New Mobile Number",
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: TextFormField(
                                    controller:
                                        updateUserMobileNumberController,
                                    keyboardType: TextInputType.number,
                                    maxLength: 10,
                                    decoration: const InputDecoration(
                                      counterText: "",
                                      hintText: "Enter Mobile Number",
                                      prefixIconConstraints: BoxConstraints(
                                          minWidth: 50, minHeight: 0),
                                      suffixIconConstraints: BoxConstraints(
                                          minWidth: 10, minHeight: 2),
                                      border: InputBorder.none,
                                      // prefixIcon: Icon(
                                      //   Icons.phone,
                                      //   size: iconSizeNormal(),
                                      //   color: primary(),
                                      // ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Visibility(
                            visible: otpsend,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "One Time Password",
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: TextFormField(
                                    controller: updateUserOtpController,
                                    keyboardType: TextInputType.number,
                                    maxLength: 4,
                                    decoration: InputDecoration(
                                      counterText: "",
                                      hintText: "Enter OTP",
                                      prefixIconConstraints:
                                          const BoxConstraints(
                                              minWidth: 50, minHeight: 0),
                                      suffixIconConstraints:
                                          const BoxConstraints(
                                              minWidth: 10, minHeight: 2),
                                      border: InputBorder.none,
                                      prefixIcon: ShaderMask(
                                        shaderCallback: (bounds) =>
                                            const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: <Color>[
                                            Color(0xff34135B),
                                            Color(0xffA9163A),
                                            // Color(0xff000000)
                                          ],
                                        ).createShader(Rect.fromLTWH(
                                                0.0, 0.0, 50.0, 15.0)),
                                        child: const Icon(
                                          Icons.lock,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ]),
                ),
              ),
              elevation: 0,
              actions: [
                Row(
                  children: [
                    Visibility(
                      visible: !otpsend,
                      child: Expanded(
                        child: InkWell(
                            onTap: () async {
                              if (updateUserMobileNumberController.text
                                      .toString()
                                      .isNotEmpty &&
                                  isLength(
                                      updateUserMobileNumberController.text
                                          .toString(),
                                      10)) {
                                // API UPDATE START
                                SharedPreferences sp =
                                    await SharedPreferences.getInstance();
                                load(context);
                                var dio = Dio();
                                final formdata = FormData.fromMap({
                                  "mobile": updateUserMobileNumberController
                                      .text
                                      .toString(),
                                  "page_type": "update_mobile"
                                });
                                var response = await dio.post(sendOTPUrl(),
                                    data: formdata);
                                if (globalDebugMode()) {
                                  print(response);
                                }
                                final result = response.data;
                                dismissLoad(context);
                                if (result['error'] != true) {
                                  setState(() {
                                    otpsend = true;
                                  });
                                } else {
                                  errorAlert(context, result['message']);
                                }
                                // API UPDATE END
                              } else {
                                alert(context,
                                    "Please enter the 10 digits mobile number");
                              }
                            },
                            child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF2E135D),
                                      Color(0xFFB81736)
                                    ],
                                  ),
                                ),
                                child: const Center(
                                    child: Text("Send OTP",
                                        style:
                                            TextStyle(color: Colors.white))))),
                      ),
                    ),
                    Visibility(
                      visible: otpsend,
                      child: Expanded(
                        child: InkWell(
                            onTap: () async {
                              if (updateUserOtpController.text
                                      .toString()
                                      .isNotEmpty &&
                                  isLength(
                                      updateUserOtpController.text.toString(),
                                      4)) {
                                // API UPDATE START
                                SharedPreferences sp =
                                    await SharedPreferences.getInstance();
                                load(context);
                                var dio = Dio();
                                final formdata = FormData.fromMap({
                                  "otp":
                                      updateUserOtpController.text.toString(),
                                  "mobile": updateUserMobileNumberController
                                      .text
                                      .toString(),
                                  "user_id": sp.getString("user_id").toString(),
                                });
                                var response = await dio.post(
                                    partnerChangeMobileUrl(),
                                    data: formdata);
                                if (globalDebugMode()) {
                                  print(response);
                                }
                                final result = response.data;
                                dismissLoad(context);
                                if (result['error'] != true) {
                                  setState(() {
                                    bottomAlert(context, result['message']);
                                    STM().replacePage(ctx, Profile());
                                  });
                                } else {
                                  errorAlert(context, result['message']);
                                }

                                // API UPDATE END
                              } else {
                                alert(context,
                                    "Please enter OTP in order to continue.");
                              }
                            },
                            child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF2E135D),
                                      Color(0xFFB81736)
                                    ],
                                  ),
                                ),
                                child: const Center(
                                    child: Text(
                                  "Update",
                                  style: TextStyle(color: Colors.white),
                                )))),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF2E135D),
                                    Color(0xFFB81736)
                                  ],
                                ),
                              ),
                              child: const Center(
                                  child: Text("Cancel",
                                      style: TextStyle(color: Colors.white))))),
                    ),
                  ],
                ),
              ],
              actionsAlignment: MainAxisAlignment.center,
            ),
          );
        });
  }

  void getProfileData() async {
    load(context);
    SharedPreferences sp = await SharedPreferences.getInstance();
    var dio = Dio();
    final formdata = FormData.fromMap({
      "user_id": sp.getString("user_id"),
    });
    var response = await dio.post(profileGetUrl(), data: formdata);
    if (globalDebugMode()) {
      print(response);
    }
    final result = response.data;
    dismissLoad(context);
    // if(result['error'] != true){
    setState(() {
      nameController = TextEditingController(text: result['name']);
      emailController = TextEditingController(text: result['email']);
      mobilecontroller = TextEditingController(text: result['mobile']);
    });
    // }
    // else{
    //   errorAlert(context, result['message'].toString());
    // }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();

  void updatePartnerProfile() async {
    load(context);
    SharedPreferences sp = await SharedPreferences.getInstance();
    var dio = Dio();
    final formdata = FormData.fromMap({
      "user_id": sp.getString("user_id"),
      "name": nameController.text.toString(),
      "email": emailController.text.toString()
    });
    var response = await dio.post(editPartnerProfileUrl(), data: formdata);
    if (globalDebugMode()) {
      print(response);
    }
    final result = response.data;
    dismissLoad(context);
    if (result['error'] != true) {
      STM().replacePage(ctx, Profile());
      alert(context, result['message']);
    } else {
      errorAlert(context, result['message']);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
      getProfileData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffffffff),
        leading: InkWell(
          onTap: () {
            STM().back2Previous(ctx);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xff2E135D),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              foreground: Paint()
                ..shader =  Sty().linearGradient.createShader(Rect.fromLTWH(0.0, 35.0, 200.0, 70.0))),
        ),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 4,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Full Name',
                      style: Sty()
                          .largeText
                          .copyWith(fontWeight: FontWeight.w500)),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please fill this field";
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(8),
                    // label: Text('Enter Your Number'),
                    hintText: name,

                    border: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color(0xffE4DFDF),
                    )),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Email ID',
                      style: Sty()
                          .largeText
                          .copyWith(fontWeight: FontWeight.w500)),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a valid email ID";
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(8),
                    // label: Text('Enter Your Number'),
                    hintText: email,

                    border: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color(0xffE4DFDF),
                    )),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Mobile Number',
                      style: Sty()
                          .largeText
                          .copyWith(fontWeight: FontWeight.w500)),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  readOnly: true,
                  controller: mobilecontroller,
                  // enabled: false,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(8),
                    // label: Text('Enter Your Number'),
                    suffixIcon: InkWell(
                      onTap: () {
                        updateMobileNumber();
                      },
                      child: ShaderMask(
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        shaderCallback: (bounds) =>  Sty().linearGradient.createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                      ),
                    ),

                    border: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color(0xffE4DFDF),
                    )),
                  ),
                ),
                const SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    // STM().redirect2page(ctx, Profile());
                    if (formKey.currentState!.validate()) {
                      updatePartnerProfile();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Dim().d16, horizontal: Dim().d80),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
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
                    child: Text(
                      'Update Profile',
                      style: Sty().mediumText.copyWith(
                            color: Clr().white,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
