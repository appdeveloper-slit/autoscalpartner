import 'package:flutter/material.dart';
import 'package:quick_room_services/values/colors.dart';

import 'manage/static_method.dart';
import 'rc_&_insurance_deatils.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

// void main() => runApp(CustomerDetails());

class CustomerDetails extends StatefulWidget {
  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  late BuildContext ctx;

  List<dynamic>? allData = [];
  TextEditingController purchaseCustomerNameCtrl = TextEditingController();
  TextEditingController purchaseCustomerNumberCtrl = TextEditingController();
  TextEditingController locationCtrl = TextEditingController();
  TextEditingController sellCustomerNameCtrl = TextEditingController();
  TextEditingController sellCustomerNumberCtrl = TextEditingController();
  TextEditingController location2Ctrl = TextEditingController();

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
          'Customer Details',
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
              child: Text('Purchase Customer Name',
                  style: Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: purchaseCustomerNameCtrl,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(8),
                // label: Text('Enter Your Number'),
                // hintText: "Aniket Mahakal",

                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Color(0xffE4DFDF),
                )),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Purchase Customer Number',
                  style: Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: purchaseCustomerNumberCtrl,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(8),
                // label: Text('Enter Your Number'),
                // hintText: "Aniket Mahakal",

                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Color(0xffE4DFDF),
                )),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Location ',
                  style: Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: locationCtrl,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(8),
                // label: Text('Enter Your Number'),
                // hintText: "Aniket Mahakal",

                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Color(0xffE4DFDF),
                )),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Sell Customer Name',
                  style: Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: sellCustomerNameCtrl,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(8),
                // label: Text('Enter Your Number'),
                // hintText: "Aniket Mahakal",

                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Color(0xffE4DFDF),
                )),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Sell Customer Number',
                  style: Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: sellCustomerNumberCtrl,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(8),
                // label: Text('Enter Your Number'),
                // hintText: "Aniket Mahakal",

                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Color(0xffE4DFDF),
                )),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Location',
                  style: Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: location2Ctrl,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(8),
                // label: Text('Enter Your Number'),
                // hintText: "Aniket Mahakal",

                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Color(0xffE4DFDF),
                )),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: Dim().d16, horizontal: Dim().d60),
              decoration: BoxDecoration(
                gradient: Sty().linearGradient,
                borderRadius: BorderRadius.circular(
                  Dim().d4,
                ),
              ),
              // margin: EdgeInsets.all(20),
              child: InkWell(
                onTap: () {
                  allData!.add({
                    "purchase_customer_name": purchaseCustomerNameCtrl.text,
                    "purchase_customer_number": purchaseCustomerNumberCtrl.text,
                    "location": locationCtrl.text,
                    "sell_customer_name": sellCustomerNameCtrl.text,
                    "sell_customer_number": sellCustomerNumberCtrl.text,
                    "location2": location2Ctrl.text
                  });
                  print({
                    "purchase_customer_name": purchaseCustomerNameCtrl.text,
                    "purchase_customer_number": purchaseCustomerNumberCtrl.text,
                    "location": locationCtrl.text,
                    "sell_customer_name": sellCustomerNameCtrl.text,
                    "sell_customer_number": sellCustomerNumberCtrl.text,
                    "location2": location2Ctrl.text
                  });
                  STM().redirect2page(ctx, RcInsuranceDeatils(allData));
                },
                child: Text(
                  'Next',
                  style: Sty().mediumText.copyWith(
                      color: Clr().white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
