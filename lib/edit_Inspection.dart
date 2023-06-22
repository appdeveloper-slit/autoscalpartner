import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'customer_details.dart';
import 'final_page.dart';
import 'my_orders.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/strings.dart';
import 'any_damage.dart';
import 'interior.dart';
import 'special_features.dart';
import 'test_drive.dart';
import 'chassis_details.dart';
import 'engine_compartment.dart';
import 'exterior_back_side.dart';
import 'exterior_front_side.dart';
import 'exterior_lhs_side.dart';
import 'exterior_rhs_side.dart';
import 'manage/static_method.dart';
import 'rc_&_insurance_deatils.dart';
import 'upload_photos.dart';
import 'values/styles.dart';
import 'vehicle_details.dart';

class EditInspection extends StatefulWidget {
  final String Orderid;

  const EditInspection(this.Orderid, {Key? key}) : super(key: key);

  @override
  State<EditInspection> createState() => _EditInspectionState();
}

class _EditInspectionState extends State<EditInspection> {
  late BuildContext ctx;
  int pageNumber = 0;
  List<String> actionList = ["Yes", "No"];
  String sAccedential = "Yes", sFlooded = "Yes";

  //Customer Detail
  List<dynamic>? allData = [];
  TextEditingController CustomerDetailNameCtrl = TextEditingController();
  TextEditingController CustomerDetailNumberCtrl = TextEditingController();
  TextEditingController locationCtrl = TextEditingController();
  TextEditingController sellCustomerNameCtrl = TextEditingController();
  TextEditingController sellCustomerNumberCtrl = TextEditingController();
  TextEditingController location2Ctrl = TextEditingController();

  //RC Detail
  String? Rc1photo;
  String? Rc2photo;
  TextEditingController Rcexpiryctrl = TextEditingController();
  String? Rcinsurancephoto;
  List<dynamic>? thePreviousData;
  String? selectedValue;
  List<String> arrayList = ['Orginal', 'dublicate'];
  String v = "0";
  List<dynamic>? rcdata = [];
  String? rcDropDownSelected;
  String? rcTypeDropDownSelected;
  String? zeroDepInsuranceDropDownSelected;
  List<String> rcDropDownList = [
    "Orginal",
    "Duplicate",
    "Migrated RC",
  ];
  List<String> rcTypeDropDownList = [
    "Private",
    "Un-registered",
    "Commercial",
  ];
  List<String> zeroDepInsuranceDropDownList = [
    "Zero Dep Insurance",
    "Comprehensive Insurance.",
    "Third Party Insurance",
    "N/A",
  ];

  // time
  String? s;
  String? m;
  String? t;
  String? q;

  //chassis Detail
  String? chassisphoto;
  String? enginephoto;
  TextEditingController chassisnumberctrl = TextEditingController();
  TextEditingController chassisenginenoctrl = TextEditingController();

  // vehicle Detail
  String? arraystatevalue;
  String? arrayvehiclemakevalue;
  String? arrayvehiclecolorvalue;
  TextEditingController vehiclevarientctrl = TextEditingController();
  String? arrayfuelvalue;
  String? arrayvehiclemodelvalue;
  String? arrayvehiclevarientvalue;
  List<String> arrayvehicleList = [
    'GR',
    'AN',
    'AP',
    'AR',
    'AS',
    'BR',
    'CH',
    'DN',
    'DD',
    'DL',
    'GA',
    'GJ',
    'HR',
    'HP',
    'JK',
    'KA',
    'KL',
    'LD',
    'MP',
    'MH',
    'MN',
    'ML',
    'MZ',
    'NL',
    'OR',
    'PY',
    'PN',
    'RJ',
    'SK',
    'TN',
    'TR',
    'UP',
    'WB',
  ];
  List<dynamic> arrayvehiclemakelist = [
    {
      'name': 'Maruti suzuki',
      'array': [
        'Swift',
        'Swift Dzire',
        'Alto',
        'Alto 800',
        'Alto K10',
        'Eeco',
        'S- Presso',
        'Dzire',
        'Ignis',
        'Ciaz',
        'Ertiga',
        'XL6',
        'Wagnor',
        'S- Cross',
        'Dzire',
        'Vitara Brezza',
        'Vitara Grand',
        'SX4',
        'Celerio',
        'Gyspy',
        'Baleno',
        'A- Star',
        'Celerio X',
        'Omni',
        'Wagnor 1.0',
        'Estilo',
        'Zen Estilo',
        'Versa',
        'Wagnor Stingray',
        'Kizashi',
        'Ritz',
      ]
    },
    {
      'name': 'Hyundai',
      'array': [
        'I10',
        'Grand I10',
        'I20',
        'Elite I20',
        'Verna',
        'Venue',
        'Alcazar',
        'Creta',
        'Elentra',
        'Grand I10 Nios',
        'Xcent',
        'Santro',
        'Aura',
        'Tucson',
        'Santafe',
        'Kona Electric',
        'Sonta',
        'Accent',
        'I20 Active',
        'I20 N line',
        'Eon',
      ]
    },
    {
      'name': 'Tata',
      'array': [
        'Nexon',
        'Punch',
        'Hexa',
        'Tiago',
        'tigor',
        'Indica  Ev2',
        'Indigo Cs',
        'Aria',
        'Harrier',
        'Altorz',
        'Safari',
        'Nexon EV',
        'Sumo',
        'Bolt',
        'Zest',
        'Indica V2',
        'Indica Vista',
        'Indigo Ecs',
        'Manza',
        'Nano',
        'Safari strome',
        'Venture',
        'Winger',
        'xenon',
      ]
    },
    {
      'name': 'Toyota',
      'array': [
        'Innova',
        'Innova crysta',
        'Camry',
        'Fortuner',
        'Urban Cruiser',
        'Glanza',
        'Yaris',
        'Corolla',
        'Altis',
        'Etios',
        'Etios Liva',
        'Land Cruiser Prado',
        'Commuter',
        'Land Cruiser',
        'Qualis',
        'Yaris',
        'Hilux',
        'Etios Cross',
      ]
    },
    {
      'name': 'Honda',
      'array': [
        'Accord',
        'Brio',
        'CR-V',
        'City',
        'Jazz',
        'Civic',
        'Mobilio',
        'WR-V',
        'New Accord',
        'Amaze',
        'BR-V',
        'City Zx',
      ]
    },
    {
      'name': 'KIA',
      'array': [
        'Seltos',
        'Carnival',
        'Sonet',
        'Carens',
      ]
    },
    {
      'name': 'MG',
      'array': [
        'Hector',
        'Hector Plus',
        'Astor',
        'Gloster',
        'ZS- EV',
      ],
    },
    {
      'name': 'Mahindra',
      'array': [
        'Bolero',
        'Marazzo',
        'Scorpio',
        'XUV 300',
        'XUV 500',
        'XUV 700',
        'TUV 300',
        'TUV 300 Plus',
        'KUV 100',
        'Verito',
        'Logan',
        'Xylo',
        'Thar',
        'Alturas G4',
        'Nuvosport',
        'Quanto',
        'Rexton',
        'Bolero Power Plus',
        'Bolero Neo',
        'KUV 100 NXT',
        'Scorpio N',
      ]
    },
    {
      'name': 'Renault',
      'array': [
        'Fluence',
        'Pulse',
        'Duster',
        'Kwid',
        'Koleos',
        'Capture',
        'Lodgy',
        'Scala',
        'Triber',
        'Kiger',
      ]
    },
    {
      'name': 'Nissan',
      'array': [
        'Micra',
        'Kicks',
        'Magnite',
        'Sunny',
        'Terrano',
        'Tiana',
      ]
    },
    {
      'name': 'Datsun',
      'array': [
        'GO',
        'GO Plus',
        'Redigo',
      ]
    },
    {
      'name': 'Fiat',
      'array': [
        'Linea',
        'Punto',
        'Grand Punto',
        'Uno',
      ]
    },
    {
      'name': 'Volkswagen',
      'array': [
        'Ameo',
        'Passat',
        'Polo',
        'Polo GT',
        'Vento',
        'Tiguan',
        'Taigun',
        'Jetta',
        'Phaeton',
        'Cross Polo',
      ],
    },
    {
      'name': 'Skoda',
      'array': [
        'Rapid',
        'Superb',
        'Kushaq',
        'Slavia',
        'Octavia',
        'Kodiaq',
        'Fabia',
        'Yeti',
        'Laura',
      ]
    },
    {
      'name': 'Force',
      'array': [
        'Gurkha',
        'Force One',
        'Trax Cruiser',
      ],
    },
    {
      'name': 'Isuzu',
      'array': [
        'D Max',
        'MU-X',
        'MU- 7',
        'Dmax Vcross',
      ],
    },
    {
      'name': 'Jeep',
      'array': [
        'Compass',
        'Wrangler',
      ],
    },
    {
      'name': 'Jaguar',
      'array': [
        'XF',
        'XJ',
        'XE',
        'F Type',
        'F Pace',
        'XK',
      ],
    },
    {
      'name': 'Audi',
      'array': [
        'A4',
        'A6',
        'Q3',
        'Q7',
        'Q8',
        'Q2',
        'RS Q8',
        'E Torn',
        'A3',
        'A5',
        'A8',
        'R8'
            'RS5',
      ],
    },
    {
      'name': 'BMW',
      'array': [
        '2 Series',
        '3 Series',
        '3 Series GT',
        '5 Series',
        '5 Series GT',
        '6 Series',
        '7 Series',
        '7 Series GT',
        'M Series',
        'X1',
        'X3',
        'X4',
        'X5',
        'X6',
        'X7',
        'Z4',
        'Z3',
        'I8',
        'M8',
      ],
    },
    {
      'name': 'Mercedes Benz',
      'array': [
        'A Class',
        'B Class',
        'C Class',
        'GLA',
        'GLC',
        'ML',
        'GLS',
        'GLE Class',
        'S Class',
        'G Class',
        'E Class',
        'EQS',
      ],
    },
    {
      'name': 'Land Rover',
      'array': [
        'Discovery',
        'Range rover',
        'Discovery Sport',
        'Range rover Sport',
        'Range rover Velar',
        'Free Lander',
      ],
    },
    {
      'name': 'Lexus',
      'array': [
        'ES',
        'LS',
        'LX',
        'NX',
        'RX',
      ],
    },
    {
      'name': 'Mini',
      'array': [
        '3 Door',
        '5 Door',
        'Cooper 3 Door',
        'Cooper 5 Door',
        'Cooper Countryman',
        'Copper Clubman',
        'Cooper S',
      ],
    },
    {
      'name': 'Volvo',
      'array': [
        'XC 90',
        'XC 40',
        'XC 60',
        'S 60',
        'S 60 Cross country',
        'S 90',
        'V 40',
        'V 40 Cross country',
        'V 90 Cross country',
        'S 80',
      ],
    },
    // 'Baintley',
    // 'Mitsubishi',
    // 'Porsche',
    // 'Citroen'
  ];
  List<String> arrayvehiclemodellist = [];
  List<String> arrayvehiclevarientlist = ['zxi', 'syx', 'ysz'];
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
  List<String> arrayvehiclefuellist = [
    'Petrol',
    'Diesel',
    'Petrol & CNG',
    'Petrol & LPG',
    'Electric'
  ];
  TextEditingController vehiclenumberctrl = TextEditingController();
  TextEditingController mfgctrl = TextEditingController();
  TextEditingController regctrl = TextEditingController();
  TextEditingController taxvalidctrl = TextEditingController();
  TextEditingController vehicleenginecubicctrl = TextEditingController();
  TextEditingController vehicleownerserialctrl = TextEditingController();
  TextEditingController vehicleodometerctrl = TextEditingController();
  TextEditingController vehiclespecialcommentctrl = TextEditingController();
  var hypo = 1;
  TextEditingController banknameCtrl = TextEditingController();

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
  List<String> arrayrhsquaterpannelList = [
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
  List<dynamic> arrayrhsquaterpannelListresult = [];
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
    "Rusted",
    "Replace",
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
    "Damaged",
    "Minor Dent",
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
  List<String> arrayengineoilconditionList = ['Good', 'Bad', 'Leakage'];
  List<dynamic> arrayengineoilconditionListresult = [];
  List<String> arrayenginecoolentList = ['Good', 'Bad', 'Leakage'];
  List<dynamic> arrayenginecoolentListresult = [];
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
  String? expimg;

  final _formKey = GlobalKey<FormState>();

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
        backgroundColor: Color(0xffffffff),
        leading: InkWell(
          onTap: () {
            if (pageNumber > 0) {
              setState(() {
                pageNumber--;
              });
            } else {
              Navigator.pop(ctx);
            }
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Color(0xff2E135D),
          ),
        ),
        centerTitle: true,
        title: Text(
          pageNumber == 0
              ? 'Inspection'
              :
          // pageNumber == 1
          //         ? 'Customer Details'
          //         :
          pageNumber == 2
                      ? 'Rc and Insurance'
                      : pageNumber == 3
                          ? 'Chassis Details'
                          : pageNumber == 4
                              ? 'Vehicle Details'
                              : pageNumber == 5
                                  ? 'Upload Photos'
                                  : pageNumber == 6
                                      ? 'Exterior Front Side'
                                      : pageNumber == 7
                                          ? 'Exterior Rhs Side'
                                          : pageNumber == 8
                                              ? 'Exterior Back Side'
                                              : pageNumber == 9
                                                  ? 'Exterior LHS Side'
                                                  : pageNumber == 10
                                                      ? 'Interior'
                                                      : pageNumber == 11
                                                          ? 'Test Drive'
                                                          : pageNumber == 12
                                                              ? 'Engine Compartment'
                                                              : pageNumber == 13
                                                                  ? 'Special Features'
                                                                  : pageNumber ==
                                                                          14
                                                                      ? 'Any Damage'
                                                                      : 'Inspection',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              foreground: Paint()
                // ignore: prefer_const_constructors
                ..shader = LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  // ignore: prefer_const_literals_to_create_immutables
                  colors: <Color>[
                    Color(0xff34135B),
                    Color(0xffA9163A),
                    // Color(0xff000000)
                  ],
                ).createShader(Rect.fromLTWH(0.0, 35.0, 200.0, 70.0))),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (pageNumber > 0) {
            setState(() {
              pageNumber--;
            });
            return false;
          } else {
            return true;
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              if (pageNumber == 0) summaryLayout(),
              // if (pageNumber == 1) customerDetailLayout(),
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
    );
  }

  //Summary
  Widget summaryLayout() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              pageNumber = 1;
            });
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xffE4DFDF)),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 8, top: 16, left: 8, bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Customer Details',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        width: 160,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Color(0xff7F7A7A),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),

        InkWell(
          onTap: () {
            setState(() {
              pageNumber = 2;
            });
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xffE4DFDF)),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 8, top: 16, left: 8, bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'RC & Insurance Details',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        width: 122,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Color(0xff7F7A7A),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(
          height: 16,
        ),
        InkWell(
          onTap: () {
            setState(() {
              pageNumber = 3;
            });
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xffE4DFDF)),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 8, top: 16, left: 8, bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Chassis Details',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        width: 170,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Color(0xff7F7A7A),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(
          height: 16,
        ),
        InkWell(
          onTap: () {
            setState(() {
              pageNumber = 4;
            });
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xffE4DFDF)),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 8, top: 16, left: 8, bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Vehicle Details',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        width: 174,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Color(0xff7F7A7A),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(
          height: 16,
        ),
        InkWell(
          onTap: () {
            setState(() {
              pageNumber = 5;
            });
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xffE4DFDF)),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 8, top: 16, left: 8, bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Upload Photos',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        width: 174,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Color(0xff7F7A7A),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(
          height: 16,
        ),
        InkWell(
          onTap: () {
            setState(() {
              pageNumber = 6;
            });
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xffE4DFDF)),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 8, top: 16, left: 8, bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Exterior Front Side',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Color(0xff7F7A7A),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // SizedBox(
        //   height: 16,
        // ),
        // InkWell(
        //   onTap: () {
        //     STM().redirect2page(ctx, Bonnet());
        //   },
        //   child: Container(
        //     decoration: BoxDecoration(
        //         border: Border.all(color: Color(0xffE4DFDF)),
        //         borderRadius: BorderRadius.all(Radius.circular(4))),
        //     child: Column(
        //       children: [
        //         Padding(
        //           padding: const EdgeInsets.only(
        //               right: 8, top: 16, left: 8, bottom: 16),
        //           child: Row(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Expanded(
        //                 child: Text(
        //                   'Bonnet',
        //                   style: TextStyle(
        //                       fontSize: 16, fontWeight: FontWeight.w400),
        //                 ),
        //               ),
        //               SizedBox(
        //                 width: 230,
        //               ),
        //               Icon(
        //                 Icons.arrow_forward_ios,
        //                 size: 18,
        //                 color: Color(0xff7F7A7A),
        //               )
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        // SizedBox(
        //   height: 16,
        // ),
        // InkWell(
        //   onTap: () {
        //     STM().redirect2page(ctx, FrontGlass());
        //   },
        //   child: Container(
        //     decoration: BoxDecoration(
        //         border: Border.all(color: Color(0xffE4DFDF)),
        //         borderRadius: BorderRadius.all(Radius.circular(4))),
        //     child: Column(
        //       children: [
        //         Padding(
        //           padding: const EdgeInsets.only(
        //               right: 8, top: 16, left: 8, bottom: 16),
        //           child: Row(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Expanded(
        //                 child: Text(
        //                   'Front Glass',
        //                   style: TextStyle(
        //                       fontSize: 16, fontWeight: FontWeight.w400),
        //                 ),
        //               ),
        //               SizedBox(
        //                 width: 198,
        //               ),
        //               Icon(
        //                 Icons.arrow_forward_ios,
        //                 size: 18,
        //                 color: Color(0xff7F7A7A),
        //               )
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        // SizedBox(
        //   height: 16,
        // ),
        // InkWell(
        //   onTap: () {
        //     STM().redirect2page(ctx, Roof());
        //   },
        //   child: Container(
        //     decoration: BoxDecoration(
        //         border: Border.all(color: Color(0xffE4DFDF)),
        //         borderRadius: BorderRadius.all(Radius.circular(4))),
        //     child: Column(
        //       children: [
        //         Padding(
        //           padding: const EdgeInsets.only(
        //               right: 8, top: 16, left: 8, bottom: 16),
        //           child: Row(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Expanded(
        //                 child: Text(
        //                   'Roof',
        //                   style: TextStyle(
        //                       fontSize: 16, fontWeight: FontWeight.w400),
        //                 ),
        //               ),
        //               SizedBox(
        //                 width: 246,
        //               ),
        //               Icon(
        //                 Icons.arrow_forward_ios,
        //                 size: 18,
        //                 color: Color(0xff7F7A7A),
        //               )
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        SizedBox(
          height: 16,
        ),
        InkWell(
          onTap: () {
            setState(() {
              pageNumber = 7;
            });
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xffE4DFDF)),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 4, top: 16, left: 8, bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Exterior RHS Side',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        width: 192,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Color(0xff7F7A7A),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(
          height: 16,
        ),
        InkWell(
          onTap: () {
            setState(() {
              pageNumber = 8;
            });
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xffE4DFDF)),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 8, top: 16, left: 8, bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Exterior Back side',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        width: 152,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Color(0xff7F7A7A),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(
          height: 16,
        ),
        InkWell(
          onTap: () {
            setState(() {
              pageNumber = 9;
            });
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xffE4DFDF)),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 8, top: 16, left: 8, bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Exterior LHS Side',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        width: 190,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Color(0xff7F7A7A),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(
          height: 16,
        ),
        InkWell(
          onTap: () {
            setState(() {
              pageNumber = 10;
            });
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xffE4DFDF)),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 8, top: 16, left: 8, bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Interior',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        width: 226,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Color(0xff7F7A7A),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(
          height: 16,
        ),
        InkWell(
          onTap: () {
            setState(() {
              pageNumber = 11;
            });
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xffE4DFDF)),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 8, top: 16, left: 8, bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Test Drive',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        width: 206,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Color(0xff7F7A7A),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(
          height: 16,
        ),
        InkWell(
          onTap: () {
            setState(() {
              pageNumber = 12;
            });
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xffE4DFDF)),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 8, top: 16, left: 8, bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Engine Compartment',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        width: 125,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Color(0xff7F7A7A),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(
          height: 16,
        ),
        InkWell(
          onTap: () {
            setState(() {
              pageNumber = 13;
            });
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xffE4DFDF)),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 8, top: 16, left: 8, bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Special features Photo & Name',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        width: 56,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Color(0xff7F7A7A),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(
          height: 16,
        ),
        InkWell(
          onTap: () {
            setState(() {
              pageNumber = 14;
            });
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xffE4DFDF)),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 8, top: 16, left: 8, bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Any Damages photo & Name',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        width: 74,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Color(0xff7F7A7A),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  //Customer Detail
  Widget customerDetailLayout() {
    return Form(
      key: _formKey,
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
          // textField(CustomerDetailNameCtrl),
          TextFormField(
            controller: CustomerDetailNameCtrl,
            validator: (value) {
              if (value!.isEmpty) {
                return 'This Field Is Required';
              }
            },
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
            controller: CustomerDetailNumberCtrl,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'This Field Is Required';
              }
              if (value!.length != 10) {
                return 'Mobile Number must be of 10 digit';
              } else
                return null;
            },
            maxLength: 10,
            decoration: InputDecoration(
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
            child: Text('Location ',
                style: Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
          ),
          SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: locationCtrl,
            validator: (value) {
              if (value!.isEmpty) {
                return 'This Field Is Required';
              }
            },
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
            validator: (value) {
              if (value!.isEmpty) {
                return 'This Field Is Required';
              }
            },
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
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'This Field Is Required';
              }
              if (value!.length != 10) {
                return 'Mobile Number must be of 10 digit';
              } else
                return null;
            },
            maxLength: 10,
            decoration: InputDecoration(
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
            controller: location2Ctrl,
            validator: (value) {
              if (value!.isEmpty) {
                return 'This Field Is Required';
              }
            },
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
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    pageNumber++;
                  });
                }
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
    );
  }

  //RC Detail
  Widget rcDetailLayout() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text('RC ',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<String>(
                    hint: Text(rcDropDownSelected ?? "Select an option"),
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
                    validator: (value) =>
                        value == null ? 'field required' : null,
                    value: rcDropDownSelected,
                    isExpanded: true,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 28,
                    ),
                    style: TextStyle(color: Color(0xff000000)),
                    items: rcDropDownList.map((String string) {
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
                        rcDropDownSelected = v!;
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
                            setState(() {
                              filePicker("rc1", true);
                            });
                          },
                          child: Icon(Icons.camera_alt_outlined,
                              color: Colors.white),
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
                          Rc1photo != null
                              ? 'Image Selected'
                              : 'Upload RC Photo',
                          style: Sty().mediumText.copyWith(
                                color: Clr().white,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          rc == '1'
              ? Rc1photo == null
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
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<String>(
                    hint: Text(rcTypeDropDownSelected ?? "Select RC Type"),
                    validator: (value) =>
                        value == null ? 'field required' : null,
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
                    value: rcTypeDropDownSelected,
                    isExpanded: true,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 28,
                    ),
                    style: TextStyle(color: Color(0xff000000)),
                    items: rcTypeDropDownList.map((String string) {
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
                        rcTypeDropDownSelected = v!;
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
                            setState(() {
                              filePicker("rc2", true);
                            });
                          },
                          child: Icon(Icons.camera_alt_outlined,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                            onTap: () {
                              setState(() {
                                filePicker("rc2", false);
                              });
                            },
                            child: SvgPicture.asset('assets/upload.svg')),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          Rc2photo != null
                              ? 'Image Selected'
                              : 'Upload RC Photo',
                          style: Sty().mediumText.copyWith(
                                color: Clr().white,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          rc == '1'
              ? Rc2photo == null
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
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<String>(
                    hint: Text(zeroDepInsuranceDropDownSelected ??
                        "Select Zero Dep Insurance"),
                    validator: (value) =>
                        value == null ? 'field required' : null,
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
                    value: zeroDepInsuranceDropDownSelected,
                    isExpanded: true,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 28,
                    ),
                    style: TextStyle(color: Color(0xff000000)),
                    items: zeroDepInsuranceDropDownList.map((String string) {
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
                        zeroDepInsuranceDropDownSelected = v!;
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
                            setState(() {
                              filePicker("rcinsurance", true);
                            });
                          },
                          child: Icon(Icons.camera_alt_outlined,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                            onTap: () {
                              setState(() {
                                filePicker("rcinsurance", false);
                              });
                            },
                            child: SvgPicture.asset('assets/upload.svg')),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          Rcinsurancephoto != null
                              ? 'Image Selected'
                              : 'Upload Insurance Photo',
                          style: Sty().mediumText.copyWith(
                                color: Clr().white,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          rc == '1'
              ? Rcinsurancephoto == null
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
            },
            controller: Rcexpiryctrl,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(12),
              // label: Text('Enter Your Number'),
              hintText: "01/09/2022",
              prefixIcon: Padding(
                padding: const EdgeInsets.only(
                    left: 12, right: 20, top: 16, bottom: 12),
                child: SvgPicture.asset('assets/Calender1.svg'),
              ),

              border: OutlineInputBorder(
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
                      setState(() {
                        filePicker("exp", true);
                      });
                    },
                    child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          filePicker("exp", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    expimg != null ? 'Image Selected' : 'Upload Photo',
                    style: Sty().mediumText.copyWith(
                          color: Clr().white,
                        ),
                  ),
                ],
              ),
            ),
          ),
          rc == '1'
              ? expimg == null
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
                    gradient: Sty().linearGradient,
                    borderRadius: BorderRadius.circular(
                      Dim().d4,
                    ),
                  ),
                  margin: EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        pageNumber--;
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
                    gradient: Sty().linearGradient,
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
                      if (expimg == null) {
                        return null;
                      }
                      if (Rcinsurancephoto == null) {
                        return null;
                      }
                      if (Rc1photo == null) {
                        return null;
                      }
                      if (Rc2photo == null) {
                        return null;
                      }
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        setState(() {
                          pageNumber++;
                        });
                      }
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
      ),
    );
  }

  // chasis Detail
  Widget chassislayout() {
    return Form(
      key: _formKey,
      child: Column(
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
            controller: chassisnumberctrl,
            validator: (value) {
              if (value!.isEmpty) {
                return 'This Field is Required';
              }
            },
            decoration: InputDecoration(
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
                      setState(() {
                        filePicker("chassisphoto", true);
                      });
                    },
                    child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          filePicker("chassisphoto", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    chassisphoto != null
                        ? 'Image Selected'
                        : 'Upload Chassis Photo',
                    style: Sty().mediumText.copyWith(
                          color: Clr().white,
                        ),
                  ),
                ],
              ),
            ),
          ),
          chasis == '1'
              ? chassisphoto == null
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
            controller: chassisenginenoctrl,
            validator: (value) {
              if (value!.isEmpty) {
                return 'This Field is Required';
              }
            },
            decoration: InputDecoration(
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
                      setState(() {
                        filePicker("enginephoto", true);
                      });
                    },
                    child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          filePicker("enginephoto", false);
                        });
                      },
                      child: SvgPicture.asset('assets/upload.svg')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    enginephoto != null
                        ? 'Image Selected'
                        : 'Upload engine Photo',
                    style: Sty().mediumText.copyWith(
                          color: Clr().white,
                        ),
                  ),
                ],
              ),
            ),
          ),
          chasis == '1'
              ? enginephoto == null
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
                    setState(() {
                      chasis = '1';
                    });
                    if (enginephoto == null) {
                      return null;
                    }
                    if (chassisphoto == null) {
                      return null;
                    }
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      setState(() {
                        pageNumber++;
                      });
                    }
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
    );
  }

  // vehicle detail
  Widget vehiclelayout() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Vehicle State ',
                  style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
          SizedBox(
            height: 12,
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<String>(
                    hint: Text(arraystatevalue ?? "Select Vehicle State"),
                    value: arraystatevalue,
                    validator: (value) =>
                        value == null ? 'field required' : null,
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
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 28,
                    ),
                    style: TextStyle(color: Color(0xff000000)),
                    items: arrayvehicleList.map((String string) {
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
                        arraystatevalue = v!;
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
                      style: Sty()
                          .largeText
                          .copyWith(fontWeight: FontWeight.w400)),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: vehiclenumberctrl,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This Field is Required';
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    // label: Text('Enter Your Number'),
                    hintText: "MH43AT 6758",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dim().d8),
                        borderSide: BorderSide(
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
                    hint: Text(arrayvehiclemakevalue ?? "Select Vehicle Make"),
                    validator: (value) =>
                        value == null ? 'field required' : null,
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
                    value: arrayvehiclemakevalue,
                    isExpanded: true,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 28,
                    ),
                    style: TextStyle(color: Color(0xff000000)),
                    items: arrayvehiclemakelist.map((string) {
                      return DropdownMenuItem<dynamic>(
                        value: string["name"],
                        child: Text(
                          string["name"],
                          style:
                              TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
                        ),
                      );
                    }).toList(),
                    onChanged: (v) {
                      // STM().redirect2page(ctx, Home());
                      setState(() {
                        arrayvehiclemakevalue = v;
                        int position = arrayvehiclemakelist
                            .indexWhere((element) => v == element['name']);
                        arrayvehiclemodellist =
                            arrayvehiclemakelist[position]['array'];
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
                    validator: (value) =>
                        value == null ? 'field required' : null,
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
                    hint:
                        Text(arrayvehiclemodelvalue ?? "Select Vehicle Model"),
                    value: arrayvehiclemodelvalue,
                    isExpanded: true,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 28,
                    ),
                    style: TextStyle(color: Color(0xff000000)),
                    items: arrayvehiclemodellist.map((String string) {
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
                        arrayvehiclemodelvalue = v!;
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
                  controller: vehiclevarientctrl,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This Field is Required';
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    // label: Text('Varient'),
                    hintText: "AB",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dim().d8),
                        borderSide: BorderSide(
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
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    // label: Text('Enter Your Number'),
                    hintText: "01/09/2022",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(
                          left: 12, right: 20, top: 16, bottom: 12),
                      child: SvgPicture.asset('assets/Calender1.svg'),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dim().d8),
                        borderSide: BorderSide(
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
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    // label: Text('Enter Your Number'),
                    hintText: "01/09/2022",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(
                          left: 12, right: 20, top: 16, bottom: 12),
                      child: SvgPicture.asset('assets/Calender1.svg'),
                    ),

                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dim().d8),
                        borderSide: BorderSide(
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
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    // label: Text('Enter Your Number'),
                    hintText: "01/09/2022",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(
                          left: 12, right: 20, top: 16, bottom: 12),
                      child: SvgPicture.asset('assets/Calender1.svg'),
                    ),

                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dim().d8),
                        borderSide: BorderSide(
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
                    validator: (value) =>
                        value == null ? 'field required' : null,
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
                    hint:
                        Text(arrayvehiclecolorvalue ?? "Select Vehicle Colour"),
                    value: arrayvehiclecolorvalue,
                    isExpanded: true,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 28,
                    ),
                    style: TextStyle(color: Color(0xff000000)),
                    items: arrayvehiclecolorlist.map((String string) {
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
                      style: Sty()
                          .largeText
                          .copyWith(fontWeight: FontWeight.w400)),
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
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    // label: Text('Enter Your Number'),
                    hintText: "1197",

                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dim().d8),
                        borderSide: BorderSide(
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
                    validator: (value) =>
                        value == null ? 'field required' : null,
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
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 28,
                    ),
                    style: TextStyle(color: Color(0xff000000)),
                    items: arrayvehiclefuellist.map((String string) {
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
                      style: Sty()
                          .largeText
                          .copyWith(fontWeight: FontWeight.w400)),
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
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    // label: Text('Enter Your Number'),
                    hintText: "01",

                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dim().d8),
                        borderSide: BorderSide(
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
                      style: Sty()
                          .largeText
                          .copyWith(fontWeight: FontWeight.w400)),
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
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    // label: Text('Enter Your Number'),
                    hintText: "001",

                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dim().d8),
                        borderSide: BorderSide(
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
                      style: Sty()
                          .largeText
                          .copyWith(fontWeight: FontWeight.w400)),
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
                            setState(() {
                              sAccedential = value!;
                            });
                          },
                        ),
                        const Text(
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
                            setState(() {
                              sAccedential = value!;
                            });
                          },
                        ),
                        const Text(
                          'No',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'skstandard',
                            color: const Color(0xff747688),
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
                      style: Sty()
                          .largeText
                          .copyWith(fontWeight: FontWeight.w400)),
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
                            setState(() {
                              sFlooded = value!;
                            });
                          },
                        ),
                        const Text(
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
                            setState(() {
                              sFlooded = value!;
                            });
                          },
                        ),
                        const Text(
                          'No',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'skstandard',
                            color: const Color(0xff747688),
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
                      style: Sty()
                          .largeText
                          .copyWith(fontWeight: FontWeight.w400)),
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
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    // label: Text('Enter Your Number'),
                    // hintText: "01",

                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dim().d8),
                        borderSide: BorderSide(
                          color: Color(0xffE4DFDF),
                        )),
                  ),
                ),
                SizedBox(
                  height: Dim().d20,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Hypothecation",style: Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
                    ToggleSwitch(
                      minWidth: 90.0,
                      activeBgColors: [[Colors.green[800]!], [Colors.red[800]!]],
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      initialLabelIndex: hypo,
                      totalSwitches: 2,
                      labels: ['Yes', 'No'],
                      onToggle: (index) {
                        setState((){
                          hypo = index as int;
                        });
                        print('switched to: $index');
                      },
                    ),
                  ],
                ),
                hypo == 1 ? Container() :  SizedBox(
                  height: Dim().d20,
                ),
                hypo == 1 ? Container() :Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Bank Name',
                      style:
                      Sty().largeText.copyWith(fontWeight: FontWeight.w400)),
                ),
                hypo == 1 ? Container() : SizedBox(
                  height: Dim().d8,
                ),
                hypo == 1 ? Container() :TextFormField(
                  controller: banknameCtrl,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This Field is Required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
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
                  height: Dim().d32,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            pageNumber--;
                          });
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
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              pageNumber++;
                            });
                          }
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
        ],
      ),
    );
  }

  //uploadphotos

  Widget uploadphotolayout() {
    return Form(
      key: _formKey,
      child: Column(
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
                      setState(() {
                        filePicker("fvp", true);
                      });
                    },
                    child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
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
                          color: Clr().white,
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
                      setState(() {
                        filePicker("fgi", true);
                      });
                    },
                    child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
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
                          color: Clr().white,
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
                      setState(() {
                        filePicker("eci", true);
                      });
                    },
                    child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
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
                          color: Clr().white, overflow: TextOverflow.ellipsis),
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
                      setState(() {
                        filePicker("ri", true);
                      });
                    },
                    child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
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
                          color: Clr().white,
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
                      setState(() {
                        filePicker("frsti", true);
                      });
                    },
                    child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
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
                          color: Clr().white, overflow: TextOverflow.ellipsis),
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
                      setState(() {
                        filePicker("frtyi", true);
                      });
                    },
                    child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
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
                          color: Clr().white,
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
                      setState(() {
                        filePicker("rsvi", true);
                      });
                    },
                    child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
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
                          color: Clr().white,
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
                      setState(() {
                        filePicker("rsii", true);
                      });
                    },
                    child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
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
                          color: Clr().white,
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
                      setState(() {
                        filePicker("rrtyi", true);
                      });
                    },
                    child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
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
                          color: Clr().white,
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
                      setState(() {
                        filePicker("bsi", true);
                      });
                    },
                    child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
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
                          color: Clr().white,
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
                      setState(() {
                        filePicker("ddoi", true);
                      });
                    },
                    child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
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
                          color: Clr().white,
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
                      setState(() {
                        filePicker("dfi", true);
                      });
                    },
                    child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
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
                          color: Clr().white,
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
                      setState(() {
                        filePicker("rgi", true);
                      });
                    },
                    child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
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
                          color: Clr().white,
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
                      setState(() {
                        filePicker("sweei", true);
                      });
                    },
                    child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
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
                          color: Clr().white,
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
                      setState(() {
                        filePicker("lsti", true);
                      });
                    },
                    child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
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
                          color: Clr().white,
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
                      setState(() {
                        filePicker("rltyi", true);
                      });
                    },
                    child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
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
                          color: Clr().white,
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
                      setState(() {
                        filePicker("lsvi", true);
                      });
                    },
                    child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
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
                          color: Clr().white,
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
                      setState(() {
                        filePicker("rii", true);
                      });
                    },
                    child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
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
                          color: Clr().white,
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
                      setState(() {
                        filePicker("fltyi", true);
                      });
                    },
                    child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
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
                          color: Clr().white,
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
                      setState(() {
                        filePicker("dbvi", true);
                      });
                    },
                    child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
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
                          color: Clr().white,
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
                      setState(() {
                        filePicker("omevi", true);
                      });
                    },
                    child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
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
                          color: Clr().white,
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
                    setState(() {
                      photo = '1';
                    });
                    if (sFrontViewImg == null) {
                      return null;
                    }
                    if (sFrontGlassImg == null) {
                      return null;
                    }
                    if (sEnginecompartImg == null) {
                      return null;
                    }
                    if (sRoofImg == null) {
                      return null;
                    }
                    if (sFrontrhssidetriImg == null) {
                      return null;
                    }
                    if (sFrontrhstyreImg == null) {
                      return null;
                    }
                    if (sRhssideviewImg == null) {
                      return null;
                    }
                    if (sRhssideinteriImg == null) {
                      return null;
                    }
                    if (sRearrhstyreImg == null) {
                      return null;
                    }
                    if (sBacksideImg == null) {
                      return null;
                    }
                    if (sDickydooropenImg == null) {
                      return null;
                    }
                    if (sDickyfloorImg == null) {
                      return null;
                    }
                    if (sRearglassImg == null) {
                      return null;
                    }
                    if (sSparewheelImg == null) {
                      return null;
                    }
                    if (sLhssidetriImg == null) {
                      return null;
                    }
                    if (sRearlhstyreImg == null) {
                      return null;
                    }
                    if (sLhssideviewImg == null) {
                      return null;
                    }
                    if (sRearinteriorImg == null) {
                      return null;
                    }
                    if (sFrontlhstyreImg == null) {
                      return null;
                    }
                    if (sDashboardviewImg == null) {
                      return null;
                    }
                    if (sOdometerviewImg == null) {
                      return null;
                    }
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        pageNumber++;
                      });
                    }
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
    );
  }

  //exteriorfrontside

  Widget exteriorfronsidelayout() {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text('Front Bumper',
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
            SizedBox(
              height: 12,
            ),
            MultiSelectDialogField(
              dialogHeight: 350,
              dialogWidth: 450,
              initialValue: frontBumperDropDownResult.length == 0
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
              buttonIcon: Icon(
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
                ? frontBumperDropDownResult.length == 0
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
                child: Text('Photo of Scratches, dent & repair ',
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
            SizedBox(
              height: 12,
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
                        filePicker("fbi", true);
                      },
                      child:
                          Icon(Icons.camera_alt_outlined, color: Colors.white),
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
                            color: Clr().white,
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
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
            SizedBox(
              height: 12,
            ),
            MultiSelectDialogField(
              dialogHeight: 350,
              dialogWidth: 450,
              initialValue: bonnetDropDownListresult.length == 0
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
              buttonIcon: Icon(
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
                ? bonnetDropDownListresult.length == 0
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
                child: Text('Photo of Scratches, dent & repair ',
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
            SizedBox(
              height: 12,
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
                        filePicker("bi", true);
                      },
                      child:
                          Icon(Icons.camera_alt_outlined, color: Colors.white),
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
                      sbonnetImg != null
                          ? 'Image Selected'
                          : 'Upload Bonnet Photo',
                      style: Sty().mediumText.copyWith(
                            color: Clr().white,
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
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
            SizedBox(
              height: 12,
            ),
            MultiSelectDialogField(
              dialogHeight: 350,
              dialogWidth: 450,
              initialValue: arrayglassListresult.length == 0
                  ? null
                  : arrayglassListresult,
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
              buttonIcon: Icon(
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
                ? arrayglassListresult.length == 0
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
                child: Text('Photo of Scratches, dent & repair ',
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
            SizedBox(
              height: 12,
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
                        filePicker("frgi", true);
                      },
                      child:
                          Icon(Icons.camera_alt_outlined, color: Colors.white),
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
                      sFrontglassImg != null
                          ? 'Image Selected'
                          : 'Upload Photo',
                      style: Sty().mediumText.copyWith(
                            color: Clr().white,
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
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
            SizedBox(
              height: 12,
            ),
            MultiSelectDialogField(
              dialogHeight: 350,
              dialogWidth: 450,
              initialValue: arrayListroofresult,
              // arrayListroofresult.length == 0 ? null : arrayListroofresult,
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
              buttonIcon: Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              onConfirm: (results) {
                arrayListroofresult = results;
              },
            ),
            extfrtphoto == '1'
                ? arrayListroofresult.length == 0
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
                child: Text('Photo of Scratches, dent & repair ',
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
            SizedBox(
              height: 12,
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
                        filePicker("eri", true);
                      },
                      child:
                          Icon(Icons.camera_alt_outlined, color: Colors.white),
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
                            color: Clr().white,
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
                      });
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
                      setState(() {
                        extfrtphoto = '1';
                      });
                      if (sFrontBumerImg == null) {
                        return null;
                      }
                      if (sbonnetImg == null) {
                        return null;
                      }
                      if (sFrontglassImg == null) {
                        return null;
                      }
                      if (sExtRoofImg == null) {
                        return null;
                      }
                      if (frontBumperDropDownResult.length == 0) {
                        return null;
                      }
                      if (bonnetDropDownListresult.length == 0) {
                        return null;
                      }
                      if (arrayglassListresult.length == 0) {
                        return null;
                      }
                      if (arrayListroofresult.length == 0) {
                        return null;
                      }
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          pageNumber++;
                        });
                      }
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

  //exteriorrhs
  Widget exteriorrhslayout() {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
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
              initialValue: arrayrhssideListresult.length == 0
                  ? null
                  : arrayrhssideListresult,
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
              buttonIcon: Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              onConfirm: (results) {
                setState(() {
                  arrayrhssideListresult = results;
                  //FocusManager.instance.primaryFocus!.unfocus();
                });
              },
            ),
            extrhsphoto == '1'
                ? arrayrhssideListresult.length == 0
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
                        filePicker("Rsai", true);
                      },
                      child:
                          Icon(Icons.camera_alt_outlined, color: Colors.white),
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
                            color: Clr().white,
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
                hint: Text(
                    frorhstyrpervalue ?? "Select Front RHS Tyre percentage"),
                value: frorhstyrpervalue,
                isExpanded: true,
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arrayfrontrhspercentList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (v) {
                  // STM().redirect2page(ctx, Home());
                  setState(() {
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
              initialValue: arrayrhsfenderListresult.length == 0
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
              buttonIcon: Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              onConfirm: (results) {
                setState(() {
                  arrayrhsfenderListresult = results;
                  ////FocusManager.instance.primaryFocus!.unfocus();
                });
              },
            ),
            extrhsphoto == '1'
                ? arrayrhsfenderListresult.length == 0
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
                        filePicker("Rfi", true);
                      },
                      child:
                          Icon(Icons.camera_alt_outlined, color: Colors.white),
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
                            color: Clr().white,
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
              initialValue: arrayrhsApillarListresult.length == 0
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
              buttonIcon: Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              onConfirm: (results) {
                setState(() {
                  arrayrhsApillarListresult = results;
                  ////FocusManager.instance.primaryFocus!.unfocus();
                });
              },
            ),
            extrhsphoto == '1'
                ? arrayrhsApillarListresult.length == 0
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
                        filePicker("Rai", true);
                      },
                      child:
                          Icon(Icons.camera_alt_outlined, color: Colors.white),
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
                            color: Clr().white,
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
              initialValue: arrayrhsBpillarListresult.length == 0
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
              buttonIcon: Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              onConfirm: (results) {
                setState(() {
                  arrayrhsBpillarListresult = results;
                  ////FocusManager.instance.primaryFocus!.unfocus();
                });
              },
            ),
            extrhsphoto == '1'
                ? arrayrhsBpillarListresult.length == 0
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
                        filePicker("Rbpi", true);
                      },
                      child:
                          Icon(Icons.camera_alt_outlined, color: Colors.white),
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
                            color: Clr().white,
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
              initialValue: arrayfrontrhswindowListresult.length == 0
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
              buttonIcon: Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              onConfirm: (results) {
                setState(() {
                  arrayfrontrhswindowListresult = results;
                  ////FocusManager.instance.primaryFocus!.unfocus();
                });
              },
            ),
            extrhsphoto == '1'
                ? arrayfrontrhswindowListresult.length == 0
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
              initialValue: arrayfrontrhsdoorListresult.length == 0
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
              buttonIcon: Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              onConfirm: (results) {
                setState(() {
                  arrayfrontrhsdoorListresult = results;
                  ////FocusManager.instance.primaryFocus!.unfocus();
                });
              },
            ),
            extrhsphoto == '1'
                ? arrayfrontrhsdoorListresult.length == 0
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
                        filePicker("Rdoi", true);
                      },
                      child:
                          Icon(Icons.camera_alt_outlined, color: Colors.white),
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
                            color: Clr().white,
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
              initialValue: arrayrearrhsdoorListresult.length == 0
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
              buttonIcon: Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              onConfirm: (results) {
                setState(() {
                  arrayrearrhsdoorListresult = results;
                  ////FocusManager.instance.primaryFocus!.unfocus();
                });
              },
            ),
            extrhsphoto == '1'
                ? arrayrearrhsdoorListresult.length == 0
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
                        filePicker("Rdi", true);
                      },
                      child:
                          Icon(Icons.camera_alt_outlined, color: Colors.white),
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
                            color: Clr().white,
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
              initialValue: arrayrearrhswindowListresult.length == 0
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
              buttonIcon: Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              onConfirm: (results) {
                setState(() {
                  arrayrearrhswindowListresult = results;
                  ////FocusManager.instance.primaryFocus!.unfocus();
                });
              },
            ),
            extrhsphoto == '1'
                ? arrayrearrhswindowListresult.length == 0
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
              initialValue: arrayrhsrunningboardListresult.length == 0
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
              buttonIcon: Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              onConfirm: (results) {
                setState(() {
                  arrayrhsrunningboardListresult = results;
                  ////FocusManager.instance.primaryFocus!.unfocus();
                });
              },
            ),
            extrhsphoto == '1'
                ? arrayrhsrunningboardListresult.length == 0
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
                        filePicker("Rrbi", true);
                      },
                      child:
                          Icon(Icons.camera_alt_outlined, color: Colors.white),
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
                      sRrunniboardImg != null
                          ? 'Image Selected'
                          : 'Upload Photo',
                      style: Sty().mediumText.copyWith(
                            color: Clr().white,
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
              initialValue: arrayrhsCpillarListresult.length == 0
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
              buttonIcon: Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              onConfirm: (results) {
                setState(() {
                  arrayrhsCpillarListresult = results;
                  ////FocusManager.instance.primaryFocus!.unfocus();
                });
              },
            ),
            extrhsphoto == '1'
                ? arrayrhsCpillarListresult.length == 0
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
                        filePicker("Rcpi", true);
                      },
                      child:
                          Icon(Icons.camera_alt_outlined, color: Colors.white),
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
                            color: Clr().white,
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
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arrayrearrhspercentList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (v) {
                  // STM().redirect2page(ctx, Home());
                  setState(() {
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
            MultiSelectDialogField(
              dialogHeight: 350,
              dialogWidth: 450,
              initialValue: arrayrhsquaterpannelListresult.length == 0
                  ? null
                  : arrayrhsquaterpannelListresult,
              items: arrayrhsquaterpannelList
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
              buttonIcon: Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              onConfirm: (results) {
                arrayrhsquaterpannelListresult = results;
              },
            ),
            extrhsphoto == '1'
                ? arrayrhsquaterpannelListresult.length == 0
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
                        filePicker("Rqpi", true);
                      },
                      child:
                          Icon(Icons.camera_alt_outlined, color: Colors.white),
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
                            color: Clr().white,
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
                      });
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
                      setState(() {
                        extrhsphoto = '1';
                      });
                      if (arrayrhssideListresult.length == 0) {
                        return null;
                      }
                      if (sRsideAppImg == null) {
                        return null;
                      }
                      if (arrayrhsfenderListresult.length == 0) {
                        return null;
                      }
                      if (sRfenderImg == null) {
                        return null;
                      }
                      if (arrayrhsApillarListresult.length == 0) {
                        return null;
                      }
                      if (sRApillerImg == null) {
                        return null;
                      }
                      if (arrayrhsBpillarListresult.length == 0) {
                        return null;
                      }
                      if (sRBPillerImg == null) {
                        return null;
                      }
                      if (arrayfrontrhswindowListresult.length == 0) {
                        return null;
                      }
                      if (arrayfrontrhsdoorListresult.length == 0) {
                        return null;
                      }
                      if (sRDoorImg == null) {
                        return null;
                      }
                      if (arrayrearrhsdoorListresult.length == 0) {
                        return null;
                      }
                      if (sRrearDoorImg == null) {
                        return null;
                      }
                      if (arrayrearrhswindowListresult.length == 0) {
                        return null;
                      }
                      if (arrayrhsrunningboardListresult.length == 0) {
                        return null;
                      }
                      if (sRrunniboardImg == null) {
                        return null;
                      }
                      if (arrayrhsCpillarListresult.length == 0) {
                        return null;
                      }
                      if (sRCPillerImg == null) {
                        return null;
                      }
                      if (arrayrhsquaterpannelListresult.length == 0) {
                        return null;
                      }
                      if (sRquaterpannelImg == null) {
                        return null;
                      }
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          pageNumber++;
                        });
                      }
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

  //exteriorbackside
  Widget exteriorbackside() {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text('Dicky Door',
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
            SizedBox(
              height: 12,
            ),
            MultiSelectDialogField(
              dialogHeight: 350,
              dialogWidth: 450,
              initialValue: arraybackdickydoorListresult.length == 0
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
              buttonIcon: Icon(
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
                ? arraybackdickydoorListresult.length == 0
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
                        filePicker("Ddi", true);
                      },
                      child:
                          Icon(Icons.camera_alt_outlined, color: Colors.white),
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
                            color: Clr().white,
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
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
            SizedBox(
              height: 12,
            ),
            MultiSelectDialogField(
              dialogHeight: 350,
              dialogWidth: 450,
              initialValue: arraybackrearglassListresult.length == 0
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
              buttonIcon: Icon(
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
                ? arraybackrearglassListresult.length == 0
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
                        filePicker("Rgi", true);
                      },
                      child:
                          Icon(Icons.camera_alt_outlined, color: Colors.white),
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
                            color: Clr().white,
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
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
            SizedBox(
              height: 12,
            ),
            MultiSelectDialogField(
              dialogHeight: 350,
              dialogWidth: 450,
              initialValue: arraybackdickyfloorconditionListresult.length == 0
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
              buttonIcon: Icon(
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
                ? arraybackdickyfloorconditionListresult.length == 0
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
                        filePicker("bdfi", true);
                      },
                      child:
                          Icon(Icons.camera_alt_outlined, color: Colors.white),
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
                            color: Clr().white,
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
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
            SizedBox(
              height: 12,
            ),
            DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                hint: Text(sparwheetyrpercvalue ??
                    "Select Spare Wheel Tyre percentage"),
                value: sparwheetyrpercvalue,
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arraybacksquarewheeltyrepercentList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
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
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
            SizedBox(
              height: 12,
            ),
            MultiSelectDialogField(
              dialogHeight: 350,
              dialogWidth: 450,
              initialValue: arraybackrearbumperListresult.length == 0
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
              buttonIcon: Icon(
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
                ? arraybackrearbumperListresult.length == 0
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
                        filePicker("rbi", true);
                      },
                      child:
                          Icon(Icons.camera_alt_outlined, color: Colors.white),
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
                            color: Clr().white,
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
                      });
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
                      setState(() {
                        extbacphoto = '1';
                      });
                      if (arraybackdickydoorListresult.length == 0) {
                        return null;
                      }
                      if (sDickydoorImg == null) {
                        return null;
                      }
                      if (arraybackrearglassListresult.length == 0) {
                        return null;
                      }
                      if (sRgImg == null) {
                        return null;
                      }
                      if (arraybackdickyfloorconditionListresult.length == 0) {
                        return null;
                      }
                      if (sbackDickyfloorImg == null) {
                        return null;
                      }
                      if (arraybackrearbumperListresult.length == 0) {
                        return null;
                      }
                      if (sRearBumImg == null) {
                        return null;
                      }
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          pageNumber++;
                        });
                      }
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

  //exteriorlhs
  Widget exteriorlhslayout() {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
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
              initialValue: arraylhssideListresult.length == 0
                  ? null
                  : arraylhssideListresult,
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
              buttonIcon: Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              onConfirm: (results) {
                setState(() {
                  arraylhssideListresult = results;
                  ////FocusManager.instance.primaryFocus!.unfocus();
                });
              },
            ),
            extlhsphoto == '1'
                ? arraylhssideListresult.length == 0
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
                        filePicker("lsa", true);
                      },
                      child:
                          Icon(Icons.camera_alt_outlined, color: Colors.white),
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
                            color: Clr().white,
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
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arrayfrontlhspercentList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (v) {
                  // STM().redirect2page(ctx, Home());
                  setState(() {
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
              initialValue: arraylhsfenderListresult.length == 0
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
              buttonIcon: Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              onConfirm: (results) {
                setState(() {
                  arraylhsfenderListresult = results;
                  ////FocusManager.instance.primaryFocus!.unfocus();
                });
              },
            ),
            extlhsphoto == '1'
                ? arraylhsfenderListresult.length == 0
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
                        filePicker("lfi", true);
                      },
                      child:
                          Icon(Icons.camera_alt_outlined, color: Colors.white),
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
                            color: Clr().white,
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
              initialValue: arraylhsApillarListresult.length == 0
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
              buttonIcon: Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              onConfirm: (results) {
                setState(() {
                  arraylhsApillarListresult = results;
                  ////FocusManager.instance.primaryFocus!.unfocus();
                });
              },
            ),
            extlhsphoto == '1'
                ? arraylhsApillarListresult.length == 0
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
                        filePicker("lapi", true);
                      },
                      child:
                          Icon(Icons.camera_alt_outlined, color: Colors.white),
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
                            color: Clr().white,
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
              initialValue: arraylhsBpillarListresult.length == 0
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
              buttonIcon: Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              onConfirm: (results) {
                setState(() {
                  arraylhsBpillarListresult = results;
                  ////FocusManager.instance.primaryFocus!.unfocus();
                });
              },
            ),
            extlhsphoto == '1'
                ? arraylhsBpillarListresult.length == 0
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
                        filePicker("lbpi", true);
                      },
                      child:
                          Icon(Icons.camera_alt_outlined, color: Colors.white),
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
                            color: Clr().white,
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
              initialValue: arrayfrontlhswindowListresult.length == 0
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
              buttonIcon: Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              onConfirm: (results) {
                setState(() {
                  arrayfrontlhswindowListresult = results;
                  ////FocusManager.instance.primaryFocus!.unfocus();
                });
              },
            ),
            extlhsphoto == '1'
                ? arrayfrontlhswindowListresult.length == 0
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
              initialValue: arrayfrontlhsdoorListresult.length == 0
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
              buttonIcon: Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              onConfirm: (results) {
                setState(() {
                  arrayfrontlhsdoorListresult = results;
                  ////FocusManager.instance.primaryFocus!.unfocus();
                });
              },
            ),
            extlhsphoto == '1'
                ? arrayfrontlhsdoorListresult.length == 0
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
                        filePicker("lfdi", true);
                      },
                      child:
                          Icon(Icons.camera_alt_outlined, color: Colors.white),
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
                            color: Clr().white,
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
              initialValue: arrayrearlhsdoorListresult.length == 0
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
              buttonIcon: Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              onConfirm: (results) {
                setState(() {
                  arrayrearlhsdoorListresult = results;
                  ////FocusManager.instance.primaryFocus!.unfocus();
                });
              },
            ),
            extlhsphoto == '1'
                ? arrayrearlhsdoorListresult.length == 0
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
                        filePicker("lrdi", true);
                      },
                      child:
                          Icon(Icons.camera_alt_outlined, color: Colors.white),
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
                            color: Clr().white,
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
              initialValue: arrayrearlhswindowListresult.length == 0
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
              buttonIcon: Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              onConfirm: (results) {
                setState(() {
                  arrayrearlhswindowListresult = results;
                  ////FocusManager.instance.primaryFocus!.unfocus();
                });
              },
            ),
            extlhsphoto == '1'
                ? arrayrearlhswindowListresult.length == 0
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
              initialValue: arraylhsrunningboardListresult.length == 0
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
              buttonIcon: Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              onConfirm: (results) {
                setState(() {
                  arraylhsrunningboardListresult = results;
                  ////FocusManager.instance.primaryFocus!.unfocus();
                });
              },
            ),
            extlhsphoto == '1'
                ? arraylhsrunningboardListresult.length == 0
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
                        filePicker("lrbi", true);
                      },
                      child:
                          Icon(Icons.camera_alt_outlined, color: Colors.white),
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
                            color: Clr().white,
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
              initialValue: arraylhsCpillarListresult.length == 0
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
              buttonIcon: Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              onConfirm: (results) {
                setState(() {
                  arraylhsCpillarListresult = results;
                  ////FocusManager.instance.primaryFocus!.unfocus();
                });
              },
            ),
            extlhsphoto == '1'
                ? arraylhsCpillarListresult.length == 0
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
                        filePicker("lcpi", true);
                      },
                      child:
                          Icon(Icons.camera_alt_outlined, color: Colors.white),
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
                            color: Clr().white,
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
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arrayrearlhspercentList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (v) {
                  // STM().redirect2page(ctx, Home());
                  setState(() {
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
              initialValue: arraylhsquaterpannelListresult.length == 0
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
              buttonIcon: Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              onConfirm: (results) {
                setState(() {
                  arraylhsquaterpannelListresult = results;
                  ////FocusManager.instance.primaryFocus!.unfocus();
                });
              },
            ),
            extlhsphoto == '1'
                ? arraylhsquaterpannelListresult.length == 0
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
                        filePicker("lqpi", true);
                      },
                      child:
                          Icon(Icons.camera_alt_outlined, color: Colors.white),
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
                            color: Clr().white,
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
                      });
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
                      setState(() {
                        extlhsphoto = '1';
                      });
                      if (arraylhssideListresult.length == 0) {
                        return null;
                      }
                      if (sLsaImg == null) {
                        return null;
                      }
                      if (arraylhsfenderListresult.length == 0) {
                        return null;
                      }
                      if (sLfImg == null) {
                        return null;
                      }
                      if (arraylhsApillarListresult.length == 0) {
                        return null;
                      }
                      if (sLapImg == null) {
                        return null;
                      }
                      if (arraylhsBpillarListresult.length == 0) {
                        return null;
                      }
                      if (sLbpImg == null) {
                        return null;
                      }
                      if (arrayfrontlhswindowListresult.length == 0) {
                        return null;
                      }
                      if (arrayfrontlhsdoorListresult.length == 0) {
                        return null;
                      }
                      if (sLfdImg == null) {
                        return null;
                      }
                      if (arrayrearlhsdoorListresult.length == 0) {
                        return null;
                      }
                      if (sLrdImg == null) {
                        return null;
                      }
                      if (arrayrearlhswindowListresult.length == 0) {
                        return null;
                      }
                      if (arraylhsrunningboardListresult.length == 0) {
                        return null;
                      }
                      if (sLrbImg == null) {
                        return null;
                      }
                      if (arraylhsCpillarListresult.length == 0) {
                        return null;
                      }
                      if (sLcpImg == null) {
                        return null;
                      }
                      if (arraylhsquaterpannelListresult.length == 0) {
                        return null;
                      }
                      if (sLqpImg == null) {
                        return null;
                      }
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          pageNumber++;
                        });
                      }
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

  //interior
  Widget interiorlayout() {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
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
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arrayairbagList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (v) {
                  // STM().redirect2page(ctx, Home());
                  setState(() {
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
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arrayABSList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (v) {
                  // STM().redirect2page(ctx, Home());
                  setState(() {
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
              initialValue: arraymusicsystemListresult.length == 0
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
              buttonIcon: Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              onConfirm: (results) {
                setState(() {
                  arraymusicsystemListresult = results;
                  ////FocusManager.instance.primaryFocus!.unfocus();
                });
              },
            ),

            inetrphoto == '1'
                ? arraymusicsystemListresult.length == 0
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
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arrayspeakerList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (v) {
                  // STM().redirect2page(ctx, Home());
                  setState(() {
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
                hint: Text(steeringwheelcondivalue ??
                    'Select steering wheel condition'),
                value: steeringwheelcondivalue,
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arraysteeringwheelconditionList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (v) {
                  // STM().redirect2page(ctx, Home());
                  setState(() {
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
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arraysteeringwheelautocontrolList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (v) {
                  // STM().redirect2page(ctx, Home());
                  setState(() {
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
              initialValue: arrayautoacconditionListresult.length == 0
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
              buttonIcon: Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              onConfirm: (results) {
                setState(() {
                  arrayautoacconditionListresult = results;
                  ////FocusManager.instance.primaryFocus!.unfocus();
                });
              },
            ),
            inetrphoto == '1'
                ? arrayautoacconditionListresult.length == 0
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
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arrayacflowList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (v) {
                  // STM().redirect2page(ctx, Home());
                  setState(() {
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
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arrayacblowerList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (v) {
                  // STM().redirect2page(ctx, Home());
                  setState(() {
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
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arrayacdirectionList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (v) {
                  // STM().redirect2page(ctx, Home());
                  setState(() {
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
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                style: TextStyle(color: Color(0xff000000)),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                items: arrayacheaterList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (v) {
                  // STM().redirect2page(ctx, Home());
                  setState(() {
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
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arrayglowboxList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (v) {
                  // STM().redirect2page(ctx, Home());
                  setState(() {
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
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arraygearleverList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (v) {
                  // STM().redirect2page(ctx, Home());
                  setState(() {
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
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arraypowerwindowList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (v) {
                  // STM().redirect2page(ctx, Home());
                  setState(() {
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
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arrayrhssideseatList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (v) {
                  // STM().redirect2page(ctx, Home());
                  setState(() {
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
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arraylhssideseatList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (v) {
                  // STM().redirect2page(ctx, Home());
                  setState(() {
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
                child: Text('Rear seat Condition ',
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
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                style: TextStyle(color: Color(0xff000000)),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                items: arrayrearseatList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (v) {
                  // STM().redirect2page(ctx, Home());
                  setState(() {
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
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arrayallseatcoverList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (v) {
                  // STM().redirect2page(ctx, Home());
                  setState(() {
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
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arrayallmatsList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (v) {
                  // STM().redirect2page(ctx, Home());
                  setState(() {
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
                      });
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
                      setState(() {
                        inetrphoto = '1';
                      });
                      if (arraymusicsystemListresult.length == 0) {
                        return null;
                      }
                      if (arrayautoacconditionListresult.length == 0) {
                        return null;
                      }
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          pageNumber++;
                        });
                      }
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

  //testdrive
  Widget testdrivelayout() {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text(' Front Suspension Noise',
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
            SizedBox(
              height: 12,
            ),
            DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                hint: Text(
                    frosuspensnoisevalue ?? 'Select front suspension noise'),
                value: frosuspensnoisevalue,
                isExpanded: true,
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arraytestfrontsuspesionList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
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
                child: Text('Axle Noise ',
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
            SizedBox(
              height: 12,
            ),
            DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                hint: Text(axlenoisevalue ?? 'Select axle noise'),
                value: axlenoisevalue,
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arraytestaxlenoiseList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
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
            SizedBox(
              height: 20,
            ),

            Align(
                alignment: Alignment.centerLeft,
                child: Text('Rear suspension Noise ',
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
            SizedBox(
              height: 12,
            ),
            DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                hint: Text(
                    rearsuspennoisevalue ?? 'Select rear suspension noise'),
                value: rearsuspennoisevalue,
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arraytestrearsuspesionList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (v) {
                  // STM().redirect2page(ctx, Home());
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
                child: Text('Clutch Condition ',
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
            SizedBox(
              height: 12,
            ),
            MultiSelectDialogField(
              dialogHeight: 350,
              dialogWidth: 450,
              initialValue: arraytestclutchconditionListresult.length == 0
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
              buttonIcon: Icon(
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
                ? arraytestclutchconditionListresult.length == 0
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
            //       hint: Text(clutchcondivalue ?? 'Select clutch condition'),
            //       value: clutchcondivalue,
            //       isExpanded: true,
            //       icon: Icon(
            //         Icons.keyboard_arrow_down,
            //         size: 28,
            //       ),
            //       style: TextStyle(color: Color(0xff000000)),
            //       items: arraytestclutchconditionList.map((String string) {
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
            //           clutchcondivalue = v!;
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
                child: Text('Automatic Gear Box',
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
            SizedBox(
              height: 12,
            ),
            MultiSelectDialogField(
              dialogHeight: 350,
              dialogWidth: 450,
              initialValue: arraytestautomaticgearListresult.length == 0
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
              buttonIcon: Icon(
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
                ? arraytestautomaticgearListresult.length == 0
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
            //       hint: Text(automatigearboxvalue ?? 'Select automatic gear box'),
            //       value: automatigearboxvalue,
            //       isExpanded: true,
            //       icon: Icon(
            //         Icons.keyboard_arrow_down,
            //         size: 28,
            //       ),
            //       style: TextStyle(color: Color(0xff000000)),
            //       items: arraytestautomaticgearList.map((String string) {
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
            //           automatigearboxvalue = v!;
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
                child: Text('Gear Box',
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
            SizedBox(
              height: 12,
            ),
            DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                hint: Text(gearboxvlaue ?? 'Select gear box'),
                value: gearboxvlaue,
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arraytestgearboxList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
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
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
            SizedBox(
              height: 12,
            ),
            DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                hint: Text(gearboxnoisevalue ?? 'Select gear box noise'),
                value: gearboxnoisevalue,
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arraytestgearboxnoiseList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
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
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
            SizedBox(
              height: 12,
            ),
            DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                hint: Text(gearshiftingvalue ?? 'Select gear shifting'),
                value: gearshiftingvalue,
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arraytestgearboxshiftingList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
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
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
            SizedBox(
              height: 12,
            ),
            DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                hint: Text(wavalue ?? 'Select Wheel Alignment'),
                value: wavalue,
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arrayWaList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
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
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
            SizedBox(
              height: 12,
            ),
            DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                hint: Text(steerinnoisevalue ?? 'Select steering noise'),
                value: steerinnoisevalue,
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arrayteststeeringnoiseList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
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
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
            SizedBox(
              height: 12,
            ),
            DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                hint: Text(
                    steericolumnoisevalue ?? 'Select steering column noise'),
                value: steericolumnoisevalue,
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arrayteststeeringcolumnnoiseList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
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
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
            SizedBox(
              height: 12,
            ),
            DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                hint: Text(speedometknobvalue ?? 'Select spedometer knob'),
                value: speedometknobvalue,
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arraytestspeedometerknobList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
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
                    style:
                        Sty().largeText.copyWith(fontWeight: FontWeight.w400))),
            SizedBox(
              height: 12,
            ),
            DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                hint: Text(odometerreadinvalue ?? 'Select odometer reading'),
                value: odometerreadinvalue,
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arraytestodometerreadingList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
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
                      });
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
                      setState(() {
                        testdriphoto = '1';
                      });
                      if (arraytestclutchconditionListresult.length == 0) {
                        return null;
                      }
                      if (arraytestautomaticgearListresult.length == 0) {
                        return null;
                      }
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          pageNumber++;
                        });
                      }
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

  //engine compartment
  Widget enginecompartmentlayout() {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
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
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arrayenginetappetnoiseList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (v) {
                  // STM().redirect2page(ctx, Home());
                  setState(() {
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
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arrayengineoverheatingList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (v) {
                  // STM().redirect2page(ctx, Home());
                  setState(() {
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
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arrayengineoilsludgeList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (v) {
                  // STM().redirect2page(ctx, Home());
                  setState(() {
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
            MultiSelectDialogField(
              dialogHeight: 350,
              dialogWidth: 450,
              initialValue: arrayengineoilconditionListresult.length == 0
                  ? null
                  : arrayengineoilconditionListresult,
              items: arrayengineoilconditionList
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
              buttonIcon: Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              onConfirm: (results) {
                setState(() {
                  arrayengineoilconditionListresult = results;
                  ////FocusManager.instance.primaryFocus!.unfocus();
                });
              },
            ),
            engiphoto == '1'
                ? arrayengineoilconditionListresult.length == 0
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
            MultiSelectDialogField(
              dialogHeight: 350,
              dialogWidth: 450,
              initialValue: arrayenginecoolentListresult.length == 0
                  ? null
                  : arrayenginecoolentListresult,
              items: arrayenginecoolentList
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
                "Select coolent",
                style: Sty().mediumText.copyWith(
                      color: Clr().lightGrey,
                    ),
              ),
              buttonIcon: Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              onConfirm: (results) {
                setState(() {
                  arrayenginecoolentListresult = results;
                  ////FocusManager.instance.primaryFocus!.unfocus();
                });
              },
            ),
            engiphoto == '1'
                ? arrayenginecoolentListresult.length == 0
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
            //       hint: Text(coolentvalue ?? 'Select coolent'),
            //       value: coolentvalue,
            //       isExpanded: true,
            //       icon: Icon(
            //         Icons.keyboard_arrow_down,
            //         size: 28,
            //       ),
            //       style: TextStyle(color: Color(0xff000000)),
            //       items: arrayenginecoolentList.map((String string) {
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
            //           coolentvalue = v!;
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
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arrayenginetimeingsideList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (v) {
                  // STM().redirect2page(ctx, Home());
                  setState(() {
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
                hint:
                    Text(alternatecondivalue ?? 'Select alternater condition'),
                value: alternatecondivalue,
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arrayenginealternatornoiseList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (v) {
                  // STM().redirect2page(ctx, Home());
                  setState(() {
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
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arrayenginebatteryList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (v) {
                  // STM().redirect2page(ctx, Home());
                  setState(() {
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
              initialValue: arrayengineaccompressorListresult.length == 0
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
              buttonIcon: Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              onConfirm: (results) {
                setState(() {
                  arrayengineaccompressorListresult = results;
                  ////FocusManager.instance.primaryFocus!.unfocus();
                });
              },
            ),
            engiphoto == '1'
                ? arrayengineaccompressorListresult.length == 0
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
            //       hint: Text(accompressorvalue ?? 'Select ac compressor'),
            //       value: accompressorvalue,
            //       isExpanded: true,
            //       icon: Icon(
            //         Icons.keyboard_arrow_down,
            //         size: 28,
            //       ),
            //       style: TextStyle(color: Color(0xff000000)),
            //       items: arrayengineaccompressorList.map((String string) {
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
            //           accompressorvalue = v!;
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
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arrayenginestartermotorList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (v) {
                  // STM().redirect2page(ctx, Home());
                  setState(() {
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
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                ),
                validator: (value) => value == null ? 'field required' : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
                ),
                style: TextStyle(color: Color(0xff000000)),
                items: arrayengineairfilterList.map((String string) {
                  return DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (v) {
                  // STM().redirect2page(ctx, Home());
                  setState(() {
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
              },
              decoration: InputDecoration(
                  contentPadding:
                      Sty().TextFormFieldOutlineStyle.contentPadding,
                  enabledBorder: Sty().TextFormFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().TextFormFieldOutlineStyle.focusedBorder,
                  focusedErrorBorder:
                      Sty().TextFormFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().TextFormFieldOutlineStyle.errorBorder,
                  disabledBorder:
                      Sty().TextFormFieldOutlineStyle.disabledBorder,
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
                      });
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
                      setState(() {
                        engiphoto = '1';
                      });
                      if (arrayengineoilconditionListresult.length == 0) {
                        return null;
                      }
                      if (arrayenginecoolentListresult.length == 0) {
                        return null;
                      }
                      if (arrayengineaccompressorListresult.length == 0) {
                        return null;
                      }
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          pageNumber++;
                        });
                      }
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

  // specialfeaturesphotoandname
  Widget specialfeaturephotonamelayout() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: comment1ctrl,
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
            // SizedBox(
            //   width: 8,
            // ),

            // SizedBox(
            //   width: 8,
            // ),
            // Container(
            //   padding: EdgeInsets.symmetric(
            //       vertical: Dim().d16, horizontal: Dim().d20),
            //   decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //       colors: [Color(0xFF2E135D), Color(0xFFB81736)],
            //     ),
            //     borderRadius: BorderRadius.circular(
            //       Dim().d4,
            //     ),
            //   ),
            //   child: Row(
            //     children: [
            //       InkWell(
            //         onTap: () {
            //           filePicker("sp1", true);
            //         },
            //         child: Icon(Icons.camera_alt_outlined,
            //             color: Colors.white, size: 18),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("sp1", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: comment2ctrl,
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
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("sp2", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: comment3ctrl,
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
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("sp3", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: comment4ctrl,
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
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("sp4", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: comment5ctrl,
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
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("sp5", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: comment6ctrl,
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
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("sp6", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: comment7ctrl,
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
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("sp7", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: comment8ctrl,
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
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("sp8", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: comment9ctrl,
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
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("sp9", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: comment10ctrl,
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
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("sp10", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: comment11ctrl,
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
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("sp11", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: comment12ctrl,
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
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("sp12", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: comment13ctrl,
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
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("sp13", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: comment14ctrl,
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
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("sp14", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: comment15ctrl,
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
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("sp15", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
                  setState(() {
                    pageNumber--;
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
                  setState(() {
                    pageNumber++;
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
  }

  //anydamagephotoandname
  Widget anydamagephotolayout() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: anydamage1ctrl,
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
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("an1", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: anydamage2ctrl,
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
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("an2", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: anydamage3ctrl,
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
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("an3", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: anydamage4ctrl,
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
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("an4", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: anydamage5ctrl,
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
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("an5", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: anydamage6ctrl,
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
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("an6", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: anydamage7ctrl,
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
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("an7", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: anydamage8ctrl,
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
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("an8", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: anydamage9ctrl,
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
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("an9", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: anydamage10ctrl,
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
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("an10", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: anydamage11ctrl,
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
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("an11", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: anydamage12ctrl,
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
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("an12", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: anydamage13ctrl,
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
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("an13", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: anydamage14ctrl,
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
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("an14", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: anydamage15ctrl,
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
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("an15", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: anydamage16ctrl,
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
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("an16", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: anydamage17ctrl,
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
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("an17", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: anydamage18ctrl,
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
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("an18", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: anydamage19ctrl,
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
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("an19", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: anydamage20ctrl,
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
          ],
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: Dim().d16, horizontal: Dim().d20),
          decoration: BoxDecoration(
            gradient:Sty().linearGradient,
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
                    setState(() {
                      filePicker("an20", true);
                    });
                  },
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: anydamage21ctrl,
                keyboardType: TextInputType.multiline,
                maxLines: null,
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
                  setState(() {
                    addData();
                  });
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
            expimg = base64Encode(image);
            break;
          case "rc1":
            Rc1photo = base64Encode(image);
            break;
          case "rc2":
            Rc2photo = base64Encode(image);
            break;
          case "rcinsurance":
            Rcinsurancephoto = base64Encode(image);
            break;
          case "chassisphoto":
            chassisphoto = base64Encode(image);
            break;
          case "enginephoto":
            enginephoto = base64Encode(image);
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
            Rcexpiryctrl = TextEditingController(text: date);
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
      "id": widget.Orderid,
    });
    if (!mounted) return;
    var result = await STM()
        .post(context, Str().processing, "edit_vehicle_details", body);
    setState(() {
      var form1 = result['customer_details'];
      CustomerDetailNameCtrl =
          TextEditingController(text: form1['purchase_cust_name']);
      CustomerDetailNumberCtrl =
          TextEditingController(text: form1['purchase_cust_no']);
      locationCtrl = TextEditingController(text: form1['purchase_location']);
      sellCustomerNameCtrl =
          TextEditingController(text: form1['sell_cust_name']);
      sellCustomerNumberCtrl =
          TextEditingController(text: form1['sell_cust_no']);
      location2Ctrl = TextEditingController(text: form1['sell_location']);
      var form2 = result['rc_details'];
      rcDropDownSelected = form2['rc'];
      rcTypeDropDownSelected = form2['rc_type'];
      zeroDepInsuranceDropDownSelected = form2['zero_dep_insuarance'];
      Rcexpiryctrl = TextEditingController(text: form2['expiry_date']);
      var form3 = result['chassis_details'];
      chassisnumberctrl = TextEditingController(text: form3['chasis_no']);
      chassisenginenoctrl = TextEditingController(text: form3['engine_no']);
      var form4 = result['vehicle_details'];
      arraystatevalue = form4['vehicle_state'];
      vehiclenumberctrl = TextEditingController(text: form4['vehicle_no']);
      vehiclevarientctrl = TextEditingController(text: form4['veriant']);
      mfgctrl = TextEditingController(text: form4['mfg_year']);
      arrayvehiclemakevalue = form4['vehicle_make'];
      arrayvehiclemodelvalue = form4['vehicle_model'];
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
      arrayrhsquaterpannelListresult = form6['rhs_quater_panel'];
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
      arrayengineoilconditionListresult = form11['engine_oil_condition'];
      arrayenginecoolentListresult = form11['coolent'];
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

  //Api
  addData() async {
    //Input
    SharedPreferences sp = await SharedPreferences.getInstance();
    FormData body = FormData.fromMap({
      "order_id": widget.Orderid,
      //Form 1
      "purchase_cust_name": CustomerDetailNameCtrl.text,
      "purchase_cust_no": CustomerDetailNumberCtrl.text,
      "purchase_location": locationCtrl.text,
      "sell_cust_name": sellCustomerNameCtrl.text,
      "sell_cust_no": sellCustomerNumberCtrl.text,
      "sell_location": location2Ctrl.text,

      // Form 2
      "rc": rcDropDownSelected,
      "rc_photo": Rc1photo,
      "rc_type": rcTypeDropDownSelected,
      "rc_type_photo": Rc2photo,
      "zero_dep_insuarance": zeroDepInsuranceDropDownSelected,
      "insuarance_photo": Rcinsurancephoto,
      "expiry_date": Rcexpiryctrl.text,
      "exiry_photo": expimg,

      // Form 3
      "chasis_no": chassisnumberctrl.text,
      "engine_no": chassisenginenoctrl.text,
      "chasis_photo": chassisphoto,
      "engine_photo": enginephoto,

      // Form 4
      "vehicle_state": arraystatevalue,
      "vehicle_no": vehiclenumberctrl.text,
      "vehicle_make": arrayvehiclemakevalue,
      "vehicle_model": arrayvehiclemodelvalue,
      "vehicle_color": arrayvehiclecolorvalue,
      "veriant": vehiclevarientctrl.text,
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
      "hypothecation": hypo,
      "bank_name": banknameCtrl.text,

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
      "rhs_quater_panel": arrayrhsquaterpannelListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
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
      "engine_oil_condition": arrayengineoilconditionListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      "coolent": arrayenginecoolentListresult
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
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
    if (!mounted) return;
    var result =
        await STM().post(ctx, Str().processing, "update_vehicle_details", body);
    var error = result['error'];
    var message = result['message'];
    if (!error) {
      STM().displayToast("Success");
      print(enginevideoctrl.text);
      successAlert(ctx, message, MyOrder());
    } else {
      STM().errorDialog(ctx, message);
    }
  }
}
