class Data {
  List<dynamic> summaryList = [
    {"name": "Customer Details", "page": 1},
    {"name": "RC & Insurance Details", "page": 2},
    {"name": "Chassis Details", "page": 3},
    {"name": "Vehicle Details", "page": 4},
    {"name": "Upload Photos", "page": 5},
    {"name": "Exterior Front Side", "page": 6},
    {"name": "Exterior RHS Side", "page": 7},
    {"name": "Exterior Back side", "page": 8},
    {"name": "Exterior LHS Side", "page": 9},
    {"name": "Interior", "page": 10},
    {"name": "Test Drive", "page": 11},
    {"name": "Engine Compartment", "page": 12},
    {"name": "Special features Photo & Name", "page": 13},
    {"name": "Any Damages photo & Name", "page": 14}
  ];

  List<String> rcList = [
    "Orginal",
    "Duplicate",
    "Migrated RC",
  ];

  List<String> rcTypeList = ["Private", "Un-registered", "Commercial"];

  List<String> insuranceTypeList = [
    "Zero Dep Insurance",
    "Comprehensive Insurance.",
    "Third Party Insurance",
    "N/A",
  ];

  List<String> vehicleStateList = [
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

  List<dynamic> vehicleMakeList = [
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
  ];
}
