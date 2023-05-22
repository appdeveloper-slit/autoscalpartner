import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'manage/data.dart';
import 'manage/static_method.dart';
import 'my_orders.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/strings.dart';
import 'values/styles.dart';

class Inspection extends StatefulWidget {
  final bool isEdit;
  final String sOrderID;

   Inspection(this.isEdit, this.sOrderID, {Key? key}) : super(key: key);

  @override
  State<Inspection> createState() => _InspectionState();
}

class _InspectionState extends State<Inspection> {
  late BuildContext ctx;

  ScrollController scrollCtrl = ScrollController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int pageNumber = 0;

  //Summary
  List<dynamic> summaryList = Data().summaryList;
  bool isFromSummary = true;

  //Customer Detail
  TextEditingController purchaseNameCtrl = TextEditingController();
  TextEditingController purchaseNumberCtrl = TextEditingController();
  TextEditingController purchaseLocationCtrl = TextEditingController();
  TextEditingController sellNameCtrl = TextEditingController();
  TextEditingController sellNumberCtrl = TextEditingController();
  TextEditingController sellLocationCtrl = TextEditingController();

  //RC Detail
  List<String> rcList = Data().rcList;
  String? sRc;
  String? sRc1Photo;
  List<String> rcTypeList = Data().rcTypeList;
  String? sRcType;
  String? sRc2Photo;
  List<String> insuranceTypeList = Data().insuranceTypeList;
  String? sInsuranceType;
  String? sInsurancePhoto;
  TextEditingController rcExpiryCtrl = TextEditingController();
  String? sExpiryPhoto;

  //Chassis Detail
  TextEditingController chassisNumberCtrl = TextEditingController();
  String? sChassisPhoto;
  TextEditingController chassisEngineNoCtrl = TextEditingController();
  String? sEnginePhoto;

  //Vehicle Detail
  List<String> vehicleStateList = Data().vehicleStateList;
  String? sVehicleState;
  TextEditingController vehicleNumberCtrl = TextEditingController();
  List<dynamic> vehicleMakeList = Data().vehicleMakeList;
  String? sVehicleMake;
  List<String> vehicleModelList = [];
  String? sVehicleModel;
  TextEditingController vehicleVariantCtrl = TextEditingController();
  TextEditingController mfgctrl = TextEditingController();
  TextEditingController regctrl = TextEditingController();
  TextEditingController taxvalidctrl = TextEditingController();
  List<String> arrayvehiclecolorlist = [
    'Red',
    'Yellow',
    'Orange',
    'Black',
    'White',
    'Green',
    'Gray',
    'Silver',
    'Brown',
    'Gold',
    'Beige',
    'Blue',
    'Purple'
  ];
  String? arrayvehiclecolorvalue;
  TextEditingController vehicleenginecubicctrl = TextEditingController();
  List<String> arrayvehiclefuellist = [
    'Petrol',
    'Diesel',
    'Petrol & CNG',
    'Petrol & LPG',
    'Electric'
  ];
  String? arrayfuelvalue;
  TextEditingController vehicleownerserialctrl = TextEditingController();
  TextEditingController vehicleodometerctrl = TextEditingController();
  List<String> actionList = ["Yes", "No"];
  String sAccedential = "Yes", sFlooded = "Yes";
  TextEditingController vehiclespecialcommentctrl = TextEditingController();

  List<dynamic>? thePreviousData;
  String? selectedValue;
  List<String> arrayList = ['Orginal', 'dublicate'];
  String v = "0";
  List<dynamic>? rcDataList = [];

  // time
  String? s;
  String? m;
  String? t;
  String? q;

  // vehicle Detail
  String? arrayvehiclevarientvalue;

  List<String> arrayvehiclevarientlist = ['zxi', 'syx', 'ysz'];

  // exterooir front side
  String? sFrontBumerImg;
  String? sbonnetImg;
  String? sFrontglassImg;
  String? sExtRoofImg;
  String? frontBumperDropDownSelected;
  List<dynamic> frontBumperDropDownResult = [];
  List<String> frontBumperDropDownList = [
    "Original",
    "Minor Scratches",
    "Damaged",
    "Minor Dent",
    "Repainted",
    "Major Scratches",
    "Major Dent",
    "Replace",
    "Repair"
  ];
  String? bonnetDropDownSelected;
  List<dynamic> bonnetDropDownListresult = [];
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
  List<String> arrayglassList = ['Original', 'Cracked', 'Scratches', 'Replace'];
  List<dynamic> arrayglassListresult = [];
  String? selectedValueroof;
  List<String> arrayListroof = [
    'Original',
    'Minor Scratches',
    'Minor Dent',
    'Repainted',
    'Major Scratches',
    'Major Dent',
    'Replace',
    'Repair',
    'Rusted',
  ];
  List<dynamic> arrayListroofresult = [];
  String vroof = "0";

  //exterior rhs
  String? sRsideAppImg;
  String? sRfenderImg;
  String? sRApillerImg;
  String? sRBPillerImg;
  String? sRDoorImg;
  String? sRrearDoorImg;
  String? sRrunniboardImg;
  String? sRCPillerImg;
  String? sRquaterpannelImg;
  String? rhsisdeapprronvalue;
  String? frorhstyrpervalue;
  String? rhsfendervalue;
  String? apillarvalue;
  String? bpillarvalue;
  String? frorhswindowvalue;
  String? frorhsdoorvalue;
  String? rearhsdoorvalue;
  String? rearhswindowvalue;
  String? rhsrunninboardvalue;
  String? cpillarvalue;
  String? rearhstyrpervalue;
  String? rhquatpanelvalue;
  List<String> arrayrhssideList = ['Original', 'Repair', 'Replace', 'Rusted'];
  List<dynamic> arrayrhssideListresult = [];
  List<String> arrayfrontrhspercentList = ['10%', '30%', '50%', '70%', '90%'];
  List<String> arrayrearrhspercentList = ['10%', '30%', '50%', '70%', '90%'];
  List<String> arrayrhsApillarList = [
    'Original',
    'Rusted',
    'Repair',
    'dent',
  ];
  List<dynamic> arrayrhsApillarListresult = [];
  List<String> arrayrhsCpillarList = [
    'Original',
    'Rusted',
    'Repair',
    'dent',
  ];
  List<dynamic> arrayrhsCpillarListresult = [];
  List<String> arrayrhsBpillarList = [
    'Original',
    'Rusted',
    'Repair',
    'dent',
  ];
  List<dynamic> arrayrhsBpillarListresult = [];
  List<String> arrayfrontrhswindowList = [
    'Original',
    'Replace',
    'working',
    'not working',
  ];
  List<dynamic> arrayfrontrhswindowListresult = [];
  List<String> arrayrearrhswindowList = [
    'Original',
    'Replace',
    'working',
    'not working',
  ];
  List<dynamic> arrayrearrhswindowListresult = [];
  List<String> arrayfrontrhsdoorList = [
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
  List<dynamic> arrayfrontrhsdoorListresult = [];

  List<String> quarterPanelList = [
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
  List<dynamic> quarterPanelArray = [];

  List<String> arrayrhsrunningboardList = [
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
  List<dynamic> arrayrhsrunningboardListresult = [];
  List<String> arrayrearrhsdoorList = [
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
  List<dynamic> arrayrearrhsdoorListresult = [];
  List<String> arrayrhsfenderList = [
    "Original",
    "Minor Scratches",
    "Minor Dent",
    "Repainted",
    "Major Scratches",
    "Major Dent",
    "Replace",
    "Repair",
    "Rusted",
  ];
  List<dynamic> arrayrhsfenderListresult = [];

  //exterior lhs
  String? sLsaImg;
  String? lhssideappvalue;
  String? frolhstyrpervalue;
  String? lhsfendervalue;
  String? apillarlhsvalue;
  String? bpillerlhsvalue;
  String? frolhswindowvalue;
  String? frolhsdoorvalue;
  String? realhsdoorvalue;
  String? realhswindowvalue;
  String? lhsrunnibordvalue;
  String? cpillerlhsvalue;
  String? realhstyrpervalue;
  String? lhsquapannvalue;
  String? sLfImg;
  String? sLapImg;
  String? sLbpImg;
  String? sLfdImg;
  String? sLrdImg;
  String? sLrbImg;
  String? sLcpImg;
  String? sLqpImg;
  List<String> arraylhssideList = ['Original', 'Repair', 'Replace', 'Rusted'];
  List<dynamic> arraylhssideListresult = [];
  List<String> arrayfrontlhspercentList = ['10%', '30%', '50%', '70%', '90%'];
  List<String> arrayrearlhspercentList = ['10%', '30%', '50%', '70%', '90%'];
  List<String> arraylhsApillarList = [
    'Original',
    'Rusted',
    'Repair',
    'dent',
  ];
  List<dynamic> arraylhsApillarListresult = [];
  List<String> arraylhsCpillarList = [
    'Original',
    'Rusted',
    'Repair',
    'dent',
  ];
  List<dynamic> arraylhsCpillarListresult = [];
  List<String> arraylhsBpillarList = [
    'Original',
    'Rusted',
    'Repair',
    'dent',
  ];
  List<dynamic> arraylhsBpillarListresult = [];
  List<String> arrayfrontlhswindowList = [
    'Original',
    'Replace',
    'working',
    'not working',
  ];
  List<dynamic> arrayfrontlhswindowListresult = [];
  List<String> arrayrearlhswindowList = [
    'Original',
    'Replace',
    'working',
    'not working',
  ];
  List<dynamic> arrayrearlhswindowListresult = [];
  List<String> arrayfrontlhsdoorList = [
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
  List<dynamic> arrayfrontlhsdoorListresult = [];
  List<String> arraylhsquaterpannelList = [
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
  List<dynamic> arraylhsquaterpannelListresult = [];
  List<String> arraylhsrunningboardList = [
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
  List<dynamic> arraylhsrunningboardListresult = [];
  List<String> arrayrearlhsdoorList = [
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
  List<dynamic> arrayrearlhsdoorListresult = [];
  List<String> arraylhsfenderList = [
    "Original",
    "Minor Scratches",
    "Minor Dent",
    "Repainted",
    "Major Scratches",
    "Major Dent",
    "Replace",
    "Rusted",
    "Repair"
  ];
  List<dynamic> arraylhsfenderListresult = [];

// exterior back side
  String? dickydoorvalue;
  String? rearglsvalue;
  String? dicfloocondivalue;
  String? gearshiftingvalue;
  String? sparwheetyrpercvalue;
  String? rearbumpervalue;
  String? sDickydoorImg;
  String? sRgImg;
  String? sbackDickyfloorImg;
  String? sRearBumImg;
  List<String> arraybackdickydoorList = [
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
  List<dynamic> arraybackdickydoorListresult = [];
  List<String> arraybackrearbumperList = [
    "Original",
    "Minor Scratches",
    "Minor Dent",
    "Damaged",
    "Repainted",
    "Major Scratches",
    "Major Dent",
    "Replace",
    "Repair"
  ];
  List<dynamic> arraybackrearbumperListresult = [];
  List<String> arraybackrearglassList = [
    'Original',
    'Cracked',
    'Scratches',
    'Replace'
  ];
  List<dynamic> arraybackrearglassListresult = [];
  List<String> arraybackdickyfloorconditionList = [
    'Original',
    'Rusted',
    'Damage',
    'Replace',
    'Major Dent'
  ];
  List<dynamic> arraybackdickyfloorconditionListresult = [];
  List<String> arraybacksquarewheeltyrepercentList = [
    '10%',
    '30%',
    '50%',
    '70%',
    '90%'
  ];

// interior Design
  String? airbagvalue;
  String? absvalue;
  String? musicsysvalue;
  String? speakervalue;
  String? steeringwheelcondivalue;
  String? steerwheeautcontrbuttvalue;
  String? autoacconvalue;
  String? acflowvalue;
  String? acblowermotocondvalue;
  String? acdirectmodevalue;
  String? acheatervalue;
  String? glowboxvalue;
  String? gearleveknobvalue;
  String? powerwindowvalue;
  String? rhssideseatcondivalue;
  String? lhssisdeseatcondivalue;
  String? rearseatconditivalue;
  String? allseatcoveravaivalue;
  String? allmatsavialbevalue;
  List<String> arrayairbagList = [
    'Yes',
    'No',
  ];
  List<String> arrayABSList = [
    'Yes',
    'No',
  ];
  List<String> arraymusicsystemList = ['Yes', 'No', 'Not Working'];
  List<dynamic> arraymusicsystemListresult = [];
  List<String> arrayspeakerList = ['Working', 'Not Working'];
  List<String> arraysteeringwheelconditionList = ['Good', 'Bad', 'NA'];
  List<String> arraysteeringwheelautocontrolList = [
    'Working',
    'Not Working',
    'NA'
  ];
  List<String> arrayautoacconditionList = ['Yes', 'No', 'NA'];
  List<dynamic> arrayautoacconditionListresult = [];
  List<String> arrayacflowList = [
    'Working',
    'Not Working',
  ];
  List<String> arrayacblowerList = [
    'Working',
    'Not Working',
    'Noisy',
  ];
  List<String> arrayacdirectionList = ['Working', 'Not Working'];
  List<String> arrayacheaterList = ['Working', 'Not Working'];
  List<String> arrayglowboxList = ['Working', 'Not Working'];
  List<String> arraygearleverList = ['Good', 'Bad', 'Broken'];
  List<String> arraypowerwindowList = ['Yes', 'No'];
  List<String> arrayrhssideseatList = [
    'Good',
    'Bad',
    'Wornout',
    'Mechanical Issue'
  ];
  List<String> arraylhssideseatList = [
    'Good',
    'Bad',
    'Wornout',
    'Mechanical Issue'
  ];
  List<String> arrayrearseatList = ['Good', 'Bad', 'Wornout'];
  List<String> arrayallseatcoverList = ['Yes', 'No'];
  List<String> arrayallmatsList = ['Yes', 'No'];

// testdrive
  String? frosuspensnoisevalue;
  String? axlenoisevalue;
  String? rearsuspennoisevalue;
  String? clutchcondivalue;
  String? automatigearboxvalue;
  String? gearboxvlaue;
  String? gearboxnoisevalue;
  String? wavalue;
  String? steerinnoisevalue;
  String? steericolumnoisevalue;
  String? odometerreadinvalue;
  String? speedometknobvalue;
  List<String> arraytestfrontsuspesionList = [
    'Yes',
    'No',
  ];
  List<String> arraytestaxlenoiseList = [
    'Yes',
    'No',
  ];
  List<String> arraytestrearsuspesionList = [
    'Yes',
    'No',
  ];
  List<String> arraytestclutchconditionList = [
    'Ok',
    'Worn out',
    'Sepage',
    'Jaddring',
    'Weak',
    'Hard'
  ];
  List<dynamic> arraytestclutchconditionListresult = [];
  List<String> arraytestautomaticgearList = [
    'Ok',
    'Jaddring',
    'Jerking',
    'Not Available'
  ];
  List<dynamic> arraytestautomaticgearListresult = [];
  List<String> arraytestgearboxList = [
    'Manual',
    'Automatic',
  ];
  List<String> arraytestgearboxnoiseList = [
    'Yes',
    'No',
  ];
  List<String> arraytestgearboxshiftingList = [
    'Ok',
    'Not Ok',
  ];
  List<String> arrayWaList = [
    'Ok',
    'Not Ok',
  ];
  List<String> arrayteststeeringnoiseList = [
    'Yes',
    'No',
  ];
  List<String> arrayteststeeringcolumnnoiseList = [
    'Yes',
    'No',
  ];
  List<String> arraytestspeedometerknobList = [
    'Working',
    'Not working',
  ];
  List<String> arraytestodometerreadingList = [
    'Working',
    'Not working',
  ];

// engine compartment
  List<String> arrayenginetappetnoiseList = [
    'Yes',
    'No',
  ];
  List<String> arrayengineoverheatingList = [
    'Yes',
    'No',
  ];
  List<String> arrayengineoilsludgeList = [
    'Yes',
    'No',
  ];
  List<String> conditionList = ["Good", "Bad", "Leakage"];
  List<dynamic> oilConditionArray = [];
  List<dynamic> coolentArray = [];
  List<String> arrayenginetimeingsideList = [
    'Yes',
    'No',
  ];
  List<String> arrayenginealternatornoiseList = [
    'Ok',
    'Not Ok',
  ];
  List<String> arrayenginebatteryList = [
    'Good',
    'Bad',
  ];
  List<String> arrayengineaccompressorList = ['Ok', 'Noise', 'Not Working'];
  List<dynamic> arrayengineaccompressorListresult = [];
  List<String> arrayenginestartermotorList = [
    'Yes',
    'No',
  ];
  List<String> arrayengineairfilterList = [
    'Ok',
    'Not Ok',
  ];
  TextEditingController enginevideoctrl = TextEditingController();

  // engine compartment
  String? tappetnoisevalue;
  String? engineoverheatvalue;
  String? engineoilsludgevalue;
  String? engineoilconditivalue;
  String? coolentvalue;
  String? timigsidenoisvalue;
  String? alternatecondivalue;
  String? batterycondivalue;
  String? accompressorvalue;
  String? motornoisevalue;
  String? airfilterassyvalue;

// special features
  TextEditingController comment1ctrl = TextEditingController();
  TextEditingController comment2ctrl = TextEditingController();
  TextEditingController comment3ctrl = TextEditingController();
  TextEditingController comment4ctrl = TextEditingController();
  TextEditingController comment5ctrl = TextEditingController();
  TextEditingController comment6ctrl = TextEditingController();
  TextEditingController comment7ctrl = TextEditingController();
  TextEditingController comment8ctrl = TextEditingController();
  TextEditingController comment9ctrl = TextEditingController();
  TextEditingController comment10ctrl = TextEditingController();
  TextEditingController comment11ctrl = TextEditingController();
  TextEditingController comment12ctrl = TextEditingController();
  TextEditingController comment13ctrl = TextEditingController();
  TextEditingController comment14ctrl = TextEditingController();
  TextEditingController comment15ctrl = TextEditingController();
  String? sspecomm1;
  String? sspecomm2;
  String? sspecomm3;
  String? sspecomm4;
  String? sspecomm5;
  String? sspecomm6;
  String? sspecomm7;
  String? sspecomm8;
  String? sspecomm9;
  String? sspecomm10;
  String? sspecomm11;
  String? sspecomm12;
  String? sspecomm13;
  String? sspecomm14;
  String? sspecomm15;

//any damage
  TextEditingController anydamage1ctrl = TextEditingController();
  TextEditingController anydamage2ctrl = TextEditingController();
  TextEditingController anydamage3ctrl = TextEditingController();
  TextEditingController anydamage4ctrl = TextEditingController();
  TextEditingController anydamage5ctrl = TextEditingController();
  TextEditingController anydamage6ctrl = TextEditingController();
  TextEditingController anydamage7ctrl = TextEditingController();
  TextEditingController anydamage8ctrl = TextEditingController();
  TextEditingController anydamage9ctrl = TextEditingController();
  TextEditingController anydamage10ctrl = TextEditingController();
  TextEditingController anydamage11ctrl = TextEditingController();
  TextEditingController anydamage12ctrl = TextEditingController();
  TextEditingController anydamage13ctrl = TextEditingController();
  TextEditingController anydamage14ctrl = TextEditingController();
  TextEditingController anydamage15ctrl = TextEditingController();
  TextEditingController anydamage16ctrl = TextEditingController();
  TextEditingController anydamage17ctrl = TextEditingController();
  TextEditingController anydamage18ctrl = TextEditingController();
  TextEditingController anydamage19ctrl = TextEditingController();
  TextEditingController anydamage20ctrl = TextEditingController();
  TextEditingController anydamage21ctrl = TextEditingController();
  String? sanycomm1;
  String? sanycomm2;
  String? sanycomm3;
  String? sanycomm4;
  String? sanycomm5;
  String? sanycomm6;
  String? sanycomm7;
  String? sanycomm8;
  String? sanycomm9;
  String? sanycomm10;
  String? sanycomm11;
  String? sanycomm12;
  String? sanycomm13;
  String? sanycomm14;
  String? sanycomm15;
  String? sanycomm16;
  String? sanycomm17;
  String? sanycomm18;
  String? sanycomm19;
  String? sanycomm20;

// upload photo
  String? sFrontViewImg;
  String? sFrontGlassImg;
  String? sEnginecompartImg;
  String? sRoofImg;
  String? sFrontrhssidetriImg;
  String? sFrontrhstyreImg;
  String? sRhssideviewImg;
  String? sRhssideinteriImg;
  String? sRearrhstyreImg;
  String? sBacksideImg;
  String? sDickydooropenImg;
  String? sDickyfloorImg;
  String? sRearglassImg;
  String? sSparewheelImg;
  String? sLhssidetriImg;
  String? sRearlhstyreImg;
  String? sLhssideviewImg;
  String? sRearinteriorImg;
  String? sFrontlhstyreImg;
  String? sDashboardviewImg;
  String? sOdometerviewImg;

  // rc and insurance details
  String? rc;

  // chassis details
  String? chasis;

  // uploads photos
  String? photo;

  // String? ext front side
  String? extfrtphoto;

  // string? ext rhs siode
  String? extrhsphoto;

  // string ext back side
  String? extbacphoto;

  // string exter lhs side
  String? extlhsphoto;

  // string inetroi
  String? inetrphoto;

  // string testdrive
  String? testdriphoto;

  // string testdrive
  String? engiphoto;

  @override
  void initState() {
    if (widget.isEdit)
      Future.delayed(Duration.zero, () {
        getData();
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color(0xffffffff),
        leading: InkWell(
          onTap: () {
            if (pageNumber > 0) {
              setState(() {
                if (isFromSummary) {
                  pageNumber = 0;
                } else {
                  pageNumber--;
                }
              });
            } else {
              Navigator.pop(ctx);
            }
          },
          child:  Icon(
            Icons.arrow_back_ios,
            color: Color(0xff2E135D),
          ),
        ),
        centerTitle: true,
        title: Text(
          pageNumber == 0 ? 'Inspection' : summaryList[pageNumber - 1]['name'],
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              foreground: Paint()
                ..shader =  Sty().linearGradient.createShader( Rect.fromLTWH(0.0, 35.0, 200.0, 70.0))),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (pageNumber > 0) {
            setState(() {
              if (isFromSummary) {
                pageNumber = 0;
              } else {
                pageNumber--;
              }
            });
            return false;
          } else {
            return true;
          }
        },
        child: SingleChildScrollView(
          controller: scrollCtrl,
          padding:  EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                if (pageNumber == 0) summaryLayout(),
                if (pageNumber == 1) customerDetailLayout(),
                if (pageNumber == 2) rcDetailLayout(),
                if (pageNumber == 3) chassislayout(),
                if (pageNumber == 4) vehiclelayout(),
                if (pageNumber == 5) uploadphotolayout(),
                if (pageNumber == 6) exteriorfronsidelayout(),
                if (pageNumber == 7) exteriorrhslayout(),
                if (pageNumber == 8) exteriorbackside(),
                if (pageNumber == 9) exteriorlhslayout(),
                if (pageNumber == 10) interiorlayout(),
                if (pageNumber == 11) testdrivelayout(),
                if (pageNumber == 12) enginecompartmentlayout(),
                if (pageNumber == 13) specialfeaturephotonamelayout(),
                if (pageNumber == 14) anydamagephotolayout(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Summary
  Widget summaryLayout() {
    return ListView.builder(
        shrinkWrap: true,
        physics:  NeverScrollableScrollPhysics(),
        itemCount: summaryList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(
              vertical: Dim().d8,
            ),
            child: ListTile(
              onTap: () {
                setState(() {
                  isFromSummary = true;
                  pageNumber = summaryList[index]['page'];
                  scrollCtrl.jumpTo(scrollCtrl.position.minScrollExtent);
                });
              },
              dense: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: Dim().d4,
                horizontal: Dim().d8,
              ),
              shape: RoundedRectangleBorder(
                side:  BorderSide(color: Color(0xffE4DFDF), width: 1),
                borderRadius: BorderRadius.circular(
                  Dim().d4,
                ),
              ),
              title: Text(
                '${summaryList[index]['name']}',
                style:
                     TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              trailing:  Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Color(0xff7F7A7A),
              ),
            ),
          );
        });
  }

  //Customer Detail
  Widget customerDetailLayout() {
    return StatefulBuilder(builder: (context, setState1) {
      return Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Purchase Customer Name',
                style: Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
          ),
           SizedBox(
            height: 8,
          ),
          // textField(CustomerDetailNameCtrl),
          TextFormField(
            controller: purchaseNameCtrl,
            validator: (value) {
              if (value!.isEmpty) {
                return 'This Field Is Required';
              }
              return null;
            },
            decoration:  InputDecoration(
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
            controller: purchaseNumberCtrl,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'This Field Is Required';
              }
              if (value.length != 10) {
                return 'Mobile Number must be of 10 digit';
              } else {
                return null;
              }
            },
            maxLength: 10,
            decoration:  InputDecoration(
              counterText: '',
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
            controller: purchaseLocationCtrl,
            validator: (value) {
              if (value!.isEmpty) {
                return 'This Field Is Required';
              }
              return null;
            },
            decoration:  InputDecoration(
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
            controller: sellNameCtrl,
            validator: (value) {
              if (value!.isEmpty) {
                return 'This Field Is Required';
              }
              return null;
            },
            decoration:  InputDecoration(
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
            controller: sellNumberCtrl,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'This Field Is Required';
              }
              if (value.length != 10) {
                return 'Mobile Number must be of 10 digit';
              } else {
                return null;
              }
            },
            maxLength: 10,
            decoration:  InputDecoration(
              counterText: '',
              contentPadding: EdgeInsets.all(8),
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
            controller: sellLocationCtrl,
            validator: (value) {
              if (value!.isEmpty) {
                return 'This Field Is Required';
              }
              return null;
            },
            decoration:  InputDecoration(
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
              gradient:  Sty().linearGradient,
              borderRadius: BorderRadius.circular(
                Dim().d4,
              ),
            ),
            // margin: EdgeInsets.all(20),
            child: InkWell(
              onTap: () {
                if (formKey.currentState!.validate()) {
                  setState(() {
                    pageNumber++;
                    isFromSummary = false;
                    scrollCtrl.jumpTo(scrollCtrl.position.minScrollExtent);
                  });
                } //End
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
      );
    });
  }

  //RC Detail
  Widget rcDetailLayout() {
    return StatefulBuilder(builder: (context, setState2) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'RC',
              style: Sty().largeText.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
           SizedBox(
            height: Dim().d12,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  hint: Text(sRc ?? "Select an option"),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        Sty().TextFormFieldOutlineStyle.contentPadding,
                    enabledBorder:
                        Sty().TextFormFieldOutlineStyle.enabledBorder,
                    focusedBorder:
                        Sty().TextFormFieldOutlineStyle.focusedBorder,
                    focusedErrorBorder:
                        Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                    errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                    disabledBorder:
                        Sty().TextFormFieldOutlineStyle.disabledBorder,
                  ),
                  validator: (value) => value == null ? 'field required' : null,
                  value: sRc,
                  isExpanded: true,
                  icon:  Icon(
                    Icons.keyboard_arrow_down,
                    size: 28,
                  ),
                  style:  TextStyle(color: Color(0xff000000)),
                  items: rcList.map((String string) {
                    return DropdownMenuItem<String>(
                      value: string,
                      child: Text(
                        string,
                        style:  TextStyle(
                            color: Color(0xff5B5B5B), fontSize: 14),
                      ),
                    );
                  }).toList(),
                  onChanged: (v) {
                    // STM().redirect2page(ctx, Home());
                    setState2(() {
                      sRc = v!;
                    });
                  },
                ),
              ),
               SizedBox(
                height: Dim().d20,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: Dim().d16, horizontal: Dim().d20),
                decoration: BoxDecoration(
                  color: Color(0xffFBF7F6),
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
                          setState2(() {
                            filePicker("rc1", true);
                          });
                        },
                        child:  Icon(Icons.camera_alt_outlined,
                            color: Color(0xffE88B6B)),
                      ),
                       SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          onTap: () {
                            filePicker("rc1", false);
                          },
                          child: SvgPicture.asset('assets/upload.svg')),
                       SizedBox(
                        width: 10,
                      ),
                      Text(
                        sRc1Photo != null
                            ? 'Image Selected'
                            : 'Upload RC Photo',
                        style: Sty().mediumText.copyWith(
                          color: Color(0xffE88B6B),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          rc == '1'
              ? sRc1Photo == null
                  ? Text(
                      'This Filed is Required',
                      style: Sty().mediumText.copyWith(color: Clr().red),
                    )
                  : Container()
              : Container(),
           SizedBox(height: 20),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('RC Type',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(
            height: 12,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  hint: Text(sRcType ?? "Select RC Type"),
                  validator: (value) => value == null ? 'field required' : null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        Sty().TextFormFieldOutlineStyle.contentPadding,
                    enabledBorder:
                        Sty().TextFormFieldOutlineStyle.enabledBorder,
                    focusedBorder:
                        Sty().TextFormFieldOutlineStyle.focusedBorder,
                    focusedErrorBorder:
                        Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                    errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                    disabledBorder:
                        Sty().TextFormFieldOutlineStyle.disabledBorder,
                  ),
                  value: sRcType,
                  isExpanded: true,
                  icon:  Icon(
                    Icons.keyboard_arrow_down,
                    size: 28,
                  ),
                  style:  TextStyle(color: Color(0xff000000)),
                  items: rcTypeList.map((String string) {
                    return DropdownMenuItem<String>(
                      value: string,
                      child: Text(
                        string,
                        style:  TextStyle(
                            color: Color(0xff5B5B5B), fontSize: 14),
                      ),
                    );
                  }).toList(),
                  onChanged: (v) {
                    // STM().redirect2page(ctx, Home());
                    setState2(() {
                      sRcType = v!;
                    });
                  },
                ),
              ),
               SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: Dim().d16, horizontal: Dim().d20),
                decoration: BoxDecoration(
                  color: Color(0xffFBF7F6),
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
                          setState2(() {
                            filePicker("rc2", true);
                          });
                        },
                        child:  Icon(Icons.camera_alt_outlined,
                            color: Color(0xffE88B6B)),
                      ),
                       SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          onTap: () {
                            setState2(() {
                              filePicker("rc2", false);
                            });
                          },
                          child: SvgPicture.asset('assets/upload.svg')),
                       SizedBox(
                        width: 10,
                      ),
                      Text(
                        sRc2Photo != null
                            ? 'Image Selected'
                            : 'Upload RC Photo',
                        style: Sty().mediumText.copyWith(
                          color: Color(0xffE88B6B),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          rc == '1'
              ? sRc2Photo == null
                  ? Text(
                      'This Filed is Required',
                      style: Sty().mediumText.copyWith(color: Clr().red),
                    )
                  : Container()
              : Container(),
           SizedBox(height: 20),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Insurance Type',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(
            height: 12,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  hint: Text(sInsuranceType ?? "Select Zero Dep Insurance"),
                  validator: (value) => value == null ? 'field required' : null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        Sty().TextFormFieldOutlineStyle.contentPadding,
                    enabledBorder:
                        Sty().TextFormFieldOutlineStyle.enabledBorder,
                    focusedBorder:
                        Sty().TextFormFieldOutlineStyle.focusedBorder,
                    focusedErrorBorder:
                        Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                    errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                    disabledBorder:
                        Sty().TextFormFieldOutlineStyle.disabledBorder,
                  ),
                  value: sInsuranceType,
                  isExpanded: true,
                  icon:  Icon(
                    Icons.keyboard_arrow_down,
                    size: 28,
                  ),
                  style:  TextStyle(color: Color(0xff000000)),
                  items: insuranceTypeList.map((String string) {
                    return DropdownMenuItem<String>(
                      value: string,
                      child: Text(
                        string,
                        style:  TextStyle(
                            color: Color(0xff5B5B5B), fontSize: 14),
                      ),
                    );
                  }).toList(),
                  onChanged: (v) {
                    // STM().redirect2page(ctx, Home());
                    setState2(() {
                      sInsuranceType = v!;
                    });
                  },
                ),
              ),
               SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: Dim().d16, horizontal: Dim().d20),
                decoration: BoxDecoration(
                  color:Color(0xffFBF7F6),
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
                          setState2(() {
                            filePicker("rcinsurance", true);
                          });
                        },
                        child:  Icon(Icons.camera_alt_outlined,
                            color: Color(0xffE88B6B)),
                      ),
                       SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          onTap: () {
                            setState2(() {
                              filePicker("rcinsurance", false);
                            });
                          },
                          child: SvgPicture.asset('assets/upload.svg')),
                       SizedBox(
                        width: 10,
                      ),
                      Text(
                        sInsurancePhoto != null
                            ? 'Image Selected'
                            : 'Upload Insurance Photo',
                        style: Sty().mediumText.copyWith(
                          color: Color(0xffE88B6B),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          rc == '1'
              ? sInsurancePhoto == null
                  ? Text(
                      'This Filed is Required',
                      style: Sty().mediumText.copyWith(color: Clr().red),
                    )
                  : Container()
              : Container(),
           SizedBox(height: 20),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Expiry Date',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            onTap: () {
              datePicker("re");
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'This Field is Required';
              }
              return null;
            },
            controller: rcExpiryCtrl,
            decoration: InputDecoration(
              contentPadding:  EdgeInsets.all(12),
              // label: Text('Enter Your Number'),
              hintText: "01/09/2022",
              prefixIcon: Padding(
                padding:  EdgeInsets.only(
                    left: 12, right: 20, top: 16, bottom: 12),
                child: SvgPicture.asset('assets/Calender1.svg'),
              ),
              border:  OutlineInputBorder(
                  borderSide: BorderSide(
                color: Color(0xffE4DFDF),
              )),
            ),
          ),
           SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState2(() {
                        filePicker("exp", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                   SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState2(() {
                          filePicker("exp", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                   SizedBox(
                    width: 10,
                  ),
                  Text(
                    sExpiryPhoto != null ? 'Image Selected' : 'Upload Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                        ),
                  ),
                ],
              ),
            ),
          ),
          rc == '1'
              ? sExpiryPhoto == null
                  ? Text(
                      'This Filed is Required',
                      style: Sty().mediumText.copyWith(color: Clr().red),
                    )
                  : Container()
              : Container(),
           SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: Dim().d16, horizontal: Dim().d44),
                  decoration: BoxDecoration(
                    gradient:  Sty().linearGradient,
                    borderRadius: BorderRadius.circular(
                      Dim().d4,
                    ),
                  ),
                  margin:  EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        pageNumber--;
                        isFromSummary = false;
                      });
                    },
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
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: Dim().d16, horizontal: Dim().d64),
                  decoration: BoxDecoration(
                    gradient:  Sty().linearGradient,
                    borderRadius: BorderRadius.circular(
                      Dim().d4,
                    ),
                  ),
                  // margin: EdgeInsets.all(20),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        rc = '1';
                      });
                      if (sExpiryPhoto == null) {
                        return;
                      }
                      if (sInsurancePhoto == null) {
                        return;
                      }
                      if (sRc1Photo == null) {
                        return;
                      }
                      if (sRc2Photo == null) {
                        return;
                      }
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        setState(() {
                          pageNumber++;
                          isFromSummary = false;
                          scrollCtrl
                              .jumpTo(scrollCtrl.position.minScrollExtent);
                        });
                      } //End
                    },
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
      );
    });
  }

  //Chassis Detail
  Widget chassislayout() {
    return StatefulBuilder(builder: (context, setState3) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Chassis Number',
                style: Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
          ),
           SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: chassisNumberCtrl,
            validator: (value) {
              if (value!.isEmpty) {
                return 'This Field is Required';
              }
              return null;
            },
            decoration:  InputDecoration(
              contentPadding: EdgeInsets.all(8),
              // label: Text('Enter Your Number'),
              hintText: "MAHTUS066775756",
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                color: Color(0xffE4DFDF),
              )),
            ),
          ),
           SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color:Color(0xffFBF7F6),
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
                      setState3(() {
                        filePicker("chassisphoto", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                   SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState3(() {
                          filePicker("chassisphoto", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                   SizedBox(
                    width: 10,
                  ),
                  Text(
                    sChassisPhoto != null
                        ? 'Image Selected'
                        : 'Upload Chassis Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                        ),
                  ),
                ],
              ),
            ),
          ),
          chasis == '1'
              ? sChassisPhoto == null
                  ? Text(
                      'This Filed is Required',
                      style: Sty().mediumText.copyWith(color: Clr().red),
                    )
                  : Container()
              : Container(),
           SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Engine No',
                style: Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
          ),
           SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: chassisEngineNoCtrl,
            validator: (value) {
              if (value!.isEmpty) {
                return 'This Field is Required';
              }
              return null;
            },
            decoration:  InputDecoration(
              contentPadding: EdgeInsets.all(8),
              // label: Text('Enter Your Number'),
              hintText: "GAUYTU076767",
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                color: Color(0xffE4DFDF),
              )),
            ),
          ),
           SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color:Color(0xffFBF7F6),
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
                      setState3(() {
                        filePicker("enginephoto", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                   SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState3(() {
                          filePicker("enginephoto", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                   SizedBox(
                    width: 10,
                  ),
                  Text(
                    sEnginePhoto != null
                        ? 'Image Selected'
                        : 'Upload engine Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                        ),
                  ),
                ],
              ),
            ),
          ),
          chasis == '1'
              ? sEnginePhoto == null
                  ? Text(
                      'This Filed is Required',
                      style: Sty().mediumText.copyWith(color: Clr().red),
                    )
                  : Container()
              : Container(),
           SizedBox(
            height: 320,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      pageNumber--;
                      isFromSummary = false;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Dim().d16, horizontal: Dim().d44),
                    decoration: BoxDecoration(
                      gradient:  Sty().linearGradient,
                      borderRadius: BorderRadius.circular(
                        Dim().d4,
                      ),
                    ),
                    margin:  EdgeInsets.only(right: 10),
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
                    setState(() {
                      chasis = '1';
                    });
                    if (sEnginePhoto == null) {
                      return;
                    }
                    if (sChassisPhoto == null) {
                      return;
                    }
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      setState(() {
                        pageNumber++;
                        isFromSummary = false;
                        scrollCtrl.jumpTo(scrollCtrl.position.minScrollExtent);
                      });
                    } //End
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Dim().d16, horizontal: Dim().d64),
                    decoration: BoxDecoration(
                      gradient:  Sty().linearGradient,
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
      );
    });
  }

  //vehicle detail
  Widget vehiclelayout() {
    return StatefulBuilder(builder: (context, setState4) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Vehicle State',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(
            height: 12,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  hint: Text(sVehicleState ?? "Select Vehicle State"),
                  value: sVehicleState,
                  validator: (value) => value == null ? 'field required' : null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        Sty().TextFormFieldOutlineStyle.contentPadding,
                    enabledBorder:
                        Sty().TextFormFieldOutlineStyle.enabledBorder,
                    focusedBorder:
                        Sty().TextFormFieldOutlineStyle.focusedBorder,
                    focusedErrorBorder:
                        Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                    errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                    disabledBorder:
                        Sty().TextFormFieldOutlineStyle.disabledBorder,
                  ),
                  isExpanded: true,
                  icon:  Icon(
                    Icons.keyboard_arrow_down,
                    size: 28,
                  ),
                  style:  TextStyle(color: Color(0xff000000)),
                  items: vehicleStateList.map((String string) {
                    return DropdownMenuItem<String>(
                      value: string,
                      child: Text(
                        string,
                        style:  TextStyle(
                            color: Color(0xff5B5B5B), fontSize: 14),
                      ),
                    );
                  }).toList(),
                  onChanged: (v) {
                    // STM().redirect2page(ctx, Home());
                    setState4(() {
                      sVehicleState = v!;
                    });
                  },
                ),
              ),
               SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Vehicle Number',
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
              ),
               SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: vehicleNumberCtrl,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This Field is Required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding:  EdgeInsets.all(8),
                  // label: Text('Enter Your Number'),
                  hintText: "MH43AT 6758",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dim().d8),
                      borderSide:  BorderSide(
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
              DropdownButtonHideUnderline(
                child: DropdownButtonFormField<dynamic>(
                  hint: Text(sVehicleMake ?? "Select Vehicle Make"),
                  validator: (value) => value == null ? 'field required' : null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        Sty().TextFormFieldOutlineStyle.contentPadding,
                    enabledBorder:
                        Sty().TextFormFieldOutlineStyle.enabledBorder,
                    focusedBorder:
                        Sty().TextFormFieldOutlineStyle.focusedBorder,
                    focusedErrorBorder:
                        Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                    errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                    disabledBorder:
                        Sty().TextFormFieldOutlineStyle.disabledBorder,
                  ),
                  value: sVehicleMake,
                  isExpanded: true,
                  icon:  Icon(
                    Icons.keyboard_arrow_down,
                    size: 28,
                  ),
                  style:  TextStyle(color: Color(0xff000000)),
                  items: vehicleMakeList.map((string) {
                    return DropdownMenuItem<dynamic>(
                      value: string["name"],
                      child: Text(
                        string["name"],
                        style:  TextStyle(
                            color: Color(0xff5B5B5B), fontSize: 14),
                      ),
                    );
                  }).toList(),
                  onChanged: (v) {
                    // STM().redirect2page(ctx, Home());
                    setState4(() {
                      sVehicleMake = v;
                      int position = vehicleMakeList
                          .indexWhere((element) => v == element['name']);
                      vehicleModelList = vehicleMakeList[position]['array'];
                    });
                  },
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
              DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  validator: (value) => value == null ? 'field required' : null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        Sty().TextFormFieldOutlineStyle.contentPadding,
                    enabledBorder:
                        Sty().TextFormFieldOutlineStyle.enabledBorder,
                    focusedBorder:
                        Sty().TextFormFieldOutlineStyle.focusedBorder,
                    focusedErrorBorder:
                        Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                    errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                    disabledBorder:
                        Sty().TextFormFieldOutlineStyle.disabledBorder,
                  ),
                  hint: Text(sVehicleModel ?? "Select Vehicle Model"),
                  value: sVehicleModel,
                  isExpanded: true,
                  icon:  Icon(
                    Icons.keyboard_arrow_down,
                    size: 28,
                  ),
                  style:  TextStyle(color: Color(0xff000000)),
                  items: vehicleModelList.map((String string) {
                    return DropdownMenuItem<String>(
                      value: string,
                      child: Text(
                        string,
                        style:  TextStyle(
                            color: Color(0xff5B5B5B), fontSize: 14),
                      ),
                    );
                  }).toList(),
                  onChanged: (v) {
                    // STM().redirect2page(ctx, Home());
                    setState4(() {
                      sVehicleModel = v!;
                    });
                  },
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
              TextFormField(
                controller: vehicleVariantCtrl,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This Field is Required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding:  EdgeInsets.all(8),
                  // label: Text('Varient'),
                  hintText: "AB",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dim().d8),
                      borderSide:  BorderSide(
                        color: Color(0xffE4DFDF),
                      )),
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
                readOnly: true,
                onTap: () {
                  datePicker('mfg');
                },
                controller: mfgctrl,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This Field is Required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding:  EdgeInsets.all(12),
                  // label: Text('Enter Your Number'),
                  hintText: "01/09/2022",
                  prefixIcon: Padding(
                    padding:  EdgeInsets.only(
                        left: 12, right: 20, top: 16, bottom: 12),
                    child: SvgPicture.asset('assets/Calender1.svg'),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dim().d8),
                      borderSide:  BorderSide(
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
                readOnly: true,
                onTap: () {
                  datePicker("reg");
                },
                controller: regctrl,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This Field is Required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding:  EdgeInsets.all(12),
                  // label: Text('Enter Your Number'),
                  hintText: "01/09/2022",
                  prefixIcon: Padding(
                    padding:  EdgeInsets.only(
                        left: 12, right: 20, top: 16, bottom: 12),
                    child: SvgPicture.asset('assets/Calender1.svg'),
                  ),

                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dim().d8),
                      borderSide:  BorderSide(
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
                readOnly: true,
                onTap: () {
                  datePicker("tax");
                },
                controller: taxvalidctrl,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This Field is Required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding:  EdgeInsets.all(12),
                  // label: Text('Enter Your Number'),
                  hintText: "01/09/2022",
                  prefixIcon: Padding(
                    padding:  EdgeInsets.only(
                        left: 12, right: 20, top: 16, bottom: 12),
                    child: SvgPicture.asset('assets/Calender1.svg'),
                  ),

                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dim().d8),
                      borderSide:  BorderSide(
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
              DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  validator: (value) => value == null ? 'field required' : null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        Sty().TextFormFieldOutlineStyle.contentPadding,
                    enabledBorder:
                        Sty().TextFormFieldOutlineStyle.enabledBorder,
                    focusedBorder:
                        Sty().TextFormFieldOutlineStyle.focusedBorder,
                    focusedErrorBorder:
                        Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                    errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                    disabledBorder:
                        Sty().TextFormFieldOutlineStyle.disabledBorder,
                  ),
                  hint: Text(arrayvehiclecolorvalue ?? "Select Vehicle Colour"),
                  value: arrayvehiclecolorvalue,
                  isExpanded: true,
                  icon:  Icon(
                    Icons.keyboard_arrow_down,
                    size: 28,
                  ),
                  style:  TextStyle(color: Color(0xff000000)),
                  items: arrayvehiclecolorlist.map((String string) {
                    return DropdownMenuItem<String>(
                      value: string,
                      child: Text(
                        string,
                        style:  TextStyle(
                            color: Color(0xff5B5B5B), fontSize: 14),
                      ),
                    );
                  }).toList(),
                  onChanged: (v) {
                    // STM().redirect2page(ctx, Home());
                    setState4(() {
                      arrayvehiclecolorvalue = v!;
                    });
                  },
                ),
              ),
               SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Engine Cubic Capacity',
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
              ),
               SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: vehicleenginecubicctrl,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This Field is Required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding:  EdgeInsets.all(8),
                  // label: Text('Enter Your Number'),
                  hintText: "1197",

                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dim().d8),
                      borderSide:  BorderSide(
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
              DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  hint: Text(arrayfuelvalue ?? "Select Fuel Type"),
                  validator: (value) => value == null ? 'field required' : null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        Sty().TextFormFieldOutlineStyle.contentPadding,
                    enabledBorder:
                        Sty().TextFormFieldOutlineStyle.enabledBorder,
                    focusedBorder:
                        Sty().TextFormFieldOutlineStyle.focusedBorder,
                    focusedErrorBorder:
                        Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                    errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                    disabledBorder:
                        Sty().TextFormFieldOutlineStyle.disabledBorder,
                  ),
                  value: arrayfuelvalue,
                  isExpanded: true,
                  icon:  Icon(
                    Icons.keyboard_arrow_down,
                    size: 28,
                  ),
                  style:  TextStyle(color: Color(0xff000000)),
                  items: arrayvehiclefuellist.map((String string) {
                    return DropdownMenuItem<String>(
                      value: string,
                      child: Text(
                        string,
                        style:  TextStyle(
                            color: Color(0xff5B5B5B), fontSize: 14),
                      ),
                    );
                  }).toList(),
                  onChanged: (v) {
                    // STM().redirect2page(ctx, Home());
                    setState4(() {
                      arrayfuelvalue = v!;
                    });
                  },
                ),
              ),
               SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Owner Serial No',
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
              ),
               SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: vehicleownerserialctrl,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This Field is Required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding:  EdgeInsets.all(8),
                  // label: Text('Enter Your Number'),
                  hintText: "01",

                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dim().d8),
                      borderSide:  BorderSide(
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
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
              ),
               SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: vehicleodometerctrl,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This Field is Required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding:  EdgeInsets.all(8),
                  // label: Text('Enter Your Number'),
                  hintText: "001",

                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dim().d8),
                      borderSide:  BorderSide(
                        color: Color(0xffE4DFDF),
                      )),
                ),
              ),
               SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Accedential Summary',
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
              ),
               SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Radio<String>(
                        value: actionList[0],
                        groupValue: sAccedential,
                        onChanged: (value) {
                          setState4(() {
                            sAccedential = value!;
                          });
                        },
                      ),
                       Text(
                        'Yes',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'skstandard',
                          color: Color(0xff747688),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: Dim().d16,
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: actionList[1],
                        groupValue: sAccedential,
                        onChanged: (value) {
                          setState4(() {
                            sAccedential = value!;
                          });
                        },
                      ),
                       Text(
                        'No',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'skstandard',
                          color: Color(0xff747688),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
               SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Flooded Condition',
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
              ),
               SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Radio<String>(
                        value: actionList[0],
                        groupValue: sFlooded,
                        onChanged: (value) {
                          setState4(() {
                            sFlooded = value!;
                          });
                        },
                      ),
                       Text(
                        'Yes',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'skstandard',
                          color: Color(0xff747688),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: Dim().d16,
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: actionList[1],
                        groupValue: sFlooded,
                        onChanged: (value) {
                          setState4(() {
                            sFlooded = value!;
                          });
                        },
                      ),
                       Text(
                        'No',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'skstandard',
                          color: Color(0xff747688),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
               SizedBox(
                height: 20,
              ),
               SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Special Comments',
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
              ),
               SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: vehiclespecialcommentctrl,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This Field is Required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding:  EdgeInsets.all(8),
                  // label: Text('Enter Your Number'),
                  // hintText: "01",

                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dim().d8),
                      borderSide:  BorderSide(
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
                        setState(() {
                          pageNumber--;
                          isFromSummary = false;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Dim().d16, horizontal: Dim().d44),
                        decoration: BoxDecoration(
                          gradient:  Sty().linearGradient,
                          borderRadius: BorderRadius.circular(
                            Dim().d4,
                          ),
                        ),
                        margin:  EdgeInsets.only(right: 10),
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
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            pageNumber++;
                            isFromSummary = false;
                            scrollCtrl
                                .jumpTo(scrollCtrl.position.minScrollExtent);
                          });
                        } //End
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Dim().d16, horizontal: Dim().d64),
                        decoration: BoxDecoration(
                          gradient:  Sty().linearGradient,
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
        ],
      );
    });
  }

  //uploadphotos
  Widget uploadphotolayout() {
    return StatefulBuilder(builder: (context, setState5) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              color: Color(0xffFBF7F6),
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
                      setState5(() {
                        filePicker("fvp", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState5(() {
                          filePicker("fvp", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sFrontViewImg != null
                        ? 'Image Selected'
                        : 'Front View Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          photo == '1'
              ? sFrontViewImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
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
              color: Color(0xffFBF7F6),
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
                      setState5(() {
                        filePicker("fgi", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState5(() {
                          filePicker("fgi", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sFrontGlassImg != null
                        ? 'Image Selected'
                        : 'Upload Front Glass Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          photo == '1'
              ? sFrontGlassImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
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
              color: Color(0xffFBF7F6),
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
                      setState5(() {
                        filePicker("eci", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState5(() {
                          filePicker("eci", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: Dim().d220,
                    child: Text(
                      sEnginecompartImg != null
                          ? 'Image Selected'
                          : 'Upload Engine Compartment Photo',
                      style: Sty().mediumText.copyWith(
                          color: Color(0xffE88B6B), overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
            ),
          ),
          photo == '1'
              ? sEnginecompartImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
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
              color: Color(0xffFBF7F6),
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
                      setState5(() {
                        filePicker("ri", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState5(() {
                          filePicker("ri", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sRoofImg != null ? 'Image Selected' : 'Upload Roof Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          photo == '1'
              ? sRoofImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
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
            padding:  EdgeInsets.only(
              top: 16,
              bottom: 16,
              left: 12,
            ),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState5(() {
                        filePicker("frsti", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState5(() {
                          filePicker("frsti", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: Dim().d220,
                    child: Text(
                      sFrontrhssidetriImg != null
                          ? 'Image Selected'
                          : 'Upload Front Rhs side Triangle View Photo',
                      style: Sty().smallText.copyWith(
                          color: Color(0xffE88B6B), overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
            ),
          ),
          photo == '1'
              ? sFrontrhssidetriImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
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
              color: Color(0xffFBF7F6),
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
                      setState5(() {
                        filePicker("frtyi", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState5(() {
                          filePicker("frtyi", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sFrontrhstyreImg != null
                        ? 'Image Selected'
                        : 'Upload Front Rhs tyre Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          photo == '1'
              ? sFrontrhstyreImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
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
              color: Color(0xffFBF7F6),
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
                      setState5(() {
                        filePicker("rsvi", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState5(() {
                          filePicker("rsvi", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sRhssideviewImg != null
                        ? 'Image Selected'
                        : 'Upload Rhs Side View Photo',
                    style: Sty().mediumText.copyWith(
                        color: Color(0xffE88B6B)
                    ),
                  ),
                ],
              ),
            ),
          ),
          photo == '1'
              ? sRhssideviewImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
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
              color: Color(0xffFBF7F6),
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
                      setState5(() {
                        filePicker("rsii", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState5(() {
                          filePicker("rsii", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sRhssideinteriImg != null
                        ? 'Image Selected'
                        : 'Upload Rhs Side Interior Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          photo == '1'
              ? sRhssideinteriImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
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
              color: Color(0xffFBF7F6),
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
                      setState5(() {
                        filePicker("rrtyi", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState5(() {
                          filePicker("rrtyi", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sRearrhstyreImg != null
                        ? 'Image Selected'
                        : 'Upload Rear Rhs Tyre Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          photo == '1'
              ? sRearrhstyreImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
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
              color: Color(0xffFBF7F6),
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
                      setState5(() {
                        filePicker("bsi", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState5(() {
                          filePicker("bsi", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sBacksideImg != null
                        ? 'Image Selected'
                        : 'Upload Back Side Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          photo == '1'
              ? sBacksideImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
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
              color: Color(0xffFBF7F6),
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
                      setState5(() {
                        filePicker("ddoi", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState5(() {
                          filePicker("ddoi", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sDickydooropenImg != null
                        ? 'Image Selected'
                        : 'Upload Dicky Door Open Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          photo == '1'
              ? sDickydooropenImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
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
              color: Color(0xffFBF7F6),
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
                      setState5(() {
                        filePicker("dfi", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState5(() {
                          filePicker("dfi", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sDickyfloorImg != null
                        ? 'Image Selected'
                        : 'Upload Dicky Floor Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          photo == '1'
              ? sDickyfloorImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
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
              color: Color(0xffFBF7F6),
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
                      setState5(() {
                        filePicker("rgi", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState5(() {
                          filePicker("rgi", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sRearglassImg != null
                        ? 'Image Selected'
                        : 'Upload Rear Glass Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          photo == '1'
              ? sRearglassImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
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
              color: Color(0xffFBF7F6),
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
                      setState5(() {
                        filePicker("sweei", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState5(() {
                          filePicker("sweei", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sSparewheelImg != null
                        ? 'Image Selected'
                        : 'Upload Spare Wheel tyre Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          photo == '1'
              ? sSparewheelImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
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
              color: Color(0xffFBF7F6),
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
                      setState5(() {
                        filePicker("lsti", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState5(() {
                          filePicker("lsti", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sLhssidetriImg != null
                        ? 'Image Selected'
                        : 'Upload LHS Side Triangle Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          photo == '1'
              ? sLhssidetriImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
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
              color: Color(0xffFBF7F6),
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
                      setState5(() {
                        filePicker("rltyi", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState5(() {
                          filePicker("rltyi", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sRearlhstyreImg != null
                        ? 'Image Selected'
                        : 'Upload Rear LHS tyre Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          photo == '1'
              ? sRearlhstyreImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
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
              color: Color(0xffFBF7F6),
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
                      setState5(() {
                        filePicker("lsvi", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState5(() {
                          filePicker("lsvi", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sLhssideviewImg != null
                        ? 'Image Selected'
                        : 'Upload LHS Side View Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          photo == '1'
              ? sLhssideviewImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Rear Interior View',
                style: Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState5(() {
                        filePicker("rii", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState5(() {
                          filePicker("rii", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sRearinteriorImg != null
                        ? 'Image Selected'
                        : 'Upload Rear Interior Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          photo == '1'
              ? sRearinteriorImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
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
              color: Color(0xffFBF7F6),
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
                      setState5(() {
                        filePicker("fltyi", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState5(() {
                          filePicker("fltyi", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sFrontlhstyreImg != null
                        ? 'Image Selected'
                        : 'Upload Front LHS tyre Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          photo == '1'
              ? sFrontlhstyreImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
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
              color: Color(0xffFBF7F6),
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
                      setState5(() {
                        filePicker("dbvi", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState5(() {
                          filePicker("dbvi", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sDashboardviewImg != null
                        ? 'Image Selected'
                        : 'Upload Dashboard View Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          photo == '1'
              ? sDashboardviewImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
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
              color: Color(0xffFBF7F6),
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
                      setState5(() {
                        filePicker("omevi", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState5(() {
                          filePicker("omevi", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sOdometerviewImg != null
                        ? 'Image Selected'
                        : 'Odometer View Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          photo == '1'
              ? sOdometerviewImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      pageNumber--;
                      isFromSummary = false;
                    });
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
                    margin:  EdgeInsets.only(right: 10),
                    child: Center(
                      child: Text(
                        'Previous',
                        style: Sty().mediumText.copyWith(
                            color: Colors.white,
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
                    setState(() {
                      photo = '1';
                    });
                    if (sFrontViewImg == null) {
                      return;
                    }
                    if (sFrontGlassImg == null) {
                      return;
                    }
                    if (sEnginecompartImg == null) {
                      return;
                    }
                    if (sRoofImg == null) {
                      return;
                    }
                    if (sFrontrhssidetriImg == null) {
                      return;
                    }
                    if (sFrontrhstyreImg == null) {
                      return;
                    }
                    if (sRhssideviewImg == null) {
                      return;
                    }
                    if (sRhssideinteriImg == null) {
                      return;
                    }
                    if (sRearrhstyreImg == null) {
                      return;
                    }
                    if (sBacksideImg == null) {
                      return;
                    }
                    if (sDickydooropenImg == null) {
                      return;
                    }
                    if (sDickyfloorImg == null) {
                      return;
                    }
                    if (sRearglassImg == null) {
                      return;
                    }
                    if (sSparewheelImg == null) {
                      return;
                    }
                    if (sLhssidetriImg == null) {
                      return;
                    }
                    if (sRearlhstyreImg == null) {
                      return;
                    }
                    if (sLhssideviewImg == null) {
                      return;
                    }
                    if (sRearinteriorImg == null) {
                      return;
                    }
                    if (sFrontlhstyreImg == null) {
                      return;
                    }
                    if (sDashboardviewImg == null) {
                      return;
                    }
                    if (sOdometerviewImg == null) {
                      return;
                    }
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        pageNumber++;
                        isFromSummary = false;
                        scrollCtrl.jumpTo(scrollCtrl.position.minScrollExtent);
                      });
                    } //End
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
                            color: Colors.white,
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
      );
    });
  }

  //exteriorfrontside
  Widget exteriorfronsidelayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Front Bumper',
                style: Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
        SizedBox(
          height: 12,
        ),
        MultiSelectDialogField(
          dialogHeight: 350,
          dialogWidth: 450,
          initialValue: frontBumperDropDownResult.isEmpty
              ? null
              : frontBumperDropDownResult,
          items: frontBumperDropDownList
              .map((value) => MultiSelectItem<String>(value, value))
              .toList(),
          title: Text(
            "Front bumper",
            style: Sty().mediumText.copyWith(
              color: Clr().hintColor,
            ),
          ),
          selectedColor: Clr().black,
          decoration: Sty().outlineBoxStyle,
          buttonText: Text(
            "Select front bumper",
            style: Sty().mediumText.copyWith(
              color: Clr().lightGrey,
            ),
          ),
          buttonIcon:  Icon(
            Icons.keyboard_arrow_down,
            size: 28,
          ),
          onConfirm: (results) {
            setState(() {
              frontBumperDropDownResult = results;
              ////FocusManager.instance.primaryFocus!.unfocus();
            });
          },
        ),
        extfrtphoto == '1'
            ? frontBumperDropDownResult.isEmpty
            ? Text(
          'This Filed is Required',
          style: Sty().mediumText.copyWith(color: Clr().red),
        )
            : Container()
            : Container(),
        SizedBox(
          height: 20,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Photo of Scratches, dent & repair',
                style: Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
        SizedBox(
          height: 12,
        ),
        Container(
          padding:
          EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            color: Color(0xffFBF7F6),
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
                    filePicker("fbi", true);
                  },
                  child:  Icon(Icons.camera_alt_outlined,
                      color: Color(0xffE88B6B)),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      filePicker("fbi", false);
                    },
                    child: SvgPicture.asset('assets/upload.svg')),
                SizedBox(
                  width: 10,
                ),
                Text(
                  sFrontBumerImg != null
                      ? 'Image Selected'
                      : 'Upload Chassis Photo',
                  style: Sty().mediumText.copyWith(
                    color: Color(0xffE88B6B),
                  ),
                ),
              ],
            ),
          ),
        ),
        extfrtphoto == '1'
            ? sFrontBumerImg == null
            ? Text(
          'This Filed is Required',
          style: Sty().mediumText.copyWith(color: Clr().red),
        )
            : Container()
            : Container(),
        SizedBox(
          height: Dim().d20,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Bonnet',
                style: Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
        SizedBox(
          height: 12,
        ),
        MultiSelectDialogField(
          dialogHeight: 350,
          dialogWidth: 450,
          initialValue: bonnetDropDownListresult.isEmpty
              ? null
              : bonnetDropDownListresult,
          items: bonnetDropDownList
              .map((value) => MultiSelectItem<String>(value, value))
              .toList(),
          title: Text(
            "Front bonnet",
            style: Sty().mediumText.copyWith(
              color: Clr().hintColor,
            ),
          ),
          selectedColor: Clr().black,
          decoration: Sty().outlineBoxStyle,
          buttonText: Text(
            "Select bonnet",
            style: Sty().mediumText.copyWith(
              color: Clr().lightGrey,
            ),
          ),
          buttonIcon:  Icon(
            Icons.keyboard_arrow_down,
            size: 28,
          ),
          onConfirm: (results) {
            setState(() {
              bonnetDropDownListresult = results;
              ////FocusManager.instance.primaryFocus!.unfocus();
            });
          },
        ),
        extfrtphoto == '1'
            ? bonnetDropDownListresult.isEmpty
            ? Text(
          'This Filed is Required',
          style: Sty().mediumText.copyWith(color: Clr().red),
        )
            : Container()
            : Container(),
        SizedBox(
          height: 20,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Photo of Scratches, dent & repair',
                style: Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
        SizedBox(
          height: 12,
        ),
        Container(
          padding:
          EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            color: Color(0xffFBF7F6),
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
                    filePicker("bi", true);
                  },
                  child:  Icon(Icons.camera_alt_outlined,
                      color: Color(0xffE88B6B)),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      filePicker("bi", false);
                    },
                    child: SvgPicture.asset('assets/upload.svg')),
                SizedBox(
                  width: 10,
                ),
                Text(
                  sbonnetImg != null ? 'Image Selected' : 'Upload Bonnet Photo',
                  style: Sty().mediumText.copyWith(
                    color: Color(0xffE88B6B),
                  ),
                ),
              ],
            ),
          ),
        ),
        extfrtphoto == '1'
            ? sbonnetImg == null
            ? Text(
          'This Filed is Required',
          style: Sty().mediumText.copyWith(color: Clr().red),
        )
            : Container()
            : Container(),
        SizedBox(
          height: Dim().d20,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Front Glass',
                style: Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
        SizedBox(
          height: 12,
        ),
        MultiSelectDialogField(
          dialogHeight: 350,
          dialogWidth: 450,
          initialValue:
          arrayglassListresult.isEmpty ? null : arrayglassListresult,
          items: arrayglassList
              .map((value) => MultiSelectItem<String>(value, value))
              .toList(),
          title: Text(
            "Front glass",
            style: Sty().mediumText.copyWith(
              color: Clr().hintColor,
            ),
          ),
          selectedColor: Clr().black,
          decoration: Sty().outlineBoxStyle,
          buttonText: Text(
            "select front glass",
            style: Sty().mediumText.copyWith(
              color: Clr().lightGrey,
            ),
          ),
          buttonIcon:  Icon(
            Icons.keyboard_arrow_down,
            size: 28,
          ),
          onConfirm: (results) {
            setState(() {
              arrayglassListresult = results;
              ////FocusManager.instance.primaryFocus!.unfocus();
            });
          },
        ),
        extfrtphoto == '1'
            ? arrayglassListresult.isEmpty
            ? Text(
          'This Filed is Required',
          style: Sty().mediumText.copyWith(color: Clr().red),
        )
            : Container()
            : Container(),
        SizedBox(
          height: 20,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Photo of Scratches, dent & repair',
                style: Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
        SizedBox(
          height: 12,
        ),
        Container(
          padding:
          EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            color: Color(0xffFBF7F6),
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
                    filePicker("frgi", true);
                  },
                  child:  Icon(Icons.camera_alt_outlined,
                      color: Color(0xffE88B6B)),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      filePicker("frgi", false);
                    },
                    child: SvgPicture.asset('assets/upload.svg')),
                SizedBox(
                  width: 10,
                ),
                Text(
                  sFrontglassImg != null ? 'Image Selected' : 'Upload Photo',
                  style: Sty().mediumText.copyWith(
                    color: Color(0xffE88B6B),
                  ),
                ),
              ],
            ),
          ),
        ),
        extfrtphoto == '1'
            ? sFrontglassImg == null
            ? Text(
          'This Filed is Required',
          style: Sty().mediumText.copyWith(color: Clr().red),
        )
            : Container()
            : Container(),
        SizedBox(
          height: Dim().d20,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Roof',
                style: Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
        SizedBox(
          height: 12,
        ),
        MultiSelectDialogField(
          dialogHeight: 350,
          dialogWidth: 450,
          initialValue:
          arrayListroofresult.isEmpty ? null : arrayListroofresult,
          items: arrayListroof
              .map((value) => MultiSelectItem<String>(value, value))
              .toList(),
          title: Text(
            "Front Roof",
            style: Sty().mediumText.copyWith(
              color: Clr().hintColor,
            ),
          ),
          selectedColor: Clr().black,
          decoration: Sty().outlineBoxStyle,
          buttonText: Text(
            "Select Roof",
            style: Sty().mediumText.copyWith(
              color: Clr().lightGrey,
            ),
          ),
          buttonIcon:  Icon(
            Icons.keyboard_arrow_down,
            size: 28,
          ),
          onConfirm: (roof) {
            setState(() {
              arrayListroofresult = roof;
            });
          },
        ),
        extfrtphoto == '1'
            ? arrayListroofresult.isEmpty
            ? Text(
          'This Filed is Required',
          style: Sty().mediumText.copyWith(color: Clr().red),
        )
            : Container()
            : Container(),
        SizedBox(
          height: 20,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Photo of Scratches, dent & repair',
                style: Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
        SizedBox(
          height: 12,
        ),
        Container(
          padding:
          EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            color: Color(0xffFBF7F6),
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
                    filePicker("eri", true);
                  },
                  child:  Icon(Icons.camera_alt_outlined,
                      color: Color(0xffE88B6B)),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      filePicker("eri", false);
                    },
                    child: SvgPicture.asset('assets/upload.svg')),
                SizedBox(
                  width: 10,
                ),
                Text(
                  sExtRoofImg != null ? 'Image Selected' : 'Upload Photo',
                  style: Sty().mediumText.copyWith(
                    color: Color(0xffE88B6B),
                  ),
                ),
              ],
            ),
          ),
        ),
        extfrtphoto == '1'
            ? sExtRoofImg == null
            ? Text(
          'This Filed is Required',
          style: Sty().mediumText.copyWith(color: Clr().red),
        )
            : Container()
            : Container(),
        SizedBox(
          height: Dim().d32,
        ),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    pageNumber--;
                    isFromSummary = false;
                  });
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
                  margin:  EdgeInsets.only(right: 10),
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
                  setState(() {
                    extfrtphoto = '1';
                  });
                  if (sFrontBumerImg == null) {
                    return;
                  }
                  if (sbonnetImg == null) {
                    return;
                  }
                  if (sFrontglassImg == null) {
                    return;
                  }
                  if (sExtRoofImg == null) {
                    return;
                  }
                  if (frontBumperDropDownResult.isEmpty) {
                    return;
                  }
                  if (bonnetDropDownListresult.isEmpty) {
                    return;
                  }
                  if (arrayglassListresult.isEmpty) {
                    return;
                  }
                  if (arrayListroofresult.isEmpty) {
                    return;
                  }
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      pageNumber++;
                      isFromSummary = false;
                      scrollCtrl.jumpTo(scrollCtrl.position.minScrollExtent);
                    });
                  } //End
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
    );
  }

  //exteriorrhs
  Widget exteriorrhslayout() {
    return StatefulBuilder(builder: (context, setState7) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Rhs side Appron',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          MultiSelectDialogField(
            dialogHeight: 350,
            dialogWidth: 450,
            initialValue:
            arrayrhssideListresult.isEmpty ? null : arrayrhssideListresult,
            items: arrayrhssideList
                .map((value) => MultiSelectItem<String>(value, value))
                .toList(),
            title: Text(
              "RHS Side Appron",
              style: Sty().mediumText.copyWith(
                color: Clr().hintColor,
              ),
            ),
            selectedColor: Clr().black,
            decoration: Sty().outlineBoxStyle,
            buttonText: Text(
              "Select RHS Side Appron",
              style: Sty().mediumText.copyWith(
                color: Clr().lightGrey,
              ),
            ),
            buttonIcon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            onConfirm: (results) {
              setState7(() {
                arrayrhssideListresult = results;
                //FocusManager.instance.primaryFocus!.unfocus();
              });
            },
          ),
          extrhsphoto == '1'
              ? arrayrhssideListresult.isEmpty
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Photo of Repair, Replace & Rusted',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      filePicker("Rsai", true);
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        filePicker("Rsai", false);
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sRsideAppImg != null ? 'Image Selected' : 'Upload Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          extrhsphoto == '1'
              ? sRsideAppImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Front Rhs tyre percentage',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              hint:
              Text(frorhstyrpervalue ?? "Select Front RHS Tyre percentage"),
              value: frorhstyrpervalue,
              isExpanded: true,
              validator: (value) => value == null ? 'field required' : null,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
                enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                focusedErrorBorder:
                Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
              ),
              icon:  Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              style:  TextStyle(color: Color(0xff000000)),
              items: arrayfrontrhspercentList.map((String string) {
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
                setState7(() {
                  frorhstyrpervalue = v!;
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Rhs Fender',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          MultiSelectDialogField(
            dialogHeight: 350,
            dialogWidth: 450,
            initialValue: arrayrhsfenderListresult.isEmpty
                ? null
                : arrayrhsfenderListresult,
            items: arrayrhsfenderList
                .map((value) => MultiSelectItem<String>(value, value))
                .toList(),
            title: Text(
              "RHS Fendor",
              style: Sty().mediumText.copyWith(
                color: Clr().hintColor,
              ),
            ),
            selectedColor: Clr().black,
            decoration: Sty().outlineBoxStyle,
            buttonText: Text(
              "Select RHS Fendor",
              style: Sty().mediumText.copyWith(
                color: Clr().lightGrey,
              ),
            ),
            buttonIcon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            onConfirm: (results) {
              setState7(() {
                arrayrhsfenderListresult = results;
                ////FocusManager.instance.primaryFocus!.unfocus();
              });
            },
          ),
          extrhsphoto == '1'
              ? arrayrhsfenderListresult.isEmpty
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Photo of Scratches, dent & repair',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      filePicker("Rfi", true);
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        filePicker("Rfi", false);
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sRfenderImg != null ? 'Image Selected' : 'Upload Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          extrhsphoto == '1'
              ? sRfenderImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('A Piller',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          MultiSelectDialogField(
            dialogHeight: 350,
            dialogWidth: 450,
            initialValue: arrayrhsApillarListresult.isEmpty
                ? null
                : arrayrhsApillarListresult,
            items: arrayrhsApillarList
                .map((value) => MultiSelectItem<String>(value, value))
                .toList(),
            title: Text(
              "A Piller",
              style: Sty().mediumText.copyWith(
                color: Clr().hintColor,
              ),
            ),
            selectedColor: Clr().black,
            decoration: Sty().outlineBoxStyle,
            buttonText: Text(
              "Select A Piller",
              style: Sty().mediumText.copyWith(
                color: Clr().lightGrey,
              ),
            ),
            buttonIcon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            onConfirm: (results) {
              setState7(() {
                arrayrhsApillarListresult = results;
                ////FocusManager.instance.primaryFocus!.unfocus();
              });
            },
          ),
          extrhsphoto == '1'
              ? arrayrhsApillarListresult.isEmpty
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Photo of Repair, dent & rusted',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      filePicker("Rai", true);
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        filePicker("Rai", false);
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sRApillerImg != null ? 'Image Selected' : 'Upload Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          extrhsphoto == '1'
              ? sRApillerImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('B Piller',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          MultiSelectDialogField(
            dialogHeight: 350,
            dialogWidth: 450,
            initialValue: arrayrhsBpillarListresult.isEmpty
                ? null
                : arrayrhsBpillarListresult,
            items: arrayrhsBpillarList
                .map((value) => MultiSelectItem<String>(value, value))
                .toList(),
            title: Text(
              "B Piller",
              style: Sty().mediumText.copyWith(
                color: Clr().hintColor,
              ),
            ),
            selectedColor: Clr().black,
            decoration: Sty().outlineBoxStyle,
            buttonText: Text(
              "Select B Piller",
              style: Sty().mediumText.copyWith(
                color: Clr().lightGrey,
              ),
            ),
            buttonIcon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            onConfirm: (results) {
              setState7(() {
                arrayrhsBpillarListresult = results;
                ////FocusManager.instance.primaryFocus!.unfocus();
              });
            },
          ),
          extrhsphoto == '1'
              ? arrayrhsBpillarListresult.isEmpty
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Photo of Repair, dent & rusted',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      filePicker("Rbpi", true);
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        filePicker("Rbpi", false);
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sRBPillerImg != null ? 'Image Selected' : 'Upload Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          extrhsphoto == '1'
              ? sRBPillerImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Front Rhs Window',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          MultiSelectDialogField(
            dialogHeight: 350,
            dialogWidth: 450,
            initialValue: arrayfrontrhswindowListresult.isEmpty
                ? null
                : arrayfrontrhswindowListresult,
            items: arrayfrontrhswindowList
                .map((value) => MultiSelectItem<String>(value, value))
                .toList(),
            title: Text(
              "Front RHS Window",
              style: Sty().mediumText.copyWith(
                color: Clr().hintColor,
              ),
            ),
            selectedColor: Clr().black,
            decoration: Sty().outlineBoxStyle,
            buttonText: Text(
              "Select Front RHS Window",
              style: Sty().mediumText.copyWith(
                color: Clr().lightGrey,
              ),
            ),
            buttonIcon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            onConfirm: (results) {
              setState7(() {
                arrayfrontrhswindowListresult = results;
                ////FocusManager.instance.primaryFocus!.unfocus();
              });
            },
          ),
          extrhsphoto == '1'
              ? arrayfrontrhswindowListresult.isEmpty
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Front Rhs Door',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          MultiSelectDialogField(
            dialogHeight: 350,
            dialogWidth: 450,
            initialValue: arrayfrontrhsdoorListresult.isEmpty
                ? null
                : arrayfrontrhsdoorListresult,
            items: arrayfrontrhsdoorList
                .map((value) => MultiSelectItem<String>(value, value))
                .toList(),
            title: Text(
              "Front RHS Door",
              style: Sty().mediumText.copyWith(
                color: Clr().hintColor,
              ),
            ),
            selectedColor: Clr().black,
            decoration: Sty().outlineBoxStyle,
            buttonText: Text(
              "Select Front RHS Door",
              style: Sty().mediumText.copyWith(
                color: Clr().lightGrey,
              ),
            ),
            buttonIcon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            onConfirm: (results) {
              setState7(() {
                arrayfrontrhsdoorListresult = results;
                ////FocusManager.instance.primaryFocus!.unfocus();
              });
            },
          ),
          extrhsphoto == '1'
              ? arrayfrontrhsdoorListresult.isEmpty
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Photo of Scratches, dent & repair',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      filePicker("Rdoi", true);
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        filePicker("Rdoi", false);
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sRDoorImg != null ? 'Image Selected' : 'Upload Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          extrhsphoto == '1'
              ? sRDoorImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Rear Rhs Door',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          MultiSelectDialogField(
            dialogHeight: 350,
            dialogWidth: 450,
            initialValue: arrayrearrhsdoorListresult.isEmpty
                ? null
                : arrayrearrhsdoorListresult,
            items: arrayrearrhsdoorList
                .map((value) => MultiSelectItem<String>(value, value))
                .toList(),
            title: Text(
              "Rear RHS Door",
              style: Sty().mediumText.copyWith(
                color: Clr().hintColor,
              ),
            ),
            selectedColor: Clr().black,
            decoration: Sty().outlineBoxStyle,
            buttonText: Text(
              "Select Rear RHS Door",
              style: Sty().mediumText.copyWith(
                color: Clr().lightGrey,
              ),
            ),
            buttonIcon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            onConfirm: (results) {
              setState7(() {
                arrayrearrhsdoorListresult = results;
                ////FocusManager.instance.primaryFocus!.unfocus();
              });
            },
          ),
          extrhsphoto == '1'
              ? arrayrearrhsdoorListresult.isEmpty
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Photo of Scratches, dent & repair',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      filePicker("Rdi", true);
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        filePicker("Rdi", false);
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sRrearDoorImg != null ? 'Image Selected' : 'Upload Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          extrhsphoto == '1'
              ? sRrearDoorImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Rear Rhs Window',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          MultiSelectDialogField(
            dialogHeight: 350,
            dialogWidth: 450,
            initialValue: arrayrearrhswindowListresult.isEmpty
                ? null
                : arrayrearrhswindowListresult,
            items: arrayrearrhswindowList
                .map((value) => MultiSelectItem<String>(value, value))
                .toList(),
            title: Text(
              "Rear RHS Window",
              style: Sty().mediumText.copyWith(
                color: Clr().hintColor,
              ),
            ),
            selectedColor: Clr().black,
            decoration: Sty().outlineBoxStyle,
            buttonText: Text(
              "Select Rear RHS Window",
              style: Sty().mediumText.copyWith(
                color: Clr().lightGrey,
              ),
            ),
            buttonIcon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            onConfirm: (results) {
              setState7(() {
                arrayrearrhswindowListresult = results;
                ////FocusManager.instance.primaryFocus!.unfocus();
              });
            },
          ),
          extrhsphoto == '1'
              ? arrayrearrhswindowListresult.isEmpty
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Rhs Running board',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          MultiSelectDialogField(
            dialogHeight: 350,
            dialogWidth: 450,
            initialValue: arrayrhsrunningboardListresult.isEmpty
                ? null
                : arrayrhsrunningboardListresult,
            items: arrayrhsrunningboardList
                .map((value) => MultiSelectItem<String>(value, value))
                .toList(),
            title: Text(
              "RHS Running Board",
              style: Sty().mediumText.copyWith(
                color: Clr().hintColor,
              ),
            ),
            selectedColor: Clr().black,
            decoration: Sty().outlineBoxStyle,
            buttonText: Text(
              "Select RHS Running Board",
              style: Sty().mediumText.copyWith(
                color: Clr().lightGrey,
              ),
            ),
            buttonIcon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            onConfirm: (results) {
              setState7(() {
                arrayrhsrunningboardListresult = results;
                ////FocusManager.instance.primaryFocus!.unfocus();
              });
            },
          ),
          extrhsphoto == '1'
              ? arrayrhsrunningboardListresult.isEmpty
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Photo of Scratches, dent & repair',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      filePicker("Rrbi", true);
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        filePicker("Rrbi", false);
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sRrunniboardImg != null ? 'Image Selected' : 'Upload Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          extrhsphoto == '1'
              ? sRrunniboardImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('C Piller',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          MultiSelectDialogField(
            dialogHeight: 350,
            dialogWidth: 450,
            initialValue: arrayrhsCpillarListresult.isEmpty
                ? null
                : arrayrhsCpillarListresult,
            items: arrayrhsCpillarList
                .map((value) => MultiSelectItem<String>(value, value))
                .toList(),
            title: Text(
              "C Piller",
              style: Sty().mediumText.copyWith(
                color: Clr().hintColor,
              ),
            ),
            selectedColor: Clr().black,
            decoration: Sty().outlineBoxStyle,
            buttonText: Text(
              "Select C Piller",
              style: Sty().mediumText.copyWith(
                color: Clr().lightGrey,
              ),
            ),
            buttonIcon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            onConfirm: (results) {
              setState7(() {
                arrayrhsCpillarListresult = results;
                ////FocusManager.instance.primaryFocus!.unfocus();
              });
            },
          ),
          extrhsphoto == '1'
              ? arrayrhsCpillarListresult.isEmpty
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Photo of Scratches, dent & repair',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      filePicker("Rcpi", true);
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        filePicker("Rcpi", false);
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sRCPillerImg != null ? 'Image Selected' : 'Upload Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          extrhsphoto == '1'
              ? sRCPillerImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Rear Rhs Tyre percentage',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              hint: Text(rearhstyrpervalue ?? "Select Rear RHS Percentage"),
              value: rearhstyrpervalue,
              isExpanded: true,
              icon:  Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              validator: (value) => value == null ? 'field required' : null,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
                enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                focusedErrorBorder:
                Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
              ),
              style:  TextStyle(color: Color(0xff000000)),
              items: arrayrearrhspercentList.map((String string) {
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
                setState7(() {
                  rearhstyrpervalue = v!;
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Rhs quater panel',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          StatefulBuilder(builder: (context, setStateRhs) {
            return MultiSelectDialogField(
              dialogHeight: 350,
              dialogWidth: 450,
              initialValue:
              quarterPanelArray.isEmpty ? null : quarterPanelArray,
              items: quarterPanelList
                  .map((value) => MultiSelectItem<String>(value, value))
                  .toList(),
              title: Text(
                "RHS quater panel",
                style: Sty().mediumText.copyWith(
                  color: Clr().hintColor,
                ),
              ),
              selectedColor: Clr().black,
              decoration: Sty().outlineBoxStyle,
              buttonText: Text(
                "Select RHS quater panel",
                style: Sty().mediumText.copyWith(
                  color: Clr().lightGrey,
                ),
              ),
              buttonIcon:  Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              onConfirm: (rhs) {
                setStateRhs(() {
                  quarterPanelArray = rhs;
                });
              },
            );
          }),
          extrhsphoto == '1'
              ? quarterPanelArray.isEmpty
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Photo of Scratches, dent & repair',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      filePicker("Rqpi", true);
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        filePicker("Rqpi", false);
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sRquaterpannelImg != null
                        ? 'Image Selected'
                        : 'Upload Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          extrhsphoto == '1'
              ? sRquaterpannelImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      pageNumber--;
                      isFromSummary = false;
                    });
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
                    margin:  EdgeInsets.only(right: 10),
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
                    setState(() {
                      extrhsphoto = '1';
                    });
                    if (arrayrhssideListresult.isEmpty) {
                      return;
                    }
                    if (sRsideAppImg == null) {
                      return;
                    }
                    if (arrayrhsfenderListresult.isEmpty) {
                      return;
                    }
                    if (sRfenderImg == null) {
                      return;
                    }
                    if (arrayrhsApillarListresult.isEmpty) {
                      return;
                    }
                    if (sRApillerImg == null) {
                      return;
                    }
                    if (arrayrhsBpillarListresult.isEmpty) {
                      return;
                    }
                    if (sRBPillerImg == null) {
                      return;
                    }
                    if (arrayfrontrhswindowListresult.isEmpty) {
                      return;
                    }
                    if (arrayfrontrhsdoorListresult.isEmpty) {
                      return;
                    }
                    if (sRDoorImg == null) {
                      return;
                    }
                    if (arrayrearrhsdoorListresult.isEmpty) {
                      return;
                    }
                    if (sRrearDoorImg == null) {
                      return;
                    }
                    if (arrayrearrhswindowListresult.isEmpty) {
                      return;
                    }
                    if (arrayrhsrunningboardListresult.isEmpty) {
                      return;
                    }
                    if (sRrunniboardImg == null) {
                      return;
                    }
                    if (arrayrhsCpillarListresult.isEmpty) {
                      return;
                    }
                    if (sRCPillerImg == null) {
                      return;
                    }
                    if (quarterPanelArray.isEmpty) {
                      return;
                    }
                    if (sRquaterpannelImg == null) {
                      return;
                    }
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        pageNumber++;
                        isFromSummary = false;
                        scrollCtrl.jumpTo(scrollCtrl.position.minScrollExtent);
                      });
                    } //End
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
      );
    });
  }

  //exteriorbackside
  Widget exteriorbackside() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Dicky Door',
                style: Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
        SizedBox(
          height: 12,
        ),
        MultiSelectDialogField(
          dialogHeight: 350,
          dialogWidth: 450,
          initialValue: arraybackdickydoorListresult.isEmpty
              ? null
              : arraybackdickydoorListresult,
          items: arraybackdickydoorList
              .map((value) => MultiSelectItem<String>(value, value))
              .toList(),
          title: Text(
            "Dicky Door",
            style: Sty().mediumText.copyWith(
              color: Clr().hintColor,
            ),
          ),
          selectedColor: Clr().black,
          decoration: Sty().outlineBoxStyle,
          buttonText: Text(
            "Select Dicky Door",
            style: Sty().mediumText.copyWith(
              color: Clr().lightGrey,
            ),
          ),
          buttonIcon:  Icon(
            Icons.keyboard_arrow_down,
            size: 28,
          ),
          onConfirm: (results) {
            setState(() {
              arraybackdickydoorListresult = results;
              ////FocusManager.instance.primaryFocus!.unfocus();
            });
          },
        ),
        extbacphoto == '1'
            ? arraybackdickydoorListresult.isEmpty
            ? Text(
          'This Filed is Required',
          style: Sty().mediumText.copyWith(color: Clr().red),
        )
            : Container()
            : Container(),
        SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Photo of Scratches, dent & repair',
            style: Sty().largeText.copyWith(fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          padding:
          EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            color: Color(0xffFBF7F6),
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
                    filePicker("Ddi", true);
                  },
                  child:  Icon(Icons.camera_alt_outlined,
                      color: Color(0xffE88B6B)),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      filePicker("Ddi", false);
                    },
                    child: SvgPicture.asset('assets/upload.svg')),
                SizedBox(
                  width: 10,
                ),
                Text(
                  sDickydoorImg != null ? 'Image Selected' : 'Upload Photo',
                  style: Sty().mediumText.copyWith(
                    color: Color(0xffE88B6B),
                  ),
                ),
              ],
            ),
          ),
        ),
        extbacphoto == '1'
            ? sDickydoorImg == null
            ? Text(
          'This Filed is Required',
          style: Sty().mediumText.copyWith(color: Clr().red),
        )
            : Container()
            : Container(),
        SizedBox(
          height: 20,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Rear Glass',
                style: Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
        SizedBox(
          height: 12,
        ),
        MultiSelectDialogField(
          dialogHeight: 350,
          dialogWidth: 450,
          initialValue: arraybackrearglassListresult.isEmpty
              ? null
              : arraybackrearglassListresult,
          items: arraybackrearglassList
              .map((value) => MultiSelectItem<String>(value, value))
              .toList(),
          title: Text(
            "Rear Glass",
            style: Sty().mediumText.copyWith(
              color: Clr().hintColor,
            ),
          ),
          selectedColor: Clr().black,
          decoration: Sty().outlineBoxStyle,
          buttonText: Text(
            "Select Rear Glass",
            style: Sty().mediumText.copyWith(
              color: Clr().lightGrey,
            ),
          ),
          buttonIcon:  Icon(
            Icons.keyboard_arrow_down,
            size: 28,
          ),
          onConfirm: (results) {
            setState(() {
              arraybackrearglassListresult = results;
              ////FocusManager.instance.primaryFocus!.unfocus();
            });
          },
        ),
        extbacphoto == '1'
            ? arraybackrearglassListresult.isEmpty
            ? Text(
          'This Filed is Required',
          style: Sty().mediumText.copyWith(color: Clr().red),
        )
            : Container()
            : Container(),
        SizedBox(
          height: 20,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Photo of Scratches, dent & repair',
                style: Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
        SizedBox(
          height: 12,
        ),
        Container(
          padding:
          EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            color: Color(0xffFBF7F6),
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
                    filePicker("Rgi", true);
                  },
                  child:  Icon(Icons.camera_alt_outlined,
                      color: Color(0xffE88B6B)),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      filePicker("Rgi", false);
                    },
                    child: SvgPicture.asset('assets/upload.svg')),
                SizedBox(
                  width: 10,
                ),
                Text(
                  sRgImg != null ? 'Image Selected' : 'Upload Photo',
                  style: Sty().mediumText.copyWith(
                    color: Color(0xffE88B6B),
                  ),
                ),
              ],
            ),
          ),
        ),
        extbacphoto == '1'
            ? sRgImg == null
            ? Text(
          'This Filed is Required',
          style: Sty().mediumText.copyWith(color: Clr().red),
        )
            : Container()
            : Container(),
        SizedBox(
          height: 20,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Dicky Floor Condition',
                style: Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
        SizedBox(
          height: 12,
        ),
        MultiSelectDialogField(
          dialogHeight: 350,
          dialogWidth: 450,
          initialValue: arraybackdickyfloorconditionListresult.isEmpty
              ? null
              : arraybackdickyfloorconditionListresult,
          items: arraybackdickyfloorconditionList
              .map((value) => MultiSelectItem<String>(value, value))
              .toList(),
          title: Text(
            "Dicky Floor Condition",
            style: Sty().mediumText.copyWith(
              color: Clr().hintColor,
            ),
          ),
          selectedColor: Clr().black,
          decoration: Sty().outlineBoxStyle,
          buttonText: Text(
            "Select Dicky Floor Condition",
            style: Sty().mediumText.copyWith(
              color: Clr().lightGrey,
            ),
          ),
          buttonIcon:  Icon(
            Icons.keyboard_arrow_down,
            size: 28,
          ),
          onConfirm: (results) {
            setState(() {
              arraybackdickyfloorconditionListresult = results;
              ////FocusManager.instance.primaryFocus!.unfocus();
            });
          },
        ),
        extbacphoto == '1'
            ? arraybackdickyfloorconditionListresult.isEmpty
            ? Text(
          'This Filed is Required',
          style: Sty().mediumText.copyWith(color: Clr().red),
        )
            : Container()
            : Container(),
        SizedBox(
          height: 20,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Photo of Repair, dent & rusted',
                style: Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
        SizedBox(
          height: 12,
        ),
        Container(
          padding:
          EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            color: Color(0xffFBF7F6),
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
                    filePicker("bdfi", true);
                  },
                  child:  Icon(Icons.camera_alt_outlined,
                      color: Color(0xffE88B6B)),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      filePicker("bdfi", false);
                    },
                    child: SvgPicture.asset('assets/upload.svg')),
                SizedBox(
                  width: 10,
                ),
                Text(
                  sbackDickyfloorImg != null
                      ? 'Image Selected'
                      : 'Upload Photo',
                  style: Sty().mediumText.copyWith(
                    color: Color(0xffE88B6B),
                  ),
                ),
              ],
            ),
          ),
        ),
        extbacphoto == '1'
            ? sbackDickyfloorImg == null
            ? Text(
          'This Filed is Required',
          style: Sty().mediumText.copyWith(color: Clr().red),
        )
            : Container()
            : Container(),
        SizedBox(
          height: 20,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Spare Wheel tyre percentage',
                style: Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
        SizedBox(
          height: 12,
        ),
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            hint: Text(
                sparwheetyrpercvalue ?? "Select Spare Wheel Tyre percentage"),
            value: sparwheetyrpercvalue,
            isExpanded: true,
            icon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            validator: (value) => value == null ? 'field required' : null,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
              enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
              focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
              focusedErrorBorder:
              Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
              errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
              disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
            ),
            style:  TextStyle(color: Color(0xff000000)),
            items: arraybacksquarewheeltyrepercentList.map((String string) {
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
                sparwheetyrpercvalue = v!;
              });
            },
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Rear Bumper',
                style: Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
        SizedBox(
          height: 12,
        ),
        MultiSelectDialogField(
          dialogHeight: 350,
          dialogWidth: 450,
          initialValue: arraybackrearbumperListresult.isEmpty
              ? null
              : arraybackrearbumperListresult,
          items: arraybackrearbumperList
              .map((value) => MultiSelectItem<String>(value, value))
              .toList(),
          title: Text(
            "Rear Bumper",
            style: Sty().mediumText.copyWith(
              color: Clr().hintColor,
            ),
          ),
          selectedColor: Clr().black,
          decoration: Sty().outlineBoxStyle,
          buttonText: Text(
            "Select Rear Bumper",
            style: Sty().mediumText.copyWith(
              color: Clr().lightGrey,
            ),
          ),
          buttonIcon:  Icon(
            Icons.keyboard_arrow_down,
            size: 28,
          ),
          onConfirm: (results) {
            setState(() {
              arraybackrearbumperListresult = results;
              ////FocusManager.instance.primaryFocus!.unfocus();
            });
          },
        ),
        extbacphoto == '1'
            ? arraybackrearbumperListresult.isEmpty
            ? Text(
          'This Filed is Required',
          style: Sty().mediumText.copyWith(color: Clr().red),
        )
            : Container()
            : Container(),
        SizedBox(
          height: 20,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Photo of Scratches, dent & repair',
                style: Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
        SizedBox(
          height: 12,
        ),
        Container(
          padding:
          EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            color: Color(0xffFBF7F6),
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
                    filePicker("rbi", true);
                  },
                  child:  Icon(Icons.camera_alt_outlined,
                      color: Color(0xffE88B6B)),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      filePicker("rbi", false);
                    },
                    child: SvgPicture.asset('assets/upload.svg')),
                SizedBox(
                  width: 10,
                ),
                Text(
                  sRearBumImg != null ? 'Image Selected' : 'Upload Photo',
                  style: Sty().mediumText.copyWith(
                    color: Color(0xffE88B6B),
                  ),
                ),
              ],
            ),
          ),
        ),
        extbacphoto == '1'
            ? sRearBumImg == null
            ? Text(
          'This Filed is Required',
          style: Sty().mediumText.copyWith(color: Clr().red),
        )
            : Container()
            : Container(),
        SizedBox(
          height: 50,
        ),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    pageNumber--;
                    isFromSummary = false;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: Dim().d16, horizontal: Dim().d44),
                  decoration: BoxDecoration(
                    gradient:  Sty().linearGradient,
                    borderRadius: BorderRadius.circular(
                      Dim().d4,
                    ),
                  ),
                  margin:  EdgeInsets.only(right: 10),
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
                  setState(() {
                    extbacphoto = '1';
                  });
                  if (arraybackdickydoorListresult.isEmpty) {
                    return;
                  }
                  if (sDickydoorImg == null) {
                    return;
                  }
                  if (arraybackrearglassListresult.isEmpty) {
                    return;
                  }
                  if (sRgImg == null) {
                    return;
                  }
                  if (arraybackdickyfloorconditionListresult.isEmpty) {
                    return;
                  }
                  if (sbackDickyfloorImg == null) {
                    return;
                  }
                  if (arraybackrearbumperListresult.isEmpty) {
                    return;
                  }
                  if (sRearBumImg == null) {
                    return;
                  }
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      pageNumber++;
                      isFromSummary = false;
                      scrollCtrl.jumpTo(scrollCtrl.position.minScrollExtent);
                    });
                  } //End
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: Dim().d16, horizontal: Dim().d64),
                  decoration: BoxDecoration(
                    gradient:  Sty().linearGradient,
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
    );
  }

  //exteriorlhs
  Widget exteriorlhslayout() {
    return StatefulBuilder(builder: (context, setState9) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Lhs side Appron',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          MultiSelectDialogField(
            dialogHeight: 350,
            dialogWidth: 450,
            initialValue:
            arraylhssideListresult.isEmpty ? null : arraylhssideListresult,
            items: arraylhssideList
                .map((value) => MultiSelectItem<String>(value, value))
                .toList(),
            title: Text(
              "Side Appron",
              style: Sty().mediumText.copyWith(
                color: Clr().hintColor,
              ),
            ),
            selectedColor: Clr().black,
            decoration: Sty().outlineBoxStyle,
            buttonText: Text(
              "Select side Appron",
              style: Sty().mediumText.copyWith(
                color: Clr().lightGrey,
              ),
            ),
            buttonIcon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            onConfirm: (results) {
              setState9(() {
                arraylhssideListresult = results;
                ////FocusManager.instance.primaryFocus!.unfocus();
              });
            },
          ),
          extlhsphoto == '1'
              ? arraylhssideListresult.isEmpty
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Photo of Repair, Replace & Rusted',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      filePicker("lsa", true);
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        filePicker("lsa", false);
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sLsaImg != null ? 'Image Selected' : 'Upload Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          extlhsphoto == '1'
              ? sLsaImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Front Lhs tyre percentage',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              hint: Text(frolhstyrpervalue ?? 'Select tyre percentage'),
              value: frolhstyrpervalue,
              validator: (value) => value == null ? 'field required' : null,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
                enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                focusedErrorBorder:
                Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
              ),
              isExpanded: true,
              icon:  Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              style:  TextStyle(color: Color(0xff000000)),
              items: arrayfrontlhspercentList.map((String string) {
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
                setState9(() {
                  frolhstyrpervalue = v!;
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Lhs Fender',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          MultiSelectDialogField(
            dialogHeight: 350,
            dialogWidth: 450,
            initialValue: arraylhsfenderListresult.isEmpty
                ? null
                : arraylhsfenderListresult,
            items: arraylhsfenderList
                .map((value) => MultiSelectItem<String>(value, value))
                .toList(),
            title: Text(
              "lhs fender",
              style: Sty().mediumText.copyWith(
                color: Clr().hintColor,
              ),
            ),
            selectedColor: Clr().black,
            decoration: Sty().outlineBoxStyle,
            buttonText: Text(
              "Select lhs fender",
              style: Sty().mediumText.copyWith(
                color: Clr().lightGrey,
              ),
            ),
            buttonIcon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            onConfirm: (results) {
              setState9(() {
                arraylhsfenderListresult = results;
                ////FocusManager.instance.primaryFocus!.unfocus();
              });
            },
          ),
          extlhsphoto == '1'
              ? arraylhsfenderListresult.isEmpty
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Photo of Scratches, dent & repair',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      filePicker("lfi", true);
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        filePicker("lfi", false);
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sLfImg != null ? 'Image Selected' : 'Upload Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          extlhsphoto == '1'
              ? sLfImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('A Piller',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          MultiSelectDialogField(
            dialogHeight: 350,
            dialogWidth: 450,
            initialValue: arraylhsApillarListresult.isEmpty
                ? null
                : arraylhsApillarListresult,
            items: arraylhsApillarList
                .map((value) => MultiSelectItem<String>(value, value))
                .toList(),
            title: Text(
              "A Piller",
              style: Sty().mediumText.copyWith(
                color: Clr().hintColor,
              ),
            ),
            selectedColor: Clr().black,
            decoration: Sty().outlineBoxStyle,
            buttonText: Text(
              "Select A Piller",
              style: Sty().mediumText.copyWith(
                color: Clr().lightGrey,
              ),
            ),
            buttonIcon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            onConfirm: (results) {
              setState9(() {
                arraylhsApillarListresult = results;
                ////FocusManager.instance.primaryFocus!.unfocus();
              });
            },
          ),
          extlhsphoto == '1'
              ? arraylhsApillarListresult.isEmpty
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Photo of Repair, dent & rusted',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      filePicker("lapi", true);
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        filePicker("lapi", false);
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sLapImg != null ? 'Image Selected' : 'Upload Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          extlhsphoto == '1'
              ? sLapImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('B Piller',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          MultiSelectDialogField(
            dialogHeight: 350,
            dialogWidth: 450,
            initialValue: arraylhsBpillarListresult.isEmpty
                ? null
                : arraylhsBpillarListresult,
            items: arraylhsBpillarList
                .map((value) => MultiSelectItem<String>(value, value))
                .toList(),
            title: Text(
              "B Piller",
              style: Sty().mediumText.copyWith(
                color: Clr().hintColor,
              ),
            ),
            selectedColor: Clr().black,
            decoration: Sty().outlineBoxStyle,
            buttonText: Text(
              "Select B Piller",
              style: Sty().mediumText.copyWith(
                color: Clr().lightGrey,
              ),
            ),
            buttonIcon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            onConfirm: (results) {
              setState9(() {
                arraylhsBpillarListresult = results;
                ////FocusManager.instance.primaryFocus!.unfocus();
              });
            },
          ),
          extlhsphoto == '1'
              ? arraylhsBpillarListresult.isEmpty
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Photo of Repair, dent & rusted',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      filePicker("lbpi", true);
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        filePicker("lbpi", false);
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sLbpImg != null ? 'Image Selected' : 'Upload Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          extlhsphoto == '1'
              ? sLbpImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Front Lhs Window',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          MultiSelectDialogField(
            dialogHeight: 350,
            dialogWidth: 450,
            initialValue: arrayfrontlhswindowListresult.isEmpty
                ? null
                : arrayfrontlhswindowListresult,
            items: arrayfrontlhswindowList
                .map((value) => MultiSelectItem<String>(value, value))
                .toList(),
            title: Text(
              "Ext lhs window",
              style: Sty().mediumText.copyWith(
                color: Clr().hintColor,
              ),
            ),
            selectedColor: Clr().black,
            decoration: Sty().outlineBoxStyle,
            buttonText: Text(
              "Select Ext lhs window",
              style: Sty().mediumText.copyWith(
                color: Clr().lightGrey,
              ),
            ),
            buttonIcon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            onConfirm: (results) {
              setState9(() {
                arrayfrontlhswindowListresult = results;
                ////FocusManager.instance.primaryFocus!.unfocus();
              });
            },
          ),
          extlhsphoto == '1'
              ? arrayfrontlhswindowListresult.isEmpty
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Front Lhs Door',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          MultiSelectDialogField(
            dialogHeight: 350,
            dialogWidth: 450,
            initialValue: arrayfrontlhsdoorListresult.isEmpty
                ? null
                : arrayfrontlhsdoorListresult,
            items: arrayfrontlhsdoorList
                .map((value) => MultiSelectItem<String>(value, value))
                .toList(),
            title: Text(
              "Ext lhs door",
              style: Sty().mediumText.copyWith(
                color: Clr().hintColor,
              ),
            ),
            selectedColor: Clr().black,
            decoration: Sty().outlineBoxStyle,
            buttonText: Text(
              "Select Ext lhs door",
              style: Sty().mediumText.copyWith(
                color: Clr().lightGrey,
              ),
            ),
            buttonIcon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            onConfirm: (results) {
              setState9(() {
                arrayfrontlhsdoorListresult = results;
                ////FocusManager.instance.primaryFocus!.unfocus();
              });
            },
          ),
          extlhsphoto == '1'
              ? arrayfrontlhsdoorListresult.isEmpty
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Photo of Scratches, dent & repair',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      filePicker("lfdi", true);
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        filePicker("lfdi", false);
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sLfdImg != null ? 'Image Selected' : 'Upload Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          extlhsphoto == '1'
              ? sLfdImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Rear Lhs Door',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          MultiSelectDialogField(
            dialogHeight: 350,
            dialogWidth: 450,
            initialValue: arrayrearlhsdoorListresult.isEmpty
                ? null
                : arrayrearlhsdoorListresult,
            items: arrayrearlhsdoorList
                .map((value) => MultiSelectItem<String>(value, value))
                .toList(),
            title: Text(
              "rear lhs door",
              style: Sty().mediumText.copyWith(
                color: Clr().hintColor,
              ),
            ),
            selectedColor: Clr().black,
            decoration: Sty().outlineBoxStyle,
            buttonText: Text(
              "Select rear lhs door",
              style: Sty().mediumText.copyWith(
                color: Clr().lightGrey,
              ),
            ),
            buttonIcon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            onConfirm: (results) {
              setState9(() {
                arrayrearlhsdoorListresult = results;
                ////FocusManager.instance.primaryFocus!.unfocus();
              });
            },
          ),
          extlhsphoto == '1'
              ? arrayrearlhsdoorListresult.isEmpty
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Photo of Scratches, dent & repair',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      filePicker("lrdi", true);
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        filePicker("lrdi", false);
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sLrdImg != null ? 'Image Selected' : 'Upload Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          extlhsphoto == '1'
              ? sLrdImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Rear Lhs Window',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          MultiSelectDialogField(
            dialogHeight: 350,
            dialogWidth: 450,
            initialValue: arrayrearlhswindowListresult.isEmpty
                ? null
                : arrayrearlhswindowListresult,
            items: arrayrearlhswindowList
                .map((value) => MultiSelectItem<String>(value, value))
                .toList(),
            title: Text(
              "rear lhs window",
              style: Sty().mediumText.copyWith(
                color: Clr().hintColor,
              ),
            ),
            selectedColor: Clr().black,
            decoration: Sty().outlineBoxStyle,
            buttonText: Text(
              "Select rear lhs window",
              style: Sty().mediumText.copyWith(
                color: Clr().lightGrey,
              ),
            ),
            buttonIcon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            onConfirm: (results) {
              setState9(() {
                arrayrearlhswindowListresult = results;
                ////FocusManager.instance.primaryFocus!.unfocus();
              });
            },
          ),
          extlhsphoto == '1'
              ? arrayrearlhswindowListresult.isEmpty
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Lhs Running board',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          MultiSelectDialogField(
            dialogHeight: 350,
            dialogWidth: 450,
            initialValue: arraylhsrunningboardListresult.isEmpty
                ? null
                : arraylhsrunningboardListresult,
            items: arraylhsrunningboardList
                .map((value) => MultiSelectItem<String>(value, value))
                .toList(),
            title: Text(
              "lhs running board",
              style: Sty().mediumText.copyWith(
                color: Clr().hintColor,
              ),
            ),
            selectedColor: Clr().black,
            decoration: Sty().outlineBoxStyle,
            buttonText: Text(
              "Select lhs running board",
              style: Sty().mediumText.copyWith(
                color: Clr().lightGrey,
              ),
            ),
            buttonIcon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            onConfirm: (results) {
              setState9(() {
                arraylhsrunningboardListresult = results;
                ////FocusManager.instance.primaryFocus!.unfocus();
              });
            },
          ),
          extlhsphoto == '1'
              ? arraylhsrunningboardListresult.isEmpty
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Photo of Scratches, dent & repair',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      filePicker("lrbi", true);
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        filePicker("lrbi", false);
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sLrbImg != null ? 'Image Selected' : 'Upload Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          extlhsphoto == '1'
              ? sLrbImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('C Piller',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          MultiSelectDialogField(
            dialogHeight: 350,
            dialogWidth: 450,
            initialValue: arraylhsCpillarListresult.isEmpty
                ? null
                : arraylhsCpillarListresult,
            items: arraylhsCpillarList
                .map((value) => MultiSelectItem<String>(value, value))
                .toList(),
            title: Text(
              "C Piller",
              style: Sty().mediumText.copyWith(
                color: Clr().hintColor,
              ),
            ),
            selectedColor: Clr().black,
            decoration: Sty().outlineBoxStyle,
            buttonText: Text(
              "Select C Piller",
              style: Sty().mediumText.copyWith(
                color: Clr().lightGrey,
              ),
            ),
            buttonIcon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            onConfirm: (results) {
              setState9(() {
                arraylhsCpillarListresult = results;
                ////FocusManager.instance.primaryFocus!.unfocus();
              });
            },
          ),
          extlhsphoto == '1'
              ? arraylhsCpillarListresult.isEmpty
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Photo of Repair, dent & rusted',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      filePicker("lcpi", true);
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        filePicker("lcpi", false);
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sLcpImg != null ? 'Image Selected' : 'Upload Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          extlhsphoto == '1'
              ? sLcpImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Rear Lhs Tyre percentage',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              hint: Text(realhstyrpervalue ?? 'Select rear lhs tyre percent'),
              value: realhstyrpervalue,
              isExpanded: true,
              icon:  Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              validator: (value) => value == null ? 'field required' : null,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
                enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                focusedErrorBorder:
                Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
              ),
              style:  TextStyle(color: Color(0xff000000)),
              items: arrayrearlhspercentList.map((String string) {
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
                setState9(() {
                  realhstyrpervalue = v!;
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Lhs quater panel',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          MultiSelectDialogField(
            dialogHeight: 350,
            dialogWidth: 450,
            initialValue: arraylhsquaterpannelListresult.isEmpty
                ? null
                : arraylhsquaterpannelListresult,
            items: arraylhsquaterpannelList
                .map((value) => MultiSelectItem<String>(value, value))
                .toList(),
            title: Text(
              "lhs quater panel",
              style: Sty().mediumText.copyWith(
                color: Clr().hintColor,
              ),
            ),
            selectedColor: Clr().black,
            decoration: Sty().outlineBoxStyle,
            buttonText: Text(
              "Select lhs quater panel",
              style: Sty().mediumText.copyWith(
                color: Clr().lightGrey,
              ),
            ),
            buttonIcon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            onConfirm: (results) {
              setState9(() {
                arraylhsquaterpannelListresult = results;
                ////FocusManager.instance.primaryFocus!.unfocus();
              });
            },
          ),
          extlhsphoto == '1'
              ? arraylhsquaterpannelListresult.isEmpty
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Photo of Scratches, dent & repair',
                  style:
                  Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      filePicker("lqpi", true);
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        filePicker("lqpi", false);
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sLqpImg != null ? 'Image Selected' : 'Upload Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          extlhsphoto == '1'
              ? sLqpImg == null
              ? Text(
            'This Filed is Required',
            style: Sty().mediumText.copyWith(color: Clr().red),
          )
              : Container()
              : Container(),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      pageNumber--;
                      isFromSummary = false;
                    });
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
                    margin:  EdgeInsets.only(right: 10),
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
                    setState(() {
                      extlhsphoto = '1';
                    });
                    if (arraylhssideListresult.isEmpty) {
                      return;
                    }
                    if (sLsaImg == null) {
                      return;
                    }
                    if (arraylhsfenderListresult.isEmpty) {
                      return;
                    }
                    if (sLfImg == null) {
                      return;
                    }
                    if (arraylhsApillarListresult.isEmpty) {
                      return;
                    }
                    if (sLapImg == null) {
                      return;
                    }
                    if (arraylhsBpillarListresult.isEmpty) {
                      return;
                    }
                    if (sLbpImg == null) {
                      return;
                    }
                    if (arrayfrontlhswindowListresult.isEmpty) {
                      return;
                    }
                    if (arrayfrontlhsdoorListresult.isEmpty) {
                      return;
                    }
                    if (sLfdImg == null) {
                      return;
                    }
                    if (arrayrearlhsdoorListresult.isEmpty) {
                      return;
                    }
                    if (sLrdImg == null) {
                      return;
                    }
                    if (arrayrearlhswindowListresult.isEmpty) {
                      return;
                    }
                    if (arraylhsrunningboardListresult.isEmpty) {
                      return;
                    }
                    if (sLrbImg == null) {
                      return;
                    }
                    if (arraylhsCpillarListresult.isEmpty) {
                      return;
                    }
                    if (sLcpImg == null) {
                      return;
                    }
                    if (arraylhsquaterpannelListresult.isEmpty) {
                      return;
                    }
                    if (sLqpImg == null) {
                      return;
                    }
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        pageNumber++;
                        isFromSummary = false;
                        scrollCtrl.jumpTo(scrollCtrl.position.minScrollExtent);
                      });
                    } //End
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
      );
    });
  }

  //interior
  Widget interiorlayout() {
    return StatefulBuilder(builder: (context, setState10) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Airbag',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(
            height: 12,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              hint: Text(airbagvalue ?? 'Select airbag'),
              value: airbagvalue,
              isExpanded: true,
              icon:  Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              validator: (value) => value == null ? 'field required' : null,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
                enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                focusedErrorBorder:
                    Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
              ),
              style:  TextStyle(color: Color(0xff000000)),
              items: arrayairbagList.map((String string) {
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
                setState10(() {
                  airbagvalue = v!;
                });
              },
            ),
          ),
           SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('ABS',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(
            height: 12,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              hint: Text(absvalue ?? 'Select abs'),
              value: absvalue,
              isExpanded: true,
              icon:  Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              validator: (value) => value == null ? 'field required' : null,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
                enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                focusedErrorBorder:
                    Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
              ),
              style:  TextStyle(color: Color(0xff000000)),
              items: arrayABSList.map((String string) {
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
                setState10(() {
                  absvalue = v!;
                });
              },
            ),
          ),
           SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Music System',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(
            height: 12,
          ),
          MultiSelectDialogField(
            dialogHeight: 350,
            dialogWidth: 450,
            initialValue: arraymusicsystemListresult.isEmpty
                ? null
                : arraymusicsystemListresult,
            items: arraymusicsystemList
                .map((value) => MultiSelectItem<String>(value, value))
                .toList(),
            title: Text(
              "music system",
              style: Sty().mediumText.copyWith(
                    color: Clr().hintColor,
                  ),
            ),
            selectedColor: Clr().black,
            decoration: Sty().outlineBoxStyle,
            buttonText: Text(
              "Select music system",
              style: Sty().mediumText.copyWith(
                    color: Clr().lightGrey,
                  ),
            ),
            buttonIcon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            onConfirm: (results) {
              setState10(() {
                arraymusicsystemListresult = results;
                ////FocusManager.instance.primaryFocus!.unfocus();
              });
            },
          ),

          inetrphoto == '1'
              ? arraymusicsystemListresult.isEmpty
                  ? Text(
                      'This Filed is Required',
                      style: Sty().mediumText.copyWith(color: Clr().red),
                    )
                  : Container()
              : Container(),
           SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Speaker',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(
            height: 12,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              hint: Text(speakervalue ?? 'Select speaker'),
              value: speakervalue,
              isExpanded: true,
              icon:  Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              validator: (value) => value == null ? 'field required' : null,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
                enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                focusedErrorBorder:
                    Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
              ),
              style:  TextStyle(color: Color(0xff000000)),
              items: arrayspeakerList.map((String string) {
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
                setState10(() {
                  speakervalue = v!;
                });
              },
            ),
          ),
           SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Steering Wheel condition',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(
            height: 12,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              hint: Text(
                  steeringwheelcondivalue ?? 'Select steering wheel condition'),
              value: steeringwheelcondivalue,
              isExpanded: true,
              icon:  Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              validator: (value) => value == null ? 'field required' : null,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
                enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                focusedErrorBorder:
                    Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
              ),
              style:  TextStyle(color: Color(0xff000000)),
              items: arraysteeringwheelconditionList.map((String string) {
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
                setState10(() {
                  steeringwheelcondivalue = v!;
                });
              },
            ),
          ),
           SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Steering Wheel Audio Control buttons',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(
            height: 12,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              hint: Text(steerwheeautcontrbuttvalue ??
                  'Select steering wheel auto control'),
              value: steerwheeautcontrbuttvalue,
              isExpanded: true,
              icon:  Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              validator: (value) => value == null ? 'field required' : null,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
                enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                focusedErrorBorder:
                    Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
              ),
              style:  TextStyle(color: Color(0xff000000)),
              items: arraysteeringwheelautocontrolList.map((String string) {
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
                setState10(() {
                  steerwheeautcontrbuttvalue = v!;
                });
              },
            ),
          ),
           SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Auto AC Condition',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(
            height: 12,
          ),
          MultiSelectDialogField(
            dialogHeight: 350,
            dialogWidth: 450,
            initialValue: arrayautoacconditionListresult.isEmpty
                ? null
                : arrayautoacconditionListresult,
            items: arrayautoacconditionList
                .map((value) => MultiSelectItem<String>(value, value))
                .toList(),
            title: Text(
              "auto ac condition",
              style: Sty().mediumText.copyWith(
                    color: Clr().hintColor,
                  ),
            ),
            selectedColor: Clr().black,
            decoration: Sty().outlineBoxStyle,
            buttonText: Text(
              "Select auto ac condition",
              style: Sty().mediumText.copyWith(
                    color: Clr().lightGrey,
                  ),
            ),
            buttonIcon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            onConfirm: (results) {
              setState10(() {
                arrayautoacconditionListresult = results;
                ////FocusManager.instance.primaryFocus!.unfocus();
              });
            },
          ),
          inetrphoto == '1'
              ? arrayautoacconditionListresult.isEmpty
                  ? Text(
                      'This Filed is Required',
                      style: Sty().mediumText.copyWith(color: Clr().red),
                    )
                  : Container()
              : Container(),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.all(Radius.circular(Dim().d8)),
          //       border: Border.all(
          //         color: Clr().lightGrey,
          //       )),
          //   child: DropdownButtonHideUnderline(
          //     child: DropdownButton<String>(
          //       hint: Text(autoacconvalue ?? 'Select auto ac condition'),
          //       value: autoacconvalue,
          //       isExpanded: true,
          //       icon: Icon(
          //         Icons.keyboard_arrow_down,
          //         size: 28,
          //       ),
          //       style: TextStyle(color: Color(0xff000000)),
          //       items: arrayautoacconditionList.map((String string) {
          //         return DropdownMenuItem<String>(
          //           value: string,
          //           child: Text(
          //             string,
          //             style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
          //           ),
          //         );
          //       }).toList(),
          //       onChanged: (v) {
          //         // STM().redirect2page(ctx, Home());
          //         setState(() {
          //           autoacconvalue = v!;
          //         });
          //       },
          //     ),
          //   ),
          // ),
           SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('AC Flow',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(
            height: 12,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              hint: Text(acflowvalue ?? 'Select ac flow'),
              value: acflowvalue,
              isExpanded: true,
              icon:  Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              validator: (value) => value == null ? 'field required' : null,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
                enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                focusedErrorBorder:
                    Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
              ),
              style:  TextStyle(color: Color(0xff000000)),
              items: arrayacflowList.map((String string) {
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
                setState10(() {
                  acflowvalue = v!;
                });
              },
            ),
          ),
           SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('AC Blower motor condition',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(
            height: 12,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              hint: Text(acblowermotocondvalue ?? 'Select ac blower motor'),
              value: acblowermotocondvalue,
              isExpanded: true,
              icon:  Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              validator: (value) => value == null ? 'field required' : null,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
                enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                focusedErrorBorder:
                    Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
              ),
              style:  TextStyle(color: Color(0xff000000)),
              items: arrayacblowerList.map((String string) {
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
                setState10(() {
                  acblowermotocondvalue = v!;
                });
              },
            ),
          ),
           SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('AC Direction Mode',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(
            height: 12,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              hint: Text(acdirectmodevalue ?? 'Select ac direction mode'),
              value: acdirectmodevalue,
              isExpanded: true,
              icon:  Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              validator: (value) => value == null ? 'field required' : null,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
                enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                focusedErrorBorder:
                    Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
              ),
              style:  TextStyle(color: Color(0xff000000)),
              items: arrayacdirectionList.map((String string) {
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
                setState10(() {
                  acdirectmodevalue = v!;
                });
              },
            ),
          ),
           SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('AC Heater',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(
            height: 12,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              hint: Text(acheatervalue ?? 'Select ac heater'),
              value: acheatervalue,
              isExpanded: true,
              icon:  Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              style:  TextStyle(color: Color(0xff000000)),
              validator: (value) => value == null ? 'field required' : null,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
                enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                focusedErrorBorder:
                    Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
              ),
              items: arrayacheaterList.map((String string) {
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
                setState10(() {
                  acheatervalue = v!;
                });
              },
            ),
          ),
           SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Glow Box',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(
            height: 12,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              hint: Text(glowboxvalue ?? 'Select glow box'),
              value: glowboxvalue,
              isExpanded: true,
              icon:  Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              validator: (value) => value == null ? 'field required' : null,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
                enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                focusedErrorBorder:
                    Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
              ),
              style:  TextStyle(color: Color(0xff000000)),
              items: arrayglowboxList.map((String string) {
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
                setState10(() {
                  glowboxvalue = v!;
                });
              },
            ),
          ),
           SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Gear Lever Knob',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(
            height: 12,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              hint: Text(gearleveknobvalue ?? 'Select gear lever knob'),
              value: gearleveknobvalue,
              isExpanded: true,
              icon:  Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              validator: (value) => value == null ? 'field required' : null,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
                enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                focusedErrorBorder:
                    Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
              ),
              style:  TextStyle(color: Color(0xff000000)),
              items: arraygearleverList.map((String string) {
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
                setState10(() {
                  gearleveknobvalue = v!;
                });
              },
            ),
          ),
           SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Power Window',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(
            height: 12,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              hint: Text(powerwindowvalue ?? 'Select power window'),
              value: powerwindowvalue,
              isExpanded: true,
              icon:  Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              validator: (value) => value == null ? 'field required' : null,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
                enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                focusedErrorBorder:
                    Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
              ),
              style:  TextStyle(color: Color(0xff000000)),
              items: arraypowerwindowList.map((String string) {
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
                setState10(() {
                  powerwindowvalue = v!;
                });
              },
            ),
          ),
           SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Front RHS side seat Condition',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(
            height: 12,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              hint: Text(rhssideseatcondivalue ?? 'Select rhs side seat'),
              value: rhssideseatcondivalue,
              isExpanded: true,
              validator: (value) => value == null ? 'field required' : null,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
                enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                focusedErrorBorder:
                    Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
              ),
              icon:  Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              style:  TextStyle(color: Color(0xff000000)),
              items: arrayrhssideseatList.map((String string) {
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
                setState10(() {
                  rhssideseatcondivalue = v!;
                });
              },
            ),
          ),
           SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Front LHS side seat Condition',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(
            height: 12,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              hint: Text(lhssisdeseatcondivalue ?? 'Select lhs side seat'),
              value: lhssisdeseatcondivalue,
              isExpanded: true,
              icon:  Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              validator: (value) => value == null ? 'field required' : null,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
                enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                focusedErrorBorder:
                    Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
              ),
              style:  TextStyle(color: Color(0xff000000)),
              items: arraylhssideseatList.map((String string) {
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
                setState10(() {
                  lhssisdeseatcondivalue = v!;
                });
              },
            ),
          ),
           SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Rear seat Condition',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(
            height: 12,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              hint: Text(rearseatconditivalue ?? 'Select rear seat '),
              value: rearseatconditivalue,
              isExpanded: true,
              icon:  Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              style:  TextStyle(color: Color(0xff000000)),
              validator: (value) => value == null ? 'field required' : null,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
                enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                focusedErrorBorder:
                    Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
              ),
              items: arrayrearseatList.map((String string) {
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
                setState10(() {
                  rearseatconditivalue = v!;
                });
              },
            ),
          ),
           SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('All seat cover available',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(
            height: 12,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              hint: Text(allseatcoveravaivalue ?? 'Select all seat cover'),
              value: allseatcoveravaivalue,
              isExpanded: true,
              icon:  Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              validator: (value) => value == null ? 'field required' : null,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
                enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                focusedErrorBorder:
                    Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
              ),
              style:  TextStyle(color: Color(0xff000000)),
              items: arrayallseatcoverList.map((String string) {
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
                setState10(() {
                  allseatcoveravaivalue = v!;
                });
              },
            ),
          ),
           SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('All mats available',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(
            height: 12,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              hint: Text(allmatsavialbevalue ?? 'Select all mats available'),
              value: allmatsavialbevalue,
              isExpanded: true,
              icon:  Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              validator: (value) => value == null ? 'field required' : null,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
                enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                focusedErrorBorder:
                    Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
              ),
              style:  TextStyle(color: Color(0xff000000)),
              items: arrayallmatsList.map((String string) {
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
                setState10(() {
                  allmatsavialbevalue = v!;
                });
              },
            ),
          ),
           SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      pageNumber--;
                      isFromSummary = false;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Dim().d16, horizontal: Dim().d44),
                    decoration: BoxDecoration(
                      gradient:  Sty().linearGradient,
                      borderRadius: BorderRadius.circular(
                        Dim().d4,
                      ),
                    ),
                    margin:  EdgeInsets.only(right: 10),
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
                    setState(() {
                      inetrphoto = '1';
                    });
                    if (arraymusicsystemListresult.isEmpty) {
                      return;
                    }
                    if (arrayautoacconditionListresult.isEmpty) {
                      return;
                    }
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        pageNumber++;
                        isFromSummary = false;
                        scrollCtrl.jumpTo(scrollCtrl.position.minScrollExtent);
                      });
                    } //End
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Dim().d16, horizontal: Dim().d64),
                    decoration: BoxDecoration(
                      gradient:  Sty().linearGradient,
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
      );
    });
  }

  //testdrive
  Widget testdrivelayout() {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Front Suspension Noise',
                style: Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
         SizedBox(
          height: 12,
        ),
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            hint: Text(frosuspensnoisevalue ?? 'Select front suspension noise'),
            value: frosuspensnoisevalue,
            isExpanded: true,
            validator: (value) => value == null ? 'field required' : null,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
              enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
              focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
              focusedErrorBorder:
                  Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
              errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
              disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
            ),
            icon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            style:  TextStyle(color: Color(0xff000000)),
            items: arraytestfrontsuspesionList.map((String string) {
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
                frosuspensnoisevalue = v!;
              });
            },
          ),
        ),
         SizedBox(
          height: 20,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Axle Noise',
                style: Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
         SizedBox(
          height: 12,
        ),
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            hint: Text(axlenoisevalue ?? 'Select axle noise'),
            value: axlenoisevalue,
            isExpanded: true,
            icon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            validator: (value) => value == null ? 'field required' : null,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
              enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
              focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
              focusedErrorBorder:
                  Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
              errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
              disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
            ),
            style:  TextStyle(color: Color(0xff000000)),
            items: arraytestaxlenoiseList.map((String string) {
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
                axlenoisevalue = v!;
              });
            },
          ),
        ),
         SizedBox(
          height: 20,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Rear suspension Noise',
                style: Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
         SizedBox(
          height: 12,
        ),
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            hint: Text(rearsuspennoisevalue ?? 'Select rear suspension noise'),
            value: rearsuspennoisevalue,
            isExpanded: true,
            icon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            validator: (value) => value == null ? 'field required' : null,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
              enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
              focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
              focusedErrorBorder:
                  Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
              errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
              disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
            ),
            style:  TextStyle(color: Color(0xff000000)),
            items: arraytestrearsuspesionList.map((String string) {
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
              setState(() {
                rearsuspennoisevalue = v!;
              });
            },
          ),
        ),
         SizedBox(
          height: 20,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Clutch Condition',
                style: Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
         SizedBox(
          height: 12,
        ),
        MultiSelectDialogField(
          dialogHeight: 350,
          dialogWidth: 450,
          initialValue: arraytestclutchconditionListresult.isEmpty
              ? null
              : arraytestclutchconditionListresult,
          items: arraytestclutchconditionList
              .map((value) => MultiSelectItem<String>(value, value))
              .toList(),
          title: Text(
            "clutch condition",
            style: Sty().mediumText.copyWith(
                  color: Clr().hintColor,
                ),
          ),
          selectedColor: Clr().black,
          decoration: Sty().outlineBoxStyle,
          buttonText: Text(
            "Select clutch condition",
            style: Sty().mediumText.copyWith(
                  color: Clr().lightGrey,
                ),
          ),
          buttonIcon:  Icon(
            Icons.keyboard_arrow_down,
            size: 28,
          ),
          onConfirm: (results) {
            setState(() {
              arraytestclutchconditionListresult = results;
              ////FocusManager.instance.primaryFocus!.unfocus();
            });
          },
        ),
        testdriphoto == '1'
            ? arraytestclutchconditionListresult.isEmpty
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'This Filed is Required',
                      style: Sty().mediumText.copyWith(color: Clr().red),
                    ),
                  )
                : Container()
            : Container(),
         SizedBox(
          height: 20,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Automatic Gear Box',
                style: Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
         SizedBox(
          height: 12,
        ),
        MultiSelectDialogField(
          dialogHeight: 350,
          dialogWidth: 450,
          initialValue: arraytestautomaticgearListresult.isEmpty
              ? null
              : arraytestautomaticgearListresult,
          items: arraytestautomaticgearList
              .map((value) => MultiSelectItem<String>(value, value))
              .toList(),
          title: Text(
            "automatic gear box",
            style: Sty().mediumText.copyWith(
                  color: Clr().hintColor,
                ),
          ),
          selectedColor: Clr().black,
          decoration: Sty().outlineBoxStyle,
          buttonText: Text(
            "Select automatic gear box",
            style: Sty().mediumText.copyWith(
                  color: Clr().lightGrey,
                ),
          ),
          buttonIcon:  Icon(
            Icons.keyboard_arrow_down,
            size: 28,
          ),
          onConfirm: (results) {
            setState(() {
              arraytestautomaticgearListresult = results;
              ////FocusManager.instance.primaryFocus!.unfocus();
            });
          },
        ),
        testdriphoto == '1'
            ? arraytestautomaticgearListresult.isEmpty
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'This Filed is Required',
                      style: Sty().mediumText.copyWith(color: Clr().red),
                    ),
                  )
                : Container()
            : Container(),
         SizedBox(
          height: 20,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Gear Box',
                style: Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
         SizedBox(
          height: 12,
        ),
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            hint: Text(gearboxvlaue ?? 'Select gear box'),
            value: gearboxvlaue,
            isExpanded: true,
            icon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            validator: (value) => value == null ? 'field required' : null,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
              enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
              focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
              focusedErrorBorder:
                  Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
              errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
              disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
            ),
            style:  TextStyle(color: Color(0xff000000)),
            items: arraytestgearboxList.map((String string) {
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
                gearboxvlaue = v!;
              });
            },
          ),
        ),
         SizedBox(
          height: 20,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Gear Box noise',
                style: Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
         SizedBox(
          height: 12,
        ),
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            hint: Text(gearboxnoisevalue ?? 'Select gear box noise'),
            value: gearboxnoisevalue,
            isExpanded: true,
            icon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            validator: (value) => value == null ? 'field required' : null,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
              enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
              focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
              focusedErrorBorder:
                  Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
              errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
              disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
            ),
            style:  TextStyle(color: Color(0xff000000)),
            items: arraytestgearboxnoiseList.map((String string) {
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
                gearboxnoisevalue = v!;
              });
            },
          ),
        ),
         SizedBox(
          height: 20,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Gear Shifting',
                style: Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
         SizedBox(
          height: 12,
        ),
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            hint: Text(gearshiftingvalue ?? 'Select gear shifting'),
            value: gearshiftingvalue,
            isExpanded: true,
            icon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            validator: (value) => value == null ? 'field required' : null,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
              enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
              focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
              focusedErrorBorder:
                  Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
              errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
              disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
            ),
            style:  TextStyle(color: Color(0xff000000)),
            items: arraytestgearboxshiftingList.map((String string) {
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
                gearshiftingvalue = v!;
              });
            },
          ),
        ),
         SizedBox(
          height: 20,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Wheel Alignment',
                style: Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
         SizedBox(
          height: 12,
        ),
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            hint: Text(wavalue ?? 'Select Wheel Alignment'),
            value: wavalue,
            isExpanded: true,
            icon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            validator: (value) => value == null ? 'field required' : null,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
              enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
              focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
              focusedErrorBorder:
                  Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
              errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
              disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
            ),
            style:  TextStyle(color: Color(0xff000000)),
            items: arrayWaList.map((String string) {
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
                wavalue = v!;
              });
            },
          ),
        ),
         SizedBox(
          height: 20,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Steering Noise',
                style: Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
         SizedBox(
          height: 12,
        ),
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            hint: Text(steerinnoisevalue ?? 'Select steering noise'),
            value: steerinnoisevalue,
            isExpanded: true,
            icon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            validator: (value) => value == null ? 'field required' : null,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
              enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
              focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
              focusedErrorBorder:
                  Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
              errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
              disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
            ),
            style:  TextStyle(color: Color(0xff000000)),
            items: arrayteststeeringnoiseList.map((String string) {
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
                steerinnoisevalue = v!;
              });
            },
          ),
        ),
         SizedBox(
          height: 20,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Steering Colum Noise',
                style: Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
         SizedBox(
          height: 12,
        ),
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            hint: Text(steericolumnoisevalue ?? 'Select steering column noise'),
            value: steericolumnoisevalue,
            isExpanded: true,
            icon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            validator: (value) => value == null ? 'field required' : null,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
              enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
              focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
              focusedErrorBorder:
                  Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
              errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
              disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
            ),
            style:  TextStyle(color: Color(0xff000000)),
            items: arrayteststeeringcolumnnoiseList.map((String string) {
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
                steericolumnoisevalue = v!;
              });
            },
          ),
        ),
         SizedBox(
          height: 20,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Speedometer Knob',
                style: Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
         SizedBox(
          height: 12,
        ),
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            hint: Text(speedometknobvalue ?? 'Select spedometer knob'),
            value: speedometknobvalue,
            isExpanded: true,
            icon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            validator: (value) => value == null ? 'field required' : null,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
              enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
              focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
              focusedErrorBorder:
                  Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
              errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
              disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
            ),
            style:  TextStyle(color: Color(0xff000000)),
            items: arraytestspeedometerknobList.map((String string) {
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
                speedometknobvalue = v!;
              });
            },
          ),
        ),
         SizedBox(
          height: 20,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Odometer Reading',
                style: Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
         SizedBox(
          height: 12,
        ),
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            hint: Text(odometerreadinvalue ?? 'Select odometer reading'),
            value: odometerreadinvalue,
            isExpanded: true,
            icon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            validator: (value) => value == null ? 'field required' : null,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
              enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
              focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
              focusedErrorBorder:
                  Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
              errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
              disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
            ),
            style:  TextStyle(color: Color(0xff000000)),
            items: arraytestodometerreadingList.map((String string) {
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
                odometerreadinvalue = v!;
              });
            },
          ),
        ),
         SizedBox(
          height: 40,
        ),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    pageNumber--;
                    isFromSummary = false;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: Dim().d16, horizontal: Dim().d44),
                  decoration: BoxDecoration(
                    gradient:  Sty().linearGradient,
                    borderRadius: BorderRadius.circular(
                      Dim().d4,
                    ),
                  ),
                  margin:  EdgeInsets.only(right: 10),
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
                  setState(() {
                    testdriphoto = '1';
                  });
                  if (arraytestclutchconditionListresult.isEmpty) {
                    return;
                  }
                  if (arraytestautomaticgearListresult.isEmpty) {
                    return;
                  }
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      pageNumber++;
                      isFromSummary = false;
                      scrollCtrl.jumpTo(scrollCtrl.position.minScrollExtent);
                    });
                  } //End
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: Dim().d16, horizontal: Dim().d64),
                  decoration: BoxDecoration(
                    gradient:  Sty().linearGradient,
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
    );
  }

  // //engine compartment
  Widget enginecompartmentlayout() {
    return StatefulBuilder(builder: (context, setState12) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Tappet Noise',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(
            height: 12,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              hint: Text(tappetnoisevalue ?? 'Select tappet noise'),
              value: tappetnoisevalue,
              isExpanded: true,
              icon:  Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              validator: (value) => value == null ? 'field required' : null,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
                enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                focusedErrorBorder:
                    Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
              ),
              style:  TextStyle(color: Color(0xff000000)),
              items: arrayenginetappetnoiseList.map((String string) {
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
                setState12(() {
                  tappetnoisevalue = v!;
                });
              },
            ),
          ),
           SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Engine overheating',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(
            height: 12,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              hint: Text(engineoverheatvalue ?? 'Select engine overheating'),
              value: engineoverheatvalue,
              isExpanded: true,
              icon:  Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              validator: (value) => value == null ? 'field required' : null,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
                enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                focusedErrorBorder:
                    Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
              ),
              style:  TextStyle(color: Color(0xff000000)),
              items: arrayengineoverheatingList.map((String string) {
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
                setState12(() {
                  engineoverheatvalue = v!;
                });
              },
            ),
          ),
           SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Engine oil sludge',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(
            height: 12,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              hint: Text(engineoilsludgevalue ?? 'Select engine oil sludge'),
              value: engineoilsludgevalue,
              isExpanded: true,
              icon:  Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              validator: (value) => value == null ? 'field required' : null,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
                enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                focusedErrorBorder:
                    Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
              ),
              style:  TextStyle(color: Color(0xff000000)),
              items: arrayengineoilsludgeList.map((String string) {
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
                setState12(() {
                  engineoilsludgevalue = v!;
                });
              },
            ),
          ),
           SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Engine oil Condition',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(
            height: 12,
          ),
          StatefulBuilder(builder: (context, setState) {
              return MultiSelectDialogField(
                dialogHeight: 350,
                dialogWidth: 450,
                initialValue: oilConditionArray ?? null,
                items: conditionList
                    .map((value) => MultiSelectItem<String>(value, value))
                    .toList(),
                title: Text(
                  "engine oil condition",
                  style: Sty().mediumText.copyWith(
                        color: Clr().hintColor,
                      ),
                ),
                selectedColor: Clr().black,
                decoration: Sty().outlineBoxStyle,
                buttonText: Text(
                  "Select engine oil condition",
                  style: Sty().mediumText.copyWith(
                        color: Clr().lightGrey,
                      ),
                ),
                buttonIcon:  Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                onConfirm: (results) {
                  setState(() {
                    oilConditionArray = results;
                    ////FocusManager.instance.primaryFocus!.unfocus();
                  });
                },
              );
            }
          ),
          engiphoto == '1'
              ? oilConditionArray.isEmpty
                  ? Text(
                      'This Filed is Required',
                      style: Sty().mediumText.copyWith(color: Clr().red),
                    )
                  : Container()
              : Container(),
           SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Coolant',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(
            height: 12,
          ),
          StatefulBuilder(builder: (context, setState) {
              return MultiSelectDialogField(
                dialogHeight: 350,
                dialogWidth: 450,
                initialValue: coolentArray ?? null,
                items: conditionList
                    .map((value) => MultiSelectItem<String>(value, value))
                    .toList(),
                title: Text(
                  "coolant",
                  style: Sty().mediumText.copyWith(
                        color: Clr().hintColor,
                      ),
                ),
                selectedColor: Clr().black,
                decoration: Sty().outlineBoxStyle,
                buttonText: Text(
                  "Select coolant",
                  style: Sty().mediumText.copyWith(
                        color: Clr().lightGrey,
                      ),
                ),
                buttonIcon:  Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                onConfirm: (results) {
                  setState(() {
                    coolentArray = results;
                    ////FocusManager.instance.primaryFocus!.unfocus();
                  });
                },
              );
            }
          ),
          engiphoto == '1'
              ? coolentArray.isEmpty
                  ? Text(
                      'This Filed is Required',
                      style: Sty().mediumText.copyWith(color: Clr().red),
                    )
                  : Container()
              : Container(),
           SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Timeing side Noise',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(
            height: 12,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              hint: Text(timigsidenoisvalue ?? 'Select timing side noise'),
              value: timigsidenoisvalue,
              isExpanded: true,
              icon:  Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              validator: (value) => value == null ? 'field required' : null,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
                enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                focusedErrorBorder:
                    Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
              ),
              style:  TextStyle(color: Color(0xff000000)),
              items: arrayenginetimeingsideList.map((String string) {
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
                setState12(() {
                  timigsidenoisvalue = v!;
                });
              },
            ),
          ),
           SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Alternater Condition',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(
            height: 12,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              hint: Text(alternatecondivalue ?? 'Select alternater condition'),
              value: alternatecondivalue,
              isExpanded: true,
              icon:  Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              validator: (value) => value == null ? 'field required' : null,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
                enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                focusedErrorBorder:
                    Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
              ),
              style:  TextStyle(color: Color(0xff000000)),
              items: arrayenginealternatornoiseList.map((String string) {
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
                setState12(() {
                  alternatecondivalue = v!;
                });
              },
            ),
          ),
           SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Battery Condition',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(
            height: 12,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              hint: Text(batterycondivalue ?? 'Select battery conditon'),
              value: batterycondivalue,
              isExpanded: true,
              icon:  Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              validator: (value) => value == null ? 'field required' : null,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
                enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                focusedErrorBorder:
                    Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
              ),
              style:  TextStyle(color: Color(0xff000000)),
              items: arrayenginebatteryList.map((String string) {
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
                setState12(() {
                  batterycondivalue = v!;
                });
              },
            ),
          ),
           SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Ac compressor',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(
            height: 12,
          ),
          MultiSelectDialogField(
            dialogHeight: 350,
            dialogWidth: 450,
            initialValue: arrayengineaccompressorListresult.isEmpty
                ? null
                : arrayengineaccompressorListresult,
            items: arrayengineaccompressorList
                .map((value) => MultiSelectItem<String>(value, value))
                .toList(),
            title: Text(
              "ac compressor",
              style: Sty().mediumText.copyWith(
                    color: Clr().hintColor,
                  ),
            ),
            selectedColor: Clr().black,
            decoration: Sty().outlineBoxStyle,
            buttonText: Text(
              "Select ac compressor",
              style: Sty().mediumText.copyWith(
                    color: Clr().lightGrey,
                  ),
            ),
            buttonIcon:  Icon(
              Icons.keyboard_arrow_down,
              size: 28,
            ),
            onConfirm: (results) {
              setState12(() {
                arrayengineaccompressorListresult = results;
                ////FocusManager.instance.primaryFocus!.unfocus();
              });
            },
          ),
          engiphoto == '1'
              ? arrayengineaccompressorListresult.isEmpty
                  ? Text(
                      'This Filed is Required',
                      style: Sty().mediumText.copyWith(color: Clr().red),
                    )
                  : Container()
              : Container(),
           SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Starter motor Noise',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(
            height: 12,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              hint: Text(motornoisevalue ?? 'Select motor noise'),
              value: motornoisevalue,
              isExpanded: true,
              validator: (value) => value == null ? 'field required' : null,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
                enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                focusedErrorBorder:
                    Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
              ),
              icon:  Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              style:  TextStyle(color: Color(0xff000000)),
              items: arrayenginestartermotorList.map((String string) {
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
                setState12(() {
                  motornoisevalue = v!;
                });
              },
            ),
          ),
           SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Air Filter Assy',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(
            height: 12,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              hint: Text(airfilterassyvalue ?? 'Select air filter assy'),
              value: airfilterassyvalue,
              isExpanded: true,
              icon:  Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              validator: (value) => value == null ? 'field required' : null,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
                enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                focusedErrorBorder:
                    Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
              ),
              style:  TextStyle(color: Color(0xff000000)),
              items: arrayengineairfilterList.map((String string) {
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
                setState12(() {
                  airfilterassyvalue = v!;
                });
              },
            ),
          ),
           SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Video Url',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
           SizedBox(
            height: 12,
          ),
          TextFormField(
            controller: enginevideoctrl,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value!.isEmpty) {
                return 'This Field is Required';
              }
              return null;
            },
            decoration: InputDecoration(
                contentPadding: Sty().TextFormFieldOutlineStyle.contentPadding,
                enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                focusedErrorBorder:
                    Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                disabledBorder: Sty().TextFormFieldOutlineStyle.disabledBorder,
                border: InputBorder.none,
                hintText: 'Enter Video Url',
                hintStyle: Sty().mediumText.copyWith(
                      color: Clr().drkcolor,
                      fontSize: 14,
                    )),
          ),
           SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      pageNumber--;
                      isFromSummary = false;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Dim().d16, horizontal: Dim().d44),
                    decoration: BoxDecoration(
                      gradient:  Sty().linearGradient,
                      borderRadius: BorderRadius.circular(
                        Dim().d4,
                      ),
                    ),
                    margin:  EdgeInsets.only(right: 10),
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
                    setState(() {
                      engiphoto = '1';
                    });
                    if (oilConditionArray.isEmpty) {
                      return;
                    }
                    if (coolentArray.isEmpty) {
                      return;
                    }
                    if (arrayengineaccompressorListresult.isEmpty) {
                      return;
                    }
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        pageNumber++;
                        isFromSummary = false;
                        scrollCtrl.jumpTo(scrollCtrl.position.minScrollExtent);
                      });
                    } //End
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Dim().d16, horizontal: Dim().d64),
                    decoration: BoxDecoration(
                      gradient:  Sty().linearGradient,
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
      );
    });
  }

  //specialfeaturesphotoandname
  Widget specialfeaturephotonamelayout() {
    return StatefulBuilder(builder: (context, setState13) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: comment1ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState13(() {
                        filePicker("sp1", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState13(() {
                          filePicker("sp1", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sspecomm1 != null
                        ? 'Image Selected'
                        : 'Speacial Features Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: comment2ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState13(() {
                        filePicker("sp2", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState13(() {
                          filePicker("sp2", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sspecomm2 != null
                        ? 'Image Selected'
                        : 'Speacial Features Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: comment3ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState13(() {
                        filePicker("sp3", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState13(() {
                          filePicker("sp3", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sspecomm3 != null
                        ? 'Image Selected'
                        : 'Speacial Features Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: comment4ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState13(() {
                        filePicker("sp4", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState13(() {
                          filePicker("sp4", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sspecomm4 != null
                        ? 'Image Selected'
                        : 'Speacial Features Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: comment5ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState13(() {
                        filePicker("sp5", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState13(() {
                          filePicker("sp5", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sspecomm5 != null
                        ? 'Image Selected'
                        : 'Speacial Features Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: comment6ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState13(() {
                        filePicker("sp6", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState13(() {
                          filePicker("sp6", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sspecomm6 != null
                        ? 'Image Selected'
                        : 'Speacial Features Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: comment7ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState13(() {
                        filePicker("sp7", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState13(() {
                          filePicker("sp7", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sspecomm7 != null
                        ? 'Image Selected'
                        : 'Speacial Features Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: comment8ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState13(() {
                        filePicker("sp8", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState13(() {
                          filePicker("sp8", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sspecomm8 != null
                        ? 'Image Selected'
                        : 'Speacial Features Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: comment9ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState13(() {
                        filePicker("sp9", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState13(() {
                          filePicker("sp9", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sspecomm9 != null
                        ? 'Image Selected'
                        : 'Speacial Features Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: comment10ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState13(() {
                        filePicker("sp10", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState13(() {
                          filePicker("sp10", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sspecomm10 != null
                        ? 'Image Selected'
                        : 'Speacial Features Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: comment11ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState13(() {
                        filePicker("sp11", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState13(() {
                          filePicker("sp11", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sspecomm11 != null
                        ? 'Image Selected'
                        : 'Speacial Features Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: comment12ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState13(() {
                        filePicker("sp12", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState13(() {
                          filePicker("sp12", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sspecomm12 != null
                        ? 'Image Selected'
                        : 'Speacial Features Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: comment13ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState13(() {
                        filePicker("sp13", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState13(() {
                          filePicker("sp13", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sspecomm13 != null
                        ? 'Image Selected'
                        : 'Speacial Features Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: comment14ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState13(() {
                        filePicker("sp14", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState13(() {
                          filePicker("sp14", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sspecomm14 != null
                        ? 'Image Selected'
                        : 'Speacial Features Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: comment15ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState13(() {
                        filePicker("sp15", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState13(() {
                          filePicker("sp15", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sspecomm15 != null
                        ? 'Image Selected'
                        : 'Speacial Features Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
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
                    setState(() {
                      pageNumber--;
                      isFromSummary = false;
                    });
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
                    margin:  EdgeInsets.only(right: 10),
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
                    setState(() {
                      pageNumber++;
                      isFromSummary = false;
                      scrollCtrl.jumpTo(scrollCtrl.position.minScrollExtent);
                    });
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
          ),
        ],
      );
    });
  }

  //anydamagephotoandname
  Widget anydamagephotolayout() {
    return StatefulBuilder(builder: (context, setState14) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: anydamage1ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState14(() {
                        filePicker("an1", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState14(() {
                          filePicker("an1", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sanycomm1 != null ? 'Image Selected' : 'Any Damage Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: anydamage2ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState14(() {
                        filePicker("an2", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState14(() {
                          filePicker("an2", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sanycomm2 != null ? 'Image Selected' : 'Any Damage Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: anydamage3ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState14(() {
                        filePicker("an3", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState14(() {
                          filePicker("an3", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sanycomm3 != null ? 'Image Selected' : 'Any Damage Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: anydamage4ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState14(() {
                        filePicker("an4", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState14(() {
                          filePicker("an4", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sanycomm4 != null ? 'Image Selected' : 'Any Damage Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: anydamage5ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState14(() {
                        filePicker("an5", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState14(() {
                          filePicker("an5", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sanycomm5 != null ? 'Image Selected' : 'Any Damage Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: anydamage6ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState14(() {
                        filePicker("an6", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState14(() {
                          filePicker("an6", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sanycomm6 != null ? 'Image Selected' : 'Any Damage Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: anydamage7ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState14(() {
                        filePicker("an7", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState14(() {
                          filePicker("an7", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sanycomm7 != null ? 'Image Selected' : 'Any Damage Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: anydamage8ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState14(() {
                        filePicker("an8", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState14(() {
                          filePicker("an8", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sanycomm8 != null ? 'Image Selected' : 'Any Damage Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: anydamage9ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState14(() {
                        filePicker("an9", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState14(() {
                          filePicker("an9", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sanycomm9 != null ? 'Image Selected' : 'Any Damage Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: anydamage10ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState14(() {
                        filePicker("an10", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState14(() {
                          filePicker("an10", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sanycomm10 != null ? 'Image Selected' : 'Any Damage Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: anydamage11ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState14(() {
                        filePicker("an11", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState14(() {
                          filePicker("an11", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sanycomm11 != null ? 'Image Selected' : 'Any Damage Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: anydamage12ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState14(() {
                        filePicker("an12", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState14(() {
                          filePicker("an12", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sanycomm12 != null ? 'Image Selected' : 'Any Damage Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: anydamage13ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState14(() {
                        filePicker("an13", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState14(() {
                          filePicker("an13", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sanycomm13 != null ? 'Image Selected' : 'Any Damage Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: anydamage14ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState14(() {
                        filePicker("an14", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState14(() {
                          filePicker("an14", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sanycomm14 != null ? 'Image Selected' : 'Any Damage Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: anydamage15ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState14(() {
                        filePicker("an15", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState14(() {
                          filePicker("an15", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sanycomm15 != null ? 'Image Selected' : 'Any Damage Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: anydamage16ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState14(() {
                        filePicker("an16", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState14(() {
                          filePicker("an16", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sanycomm16 != null ? 'Image Selected' : 'Any Damage Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: anydamage17ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState14(() {
                        filePicker("an17", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState14(() {
                          filePicker("an17", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sanycomm17 != null ? 'Image Selected' : 'Any Damage Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: anydamage18ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState14(() {
                        filePicker("an18", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState14(() {
                          filePicker("an18", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sanycomm18 != null ? 'Image Selected' : 'Any Damage Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: anydamage19ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState14(() {
                        filePicker("an19", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState14(() {
                          filePicker("an19", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sanycomm19 != null ? 'Image Selected' : 'Any Damage Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: anydamage20ctrl,
                  decoration:  InputDecoration(
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
            ],
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dim().d16, horizontal: Dim().d20),
            decoration: BoxDecoration(
              color: Color(0xffFBF7F6),
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
                      setState14(() {
                        filePicker("an20", true);
                      });
                    },
                    child:  Icon(Icons.camera_alt_outlined,
                        color: Color(0xffE88B6B)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState14(() {
                          filePicker("an20", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sanycomm20 != null ? 'Image Selected' : 'Any Damage Photo',
                    style: Sty().mediumText.copyWith(
                      color: Color(0xffE88B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: anydamage21ctrl,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration:  InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    hintText: "Comment",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffE4DFDF),
                        )),
                  ),
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
                    setState(() {
                      pageNumber--;
                      isFromSummary = false;
                    });
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
                    margin:  EdgeInsets.only(right: 10),
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
                    addData();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Dim().d16, horizontal: Dim().d52),
                    decoration: BoxDecoration(
                      gradient: Sty().linearGradient,
                      borderRadius: BorderRadius.circular(
                        Dim().d4,
                      ),
                    ),
                    // margin: EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        'Submit',
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
      );
    });
  }

  void filePicker(type, isCamera) async {
    XFile? photo = await ImagePicker().pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 40);
    if (photo != null) {
      final image = await photo.readAsBytes();
      setState(() {
        switch (type) {
          case "fvp":
            sFrontViewImg = base64Encode(image);
            break;
          case "exp":
            sExpiryPhoto = base64Encode(image);
            break;
          case "rc1":
            sRc1Photo = base64Encode(image);
            break;
          case "rc2":
            sRc2Photo = base64Encode(image);
            break;
          case "rcinsurance":
            sInsurancePhoto = base64Encode(image);
            break;
          case "chassisphoto":
            sChassisPhoto = base64Encode(image);
            break;
          case "enginephoto":
            sEnginePhoto = base64Encode(image);
            break;
          case "fgi":
            sFrontGlassImg = base64Encode(image);
            break;
          case "eci":
            sEnginecompartImg = base64Encode(image);
            break;
          case "ri":
            sRoofImg = base64Encode(image);
            break;
          case "frsti":
            sFrontrhssidetriImg = base64Encode(image);
            break;
          case "frtyi":
            sFrontrhstyreImg = base64Encode(image);
            break;
          case "rsvi":
            sRhssideviewImg = base64Encode(image);
            break;
          case "rsii":
            sRhssideinteriImg = base64Encode(image);
            break;
          case "rrtyi":
            sRearrhstyreImg = base64Encode(image);
            break;
          case "bsi":
            sBacksideImg = base64Encode(image);
            break;
          case "ddoi":
            sDickydooropenImg = base64Encode(image);
            break;
          case "dfi":
            sDickyfloorImg = base64Encode(image);
            break;
          case "rgi":
            sRearglassImg = base64Encode(image);
            break;
          case "sweei":
            sSparewheelImg = base64Encode(image);
            break;
          case "lsti":
            sLhssidetriImg = base64Encode(image);
            break;
          case "rltyi":
            sRearlhstyreImg = base64Encode(image);
            break;
          case "lsvi":
            sLhssideviewImg = base64Encode(image);
            break;
          case "rii":
            sRearinteriorImg = base64Encode(image);
            break;
          case "fltyi":
            sFrontlhstyreImg = base64Encode(image);
            break;
          case "dbvi":
            sDashboardviewImg = base64Encode(image);
            break;
          case "omevi":
            sOdometerviewImg = base64Encode(image);
            break;
          case "fbi":
            sFrontBumerImg = base64Encode(image);
            break;
          case "bi":
            sbonnetImg = base64Encode(image);
            break;
          case "frgi":
            sFrontglassImg = base64Encode(image);
            break;
          case "eri":
            sExtRoofImg = base64Encode(image);
            break;
          case "Rsai":
            sRsideAppImg = base64Encode(image);
            break;
          case "Rfi":
            sRfenderImg = base64Encode(image);
            break;
          case "Rai":
            sRApillerImg = base64Encode(image);
            break;
          case "Rbpi":
            sRBPillerImg = base64Encode(image);
            break;
          case "Rdoi":
            sRDoorImg = base64Encode(image);
            break;
          case "Rdi":
            sRrearDoorImg = base64Encode(image);
            break;
          case "Rrbi":
            sRrunniboardImg = base64Encode(image);
            break;
          case "Rcpi":
            sRCPillerImg = base64Encode(image);
            break;
          case "Rqpi":
            sRquaterpannelImg = base64Encode(image);
            break;
          case "Ddi":
            sDickydoorImg = base64Encode(image);
            break;
          case "Rgi":
            sRgImg = base64Encode(image);
            break;
          case "bdfi":
            sbackDickyfloorImg = base64Encode(image);
            break;
          case "rbi":
            sRearBumImg = base64Encode(image);
            break;
          case "lsa":
            sLsaImg = base64Encode(image);
            break;
          case "lfi":
            sLfImg = base64Encode(image);
            break;
          case "lapi":
            sLapImg = base64Encode(image);
            break;
          case "lbpi":
            sLbpImg = base64Encode(image);
            break;
          case "lfdi":
            sLfdImg = base64Encode(image);
            break;
          case "lrdi":
            sLrdImg = base64Encode(image);
            break;
          case "lrbi":
            sLrbImg = base64Encode(image);
            break;
          case "lcpi":
            sLcpImg = base64Encode(image);
            break;
          case "lqpi":
            sLqpImg = base64Encode(image);
            break;
          case "sp1":
            sspecomm1 = base64Encode(image);
            break;
          case "sp2":
            sspecomm2 = base64Encode(image);
            break;
          case "sp3":
            sspecomm3 = base64Encode(image);
            break;
          case "sp4":
            sspecomm4 = base64Encode(image);
            break;
          case "sp5":
            sspecomm5 = base64Encode(image);
            break;
          case "sp6":
            sspecomm6 = base64Encode(image);
            break;
          case "sp7":
            sspecomm7 = base64Encode(image);
            break;
          case "sp8":
            sspecomm8 = base64Encode(image);
            break;
          case "sp9":
            sspecomm9 = base64Encode(image);
            break;
          case "sp10":
            sspecomm10 = base64Encode(image);
            break;
          case "sp11":
            sspecomm11 = base64Encode(image);
            break;
          case "sp12":
            sspecomm12 = base64Encode(image);
            break;
          case "sp13":
            sspecomm13 = base64Encode(image);
            break;
          case "sp14":
            sspecomm14 = base64Encode(image);
            break;
          case "sp15":
            sspecomm15 = base64Encode(image);
            break;
          case "an1":
            sanycomm1 = base64Encode(image);
            break;
          case "an2":
            sanycomm2 = base64Encode(image);
            break;
          case "an3":
            sanycomm3 = base64Encode(image);
            break;
          case "an4":
            sanycomm4 = base64Encode(image);
            break;
          case "an5":
            sanycomm5 = base64Encode(image);
            break;
          case "an6":
            sanycomm6 = base64Encode(image);
            break;
          case "an7":
            sanycomm7 = base64Encode(image);
            break;
          case "an8":
            sanycomm8 = base64Encode(image);
            break;
          case "an9":
            sanycomm9 = base64Encode(image);
            break;
          case "an10":
            sanycomm10 = base64Encode(image);
            break;
          case "an11":
            sanycomm11 = base64Encode(image);
            break;
          case "an12":
            sanycomm12 = base64Encode(image);
            break;
          case "an13":
            sanycomm13 = base64Encode(image);
            break;
          case "an14":
            sanycomm14 = base64Encode(image);
            break;
          case "an15":
            sanycomm15 = base64Encode(image);
            break;
          case "an16":
            sanycomm16 = base64Encode(image);
            break;
          case "an17":
            sanycomm17 = base64Encode(image);
            break;
          case "an18":
            sanycomm18 = base64Encode(image);
            break;
          case "an19":
            sanycomm19 = base64Encode(image);
            break;
          case "an20":
            sanycomm20 = base64Encode(image);
            break;
        }
      });
    }
  }

//Date picker
  Future datePicker(type) async {
    DateTime? picked = await showDatePicker(
      context: ctx,
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(primary: Clr().primaryColor),
          ),
          child: child!,
        );
      },
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        String date = STM().dateFormat('yyyy-MM-dd', picked);
        switch (type) {
          case "mfg":
            mfgctrl = TextEditingController(text: date);
            break;
          case "re":
            rcExpiryCtrl = TextEditingController(text: date);
            break;
          case "reg":
            regctrl = TextEditingController(text: date);
            break;
          case "tax":
            taxvalidctrl = TextEditingController(text: date);
            break;
        }
        // isDob = false;
      });
    }
  }

  // get Api
  getData() async {
    //Input
    FormData body = FormData.fromMap({
      "id": widget.sOrderID,
    });
    if (!mounted) return;
    var result = await STM()
        .post(context, Str().processing, "edit_vehicle_details", body);
    setState(() {
      var form1 = result['customer_details'];
      purchaseNameCtrl =
          TextEditingController(text: form1['purchase_cust_name']);
      purchaseNumberCtrl =
          TextEditingController(text: form1['purchase_cust_no']);
      purchaseLocationCtrl =
          TextEditingController(text: form1['purchase_location']);
      sellNameCtrl = TextEditingController(text: form1['sell_cust_name']);
      sellNumberCtrl = TextEditingController(text: form1['sell_cust_no']);
      sellLocationCtrl = TextEditingController(text: form1['sell_location']);
      var form2 = result['rc_details'];
      sRc = form2['rc'];
      sRcType = form2['rc_type'];
      sInsuranceType = form2['zero_dep_insuarance'];
      rcExpiryCtrl = TextEditingController(text: form2['expiry_date']);
      var form3 = result['chassis_details'];
      chassisNumberCtrl = TextEditingController(text: form3['chasis_no']);
      chassisEngineNoCtrl = TextEditingController(text: form3['engine_no']);
      var form4 = result['vehicle_details'];
      sVehicleState = form4['vehicle_state'];
      vehicleNumberCtrl = TextEditingController(text: form4['vehicle_no']);
      vehicleVariantCtrl = TextEditingController(text: form4['veriant']);
      mfgctrl = TextEditingController(text: form4['mfg_year']);
      sVehicleMake = form4['vehicle_make'];
      sVehicleModel = form4['vehicle_model'];
      arrayvehiclecolorvalue = form4['vehicle_color'];
      regctrl = TextEditingController(text: form4['reg_year']);
      taxvalidctrl = TextEditingController(text: form4['tax_validity']);
      vehicleenginecubicctrl =
          TextEditingController(text: form4['engine_cube_capacity']);
      vehicleownerserialctrl =
          TextEditingController(text: form4['owner_serial_no']);
      vehicleodometerctrl =
          TextEditingController(text: form4['odometer_reading']);
      vehiclespecialcommentctrl =
          TextEditingController(text: form4['special_comments']);
      sAccedential = form4['accidental_summary'];
      sFlooded = form4['flooded_condition'];
      arrayfuelvalue = form4['fuel_type'];
      var form5 = result['exterior_front_side'];
      frontBumperDropDownResult = form5['front_bumper'];
      bonnetDropDownListresult = form5['bonnet'];
      arrayglassListresult = form5['front_glass'];
      arrayListroofresult = form5['roof'];
      var form6 = result['exterior_rhs_side'];
      arrayrhssideListresult = form6['rhs_side_appron'];
      frorhstyrpervalue = form6['front_rhs_tyre_percentage'];
      arrayrhsfenderListresult = form6['rhs_fender'];
      arrayrhsApillarListresult = form6['a_piller'];
      arrayrhsBpillarListresult = form6['b_piller'];
      arrayfrontrhswindowListresult = form6['front_rhs_window'];
      arrayfrontrhsdoorListresult = form6['front_rhs_door'];
      arrayrearrhsdoorListresult = form6['rear_rhs_door'];
      arrayrearrhswindowListresult = form6['rear_rhs_window'];
      arrayrhsrunningboardListresult = form6['rhs_running_board'];
      arrayrhsCpillarListresult = form6['c_piller'];
      rearhstyrpervalue = form6['rear_rhs_tyre_percentage'];
      quarterPanelArray = form6['rhs_quater_panel'];
      var form7 = result['exterior_back_side'];
      arraybackdickydoorListresult = form7['dicky_door'];
      arraybackrearglassListresult = form7['rear_glass'];
      arraybackdickyfloorconditionListresult = form7['dicky_floor_condition'];
      sparwheetyrpercvalue = form7['spare_wheel_tyre_percentage'];
      arraybackrearbumperListresult = form7['rear_bumper'];
      var form8 = result['exterior_lhs_side'];
      arraylhssideListresult = form8['lhs_side_appron'];
      frolhstyrpervalue = form8['front_lhs_tyre_percentage'];
      arraylhsfenderListresult = form8['lhs_fender'];
      arraylhsApillarListresult = form8['a_piller'];
      arraylhsBpillarListresult = form8['b_piller'];
      arrayfrontlhswindowListresult = form8['front_lhs_window'];
      arrayfrontlhsdoorListresult = form8['front_lhs_door'];
      arrayrearlhsdoorListresult = form8['rear_lhs_door'];
      arrayrearlhswindowListresult = form8['rear_lhs_window'];
      arraylhsrunningboardListresult = form8['lhs_running_board'];
      arraylhsCpillarListresult = form8['c_piller'];
      realhstyrpervalue = form8['rear_lhs_tyre_percentage'];
      arraylhsquaterpannelListresult = form8['lhs_quater_panel'];
      var form9 = result['interior'];
      airbagvalue = form9['airbag'];
      absvalue = form9['abs'];
      arraymusicsystemListresult = form9['music_system'];
      speakervalue = form9['speaker'];
      steeringwheelcondivalue = form9['steering_wheel_condition'];
      steerwheeautcontrbuttvalue = form9['steering_wheel_audio_control_button'];
      arrayautoacconditionListresult = form9['auto_ac_condition'];
      acflowvalue = form9['ac_flow'];
      acblowermotocondvalue = form9['ac_blower_moto_condition'];
      acdirectmodevalue = form9['ac_direction_mode'];
      acheatervalue = form9['ac_heater'];
      glowboxvalue = form9['glow_box'];
      gearleveknobvalue = form9['gear_lever_knob'];
      powerwindowvalue = form9['power_window'];
      rhssideseatcondivalue = form9['rhs_side_seat_condition'];
      lhssisdeseatcondivalue = form9['lhs_side_seat_condition'];
      rearseatconditivalue = form9['rear_seat_condition'];
      allseatcoveravaivalue = form9['all_seat_cover_available'];
      allmatsavialbevalue = form9['all_mats_available'];
      var form10 = result['test_derive'];
      frosuspensnoisevalue = form10['front_suspension_noise'];
      axlenoisevalue = form10['axie_noise'];
      rearsuspennoisevalue = form10['rear_suspension_noise'];
      arraytestclutchconditionListresult = form10['clutch_condition'];
      arraytestautomaticgearListresult = form10['automatic_gear_box'];
      gearboxvlaue = form10['gear_box'];
      gearboxnoisevalue = form10['gear_box_noise'];
      gearshiftingvalue = form10['gear_shifting'];
      wavalue = form10['w_a'];
      steerinnoisevalue = form10['steering_noise'];
      steericolumnoisevalue = form10['steering_column_noise'];
      speedometknobvalue = form10['speedometer_knob'];
      odometerreadinvalue = form10['odometer_reading'];
      var form11 = result['engine_compartment'];
      tappetnoisevalue = form11['tapped_noise'];
      engineoverheatvalue = form11['engine_overheating'];
      engineoilsludgevalue = form11['engine_oil_sludge'];
      oilConditionArray = form11['engine_oil_condition'];
      coolentArray = form11['coolent'];
      timigsidenoisvalue = form11['timeing_side_noise'];
      alternatecondivalue = form11['altmeter_condition'];
      batterycondivalue = form11['bettery_condition'];
      arrayengineaccompressorListresult = form11['ac_compressor'];
      motornoisevalue = form11['starter_motor_noise'];
      airfilterassyvalue = form11['air_fiter_assy'];
      enginevideoctrl =
          TextEditingController(text: form11['engine_video_link'].toString());
      var form12 = result['special_features'];
      comment1ctrl = TextEditingController(text: form12['comment_1']);
      comment2ctrl = TextEditingController(text: form12['comment_2']);
      comment3ctrl = TextEditingController(text: form12['comment_3']);
      comment4ctrl = TextEditingController(text: form12['comment_4']);
      comment5ctrl = TextEditingController(text: form12['comment_5']);
      comment6ctrl = TextEditingController(text: form12['comment_6']);
      comment7ctrl = TextEditingController(text: form12['comment_7']);
      comment8ctrl = TextEditingController(text: form12['comment_8']);
      comment9ctrl = TextEditingController(text: form12['comment_9']);
      comment10ctrl = TextEditingController(text: form12['comment_10']);
      comment11ctrl = TextEditingController(text: form12['comment_11']);
      comment12ctrl = TextEditingController(text: form12['comment_12']);
      comment13ctrl = TextEditingController(text: form12['comment_13']);
      comment14ctrl = TextEditingController(text: form12['comment_14']);
      comment15ctrl = TextEditingController(text: form12['comment_15']);
      var form13 = result['any_damage'];
      anydamage1ctrl = TextEditingController(text: form13['comment_1']);
      anydamage2ctrl = TextEditingController(text: form13['comment_2']);
      anydamage3ctrl = TextEditingController(text: form13['comment_3']);
      anydamage4ctrl = TextEditingController(text: form13['comment_4']);
      anydamage5ctrl = TextEditingController(text: form13['comment_5']);
      anydamage6ctrl = TextEditingController(text: form13['comment_6']);
      anydamage7ctrl = TextEditingController(text: form13['comment_7']);
      anydamage8ctrl = TextEditingController(text: form13['comment_8']);
      anydamage9ctrl = TextEditingController(text: form13['comment_9']);
      anydamage10ctrl = TextEditingController(text: form13['comment_10']);
      anydamage11ctrl = TextEditingController(text: form13['comment_11']);
      anydamage12ctrl = TextEditingController(text: form13['comment_12']);
      anydamage13ctrl = TextEditingController(text: form13['comment_13']);
      anydamage14ctrl = TextEditingController(text: form13['comment_14']);
      anydamage15ctrl = TextEditingController(text: form13['comment_15']);
      anydamage16ctrl = TextEditingController(text: form13['comment_16']);
      anydamage17ctrl = TextEditingController(text: form13['comment_17']);
      anydamage18ctrl = TextEditingController(text: form13['comment_18']);
      anydamage19ctrl = TextEditingController(text: form13['comment_19']);
      anydamage20ctrl = TextEditingController(text: form13['comment_20']);
      anydamage21ctrl = TextEditingController(text: form13['comment']);
    });
  }

  // Api
  addData() async {
    //Input
    FormData body = FormData.fromMap({
      "order_id": widget.sOrderID,
      //Form 1
      "purchase_cust_name": purchaseNameCtrl.text,
      "purchase_cust_no": purchaseNumberCtrl.text,
      "purchase_location": purchaseLocationCtrl.text,
      "sell_cust_name": sellNameCtrl.text,
      "sell_cust_no": sellNumberCtrl.text,
      "sell_location": sellLocationCtrl.text,

      // Form 2
      "rc": sRc,
      "rc_photo": sRc1Photo,
      "rc_type": sRcType,
      "rc_type_photo": sRc2Photo,
      "zero_dep_insuarance": sInsuranceType,
      "insuarance_photo": sInsurancePhoto,
      "expiry_date": rcExpiryCtrl.text,
      "exiry_photo": sExpiryPhoto,

      // Form 3
      "chasis_no": chassisNumberCtrl.text,
      "engine_no": chassisEngineNoCtrl.text,
      "chasis_photo": sChassisPhoto,
      "engine_photo": sEnginePhoto,

      // Form 4
      "vehicle_state": sVehicleState,
      "vehicle_no": vehicleNumberCtrl.text,
      "vehicle_make": sVehicleMake,
      "vehicle_model": sVehicleModel,
      "vehicle_color": arrayvehiclecolorvalue,
      "veriant": vehicleVariantCtrl.text,
      "mfg_year": mfgctrl.text,
      "reg_year": regctrl.text,
      "tax_validity": taxvalidctrl.text,
      "engine_cube_capacity": vehicleenginecubicctrl.text,
      "fuel_type": arrayfuelvalue,
      "owner_serial_no": vehicleownerserialctrl.text,
      "odometer_reading": vehicleodometerctrl.text,
      "special_comments": vehiclespecialcommentctrl.text,
      "accidental_summary": sAccedential,
      "flooded_condition": sFlooded,

      // Form 5
      "front_view": sFrontViewImg,
      "front_glass": sFrontGlassImg,
      "engine_compartment": sEnginecompartImg,
      "roof_image": sRoofImg,
      "front_rhs_side_tringle_view": sFrontrhssidetriImg,
      "front_rhs_tyre": sFrontrhstyreImg,
      "rhs_side_view": sRhssideviewImg,
      "rhs_side_interior_view": sRhssideinteriImg,
      "rear_rhs_tyre": sRearrhstyreImg,
      "back_side_view": sBacksideImg,
      "dicky_door_open_view": sDickydooropenImg,
      "dicky_floor_view": sDickyfloorImg,
      "rear_glass": sRearglassImg,
      "spare_wheel_tyre": sSparewheelImg,
      "rear_lhs_side_triangle_view": sLhssidetriImg,
      "rear_lhs_tyre": sRearlhstyreImg,
      "lhs_side_view": sLhssideviewImg,
      "rear_interior_view": sRearinteriorImg,
      "front_lhs_tyre": sFrontlhstyreImg,
      "dashboard_view": sDashboardviewImg,
      "odometer_view": sOdometerviewImg,

      // Form 6
      "front_bumper": frontBumperDropDownResult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "front_bumper_photo": sFrontBumerImg,
      "bonnet": bonnetDropDownListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "bonnet_photo": sbonnetImg,
      "front_glass_type": arrayglassListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "front_glass_photo": sFrontglassImg,
      "roof_condition": arrayListroofresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "roof_photo": sExtRoofImg,

      // Form 7
      "rhs_side_appron": arrayrhssideListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "rhs_appron_photo": sRsideAppImg,
      "front_rhs_tyre_percentage": frorhstyrpervalue,
      "rhs_fender": arrayrhsfenderListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "rhs_tyre_fender_photo": sRfenderImg,
      "a_piller": arrayrhsApillarListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "a_piller_photo": sRApillerImg,
      "b_piller": arrayrhsBpillarListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "b_piller_photo": sRBPillerImg,
      "front_rhs_window": arrayfrontrhswindowListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "front_rhs_door": arrayfrontrhsdoorListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "front_rhs_photo": sRDoorImg,
      "rear_rhs_door": arrayrearrhsdoorListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "rear_rhs_door_photo": sRrearDoorImg,
      "rear_rhs_window": arrayrearrhswindowListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "rhs_running_board": arrayrhsrunningboardListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "rhs_window_photo": sRrunniboardImg,
      "c_piller": arrayrhsCpillarListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "c_piller_photo": sRCPillerImg,
      "rear_rhs_tyre_percentage": rearhstyrpervalue,
      "rhs_quater_panel":
          quarterPanelArray.toString().replaceAll("[", "").replaceAll("]", ""),
      "rear_rhs_tyre_photo": sRquaterpannelImg,

      // Form 8
      "dicky_door": arraybackdickydoorListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "dicky_door_photo": sDickydoorImg,
      "rear_glass_back": arraybackrearglassListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "rear_glass_photo": sRgImg,
      "dicky_floor_condition": arraybackdickyfloorconditionListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "dicky_floor_photo": sbackDickyfloorImg,
      "spare_wheel_tyre_percentage": sparwheetyrpercvalue,
      "rear_bumper": arraybackrearbumperListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "spare_wheel_photo": sRearBumImg,

      // Form 9
      "lhs_side_appron": arraylhssideListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "lhs_appron_photo": sLsaImg,
      "front_lhs_tyre_percentage": frolhstyrpervalue,
      "lhs_fender": arraylhsfenderListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "lhs_tyre_fender_photo": sLfImg,
      "lhs_a_piller": arraylhsApillarListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "lhs_a_piller_photo": sLapImg,
      "lhs_b_piller": arraylhsBpillarListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "lhs_b_piller_photo": sLbpImg,
      "front_lhs_window": arrayfrontlhswindowListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "front_lhs_door": arrayfrontlhsdoorListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "front_lhs_photo": sLfdImg,
      "rear_lhs_door": arrayrearlhsdoorListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "rear_lhs_door_photo": sLrdImg,
      "rear_lhs_window": arrayrearlhswindowListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "lhs_running_board": arraylhsrunningboardListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "lhs_window_photo": sLrbImg,
      "lhs_c_piller": arraylhsCpillarListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "lhs_c_piller_photo": sLcpImg,
      "rear_lhs_tyre_percentage": realhstyrpervalue,
      "lhs_quater_panel": arraylhsquaterpannelListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "rear_lhs_tyre_photo": sLqpImg,

      // Form 10
      "airbag": airbagvalue,
      "abs": absvalue,
      "music_system": arraymusicsystemListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "speaker": speakervalue,
      "steering_wheel_condition": steeringwheelcondivalue,
      "steering_wheel_audio_control_button": steerwheeautcontrbuttvalue,
      "auto_ac_condition": arrayautoacconditionListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "ac_flow": acflowvalue,
      "ac_blower_moto_condition": acblowermotocondvalue,
      "ac_direction_mode": acdirectmodevalue,
      "ac_heater": acheatervalue,
      "glow_box": glowboxvalue,
      "gear_lever_knob": gearleveknobvalue,
      "power_window": powerwindowvalue,
      "rhs_side_seat_condition": rhssideseatcondivalue,
      "lhs_side_seat_condition": lhssisdeseatcondivalue,
      "rear_seat_condition": rearseatconditivalue,
      "all_seat_cover_available": allseatcoveravaivalue,
      "all_mats_available": allmatsavialbevalue,

      // Form 11
      "front_suspension_noise": frosuspensnoisevalue,
      "axie_noise": axlenoisevalue,
      "rear_suspension_noise": rearsuspennoisevalue,
      "clutch_condition": arraytestclutchconditionListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "automatic_gear_box": arraytestautomaticgearListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "gear_box": gearboxvlaue,
      "gear_box_noise": gearboxnoisevalue,
      "gear_shifting": gearshiftingvalue,
      "w_a": wavalue,
      "steering_noise": steerinnoisevalue,
      "steering_column_noise": steericolumnoisevalue,
      "speedometer_knob": speedometknobvalue,
      "odometer_reading2": odometerreadinvalue,

      // Form 12
      "tapped_noise": tappetnoisevalue,
      "engine_overheating": engineoverheatvalue,
      "engine_oil_sludge": engineoilsludgevalue,
      "engine_oil_condition":
          oilConditionArray.toString().replaceAll("[", "").replaceAll("]", ""),
      "coolent":
          coolentArray.toString().replaceAll("[", "").replaceAll("]", ""),
      "timeing_side_noise": timigsidenoisvalue,
      "altmeter_condition": alternatecondivalue,
      "bettery_condition": batterycondivalue,
      "ac_compressor": arrayengineaccompressorListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "starter_motor_noise": motornoisevalue,
      "air_fiter_assy": airfilterassyvalue,
      "engine_video_link": enginevideoctrl.text,

      // Form 13
      "comment_1": comment1ctrl.text,
      "comment_1_photo": sspecomm1,
      "comment_2": comment2ctrl.text,
      "comment_2_photo": sspecomm2,
      "comment_3": comment3ctrl.text,
      "comment_3_photo": sspecomm3,
      "comment_4": comment4ctrl.text,
      "comment_4_photo": sspecomm4,
      "comment_5": comment5ctrl.text,
      "comment_5_photo": sspecomm5,
      "comment_6": comment6ctrl.text,
      "comment_6_photo": sspecomm6,
      "comment_7": comment7ctrl.text,
      "comment_7_photo": sspecomm7,
      "comment_8": comment8ctrl.text,
      "comment_8_photo": sspecomm8,
      "comment_9": comment9ctrl.text,
      "comment_9_photo": sspecomm9,
      "comment_10": comment10ctrl.text,
      "comment_10_photo": sspecomm10,
      "comment_11": comment11ctrl.text,
      "comment_11_photo": sspecomm11,
      "comment_12": comment12ctrl.text,
      "comment_12_photo": sspecomm12,
      "comment_13": comment13ctrl.text,
      "comment_13_photo": sspecomm13,
      "comment_14": comment14ctrl.text,
      "comment_14_photo": sspecomm14,
      "comment_15": comment15ctrl.text,
      "comment_15_photo": sspecomm15,

      // Form 14
      "damage_comment_1": anydamage1ctrl.text,
      "damage_comment_1_photo": sanycomm1,
      "damage_comment_2": anydamage2ctrl.text,
      "damage_comment_2_photo": sanycomm2,
      "damage_comment_3": anydamage3ctrl.text,
      "damage_comment_3_photo": sanycomm3,
      "damage_comment_4": anydamage4ctrl.text,
      "damage_comment_4_photo": sanycomm4,
      "damage_comment_5": anydamage5ctrl.text,
      "damage_comment_5_photo": sanycomm5,
      "damage_comment_6": anydamage6ctrl.text,
      "damage_comment_6_photo": sanycomm6,
      "damage_comment_7": anydamage7ctrl.text,
      "damage_comment_7_photo": sanycomm7,
      "damage_comment_8": anydamage8ctrl.text,
      "damage_comment_8_photo": sanycomm8,
      "damage_comment_9": anydamage9ctrl.text,
      "damage_comment_9_photo": sanycomm9,
      "damage_comment_10": anydamage10ctrl.text,
      "damage_comment_10_photo": sanycomm10,
      "damage_comment_11": anydamage11ctrl.text,
      "damage_comment_11_photo": sanycomm11,
      "damage_comment_12": anydamage12ctrl.text,
      "damage_comment_12_photo": sanycomm12,
      "damage_comment_13": anydamage13ctrl.text,
      "damage_comment_13_photo": sanycomm13,
      "damage_comment_14": anydamage14ctrl.text,
      "damage_comment_14_photo": sanycomm14,
      "damage_comment_15": anydamage15ctrl.text,
      "damage_comment_15_photo": sanycomm15,
      "damage_comment_16": anydamage16ctrl.text,
      "damage_comment_16_photo": sanycomm16,
      "damage_comment_17": anydamage17ctrl.text,
      "damage_comment_17_photo": sanycomm17,
      "damage_comment_18": anydamage18ctrl.text,
      "damage_comment_18_photo": sanycomm18,
      "damage_comment_19": anydamage19ctrl.text,
      "damage_comment_19_photo": sanycomm19,
      "damage_comment_20": anydamage20ctrl.text,
      "damage_comment_20_photo": sanycomm20,
      "comment": anydamage21ctrl.text,
    });
    var result =
        await STM().post(ctx, Str().processing, "update_vehicle_details", body);
    if (!mounted) return;
    var error = result['error'];
    var message = result['message'];
    if (!error) {
      STM().displayToast("Success");
      successAlert(ctx, message, MyOrder());
    } else {
      STM().errorDialog(ctx, message);
    }
  }
}
