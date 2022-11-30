import 'dart:convert';

class BransServices {
  List<Brans> get branslar {
    List branslar = jsonDecode(_bransData) as List;
    return branslar.map((e) => Brans.fromJson(e)).toList();
  }

  List<Brans> bransAra(String query) {
    return branslar
        .where((aranan) =>
            aranan.brans.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  List<String> mevki(int seriNo) {
    int index = branslar.indexWhere((aranan) => aranan.no == seriNo);
    if (index != -1) {
      return branslar[index].mevki;
    }
    return [];
  }
}

class Brans {
  String brans;
  int no;
  List<String> mevki;

  Brans({required this.brans, required this.no, required this.mevki});

  factory Brans.fromJson(Map<String, dynamic> json) {
    return Brans(
      brans: json["brans"],
      mevki: json['mevki'].cast<String>(),
      no: json["no"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['brans'] = brans;
    data['no'] = no;
    data['mevki'] = mevki;
    return data;
  }
}

class SexServices {
  List<Sex> get sexs {
    List sexs = jsonDecode(_SexData) as List;
    return sexs.map((a) => Sex.fromJson(a)).toList();
  }
}

class Sex {
  String sex;
  int x;

  Sex({required this.sex, required this.x});

  factory Sex.fromJson(Map<String, dynamic> json) {
    return Sex(sex: json["sex"], x: json["x"]);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['sex'] = sex;
    data['x'] = x;
    return data;
  }
}

const String _bransData = """[
  {
    "brans": "Adithada",
    "no": 82,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Aikido",
    "no": 83,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Aikijujutsu",
    "no": 84 ,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Aikijutsu",
    "no": 85,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Alpagut",
    "no": 86,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Amarok",
    "no": 87,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Amerikan-Futbolu",
    "no": 88,
    "mevki": [
      "Farketmez",
      "Safety",
      "Cornerback",
      "Outside-Linebacker",
      "End",
      "Tackle",
      "Middle-Linebacker"
    ]
  },
  {
    "brans": "Amerikan-Kenpo",
    "no": 89,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Arabalar",
    "no": 90,
    "mevki": [
      "Acemi",
      "Drag-Yarışı",
      "Drift",
      "Modifiye",
      "Off-Road",
      "Otokros",
      "Pist",
      "Tırmanma",
      "Karting",
      "Eğitmen"
    ]
  },
  {
    "brans": "Aromatik-Bitkiler",
    "no": 91,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Aslando",
    "no": 92,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Aticilik",
    "no": 93,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Atletizm",
    "no": 94,
    "mevki": [
      "Farketmez",
      "100m-Kosu",
      "200m-Kosu",
      "400m-Kosu",
      "110m-Engelli-Kosu-Erkek",
      "100m-Engelli-Kosu-Kadin",
      "800m-Kosu",
      "1500m-Kosu",
      "1mil-Kosu",
      "3000m-Kosu",
      "5000m-Kosu",
      "10000m-Kosu",
      "3000m-Su-Engeli",
      "Bayrak-Kosulari",
      "42km-Maraton-Kosusu",
      "21km-Yari-Maraton-Kosusu",
      "10km-Maraton",
      "15km-Maraton",
      "Yuruyus",
      "Atlama",
      "Atma",
      "Kros-Dag-Kosusu"
    ]
  },
  {
    "brans": "Ayakta-Kurek-Sorf",
    "no": 95,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Badminton",
    "no": 96,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Baguazhan",
    "no": 97,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Bale",
    "no": 98,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Balikcilik",
    "no": 99,
    "mevki": [
      "Farketmez",
      "Oltali",
      "Agli",
      "Zipkinli",
      "Tekneli"
    ]
  },
  {
    "brans": "Bando",
    "no": 100,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Bartitsu",
    "no": 101,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Basketbol",
    "no": 102,
    "mevki": [
      "Farketmez",
      "ileri",
      "geri"
    ]
  },
  {
    "brans": "Binicilik",
    "no": 103,
    "mevki": [
      "Farketmez",
      "Engel-Atlama",
      "At-Terbiyesi",
      "Engelli-At-Terbiyesi",
      "Atli-Dayaniklilik",
      "Voltij",
      "Atli-Arabacilik",
      "Engelli-Atli-Arabacilik",
      "Dizginleme"
    ]
  },
  {
    "brans": "Bisiklet",
    "no": 104,
    "mevki": [
      "Farketmez",
      "Yol",
      "Pist",
      "Cyclo-Cross",
      "BMX",
      "MTB"
    ]
  },
  {
    "brans": "BodyBuilding",
    "no": 105,
    "mevki": [
      "Farketmez",
      "Kol",
      "Omuz",
      "Sirt",
      "Karin",
      "Bacak",
      "Squat",
      "Kanat",
      "Full"
    ]
  },
  {
    "brans": "BodyBoarding",
    "no": 106,
    "mevki": [
      "Farketemz"
    ]
  },
  {
    "brans": "Boks",
    "no": 107,
    "mevki": [
      "Farketmez",
      "49-51kg",
      "52-54kg",
      "55-57kg",
      "59-62kg",
      "63-67kg",
      "69-73kg",
      "76-80kg",
      "90-Ustu"
    ]
  },
  {
    "brans": "Bowls",
    "no": 108,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Cadir",
    "no": 109,
    "mevki": [
      "Dag-Kamp-Gecelik(Cadirim-Var)",
      "Dag-Kamp-Gecelik(Cadirim-Yok)",
      "Tur-Bircok-Yer(Cadirim-Var)",
      "Tur-Bircok-Yer(Cadirim-Yok)",
      "Sahil(Cadirim-Var)",
      "Sahil(Cadirim-Yok)"
    ]
  },
  {
    "brans": "Dans",
    "no": 110,
    "mevki": [
      "Farketmez",
      "Rock",
      "Broadway",
      "Bale",
      "Capoeira",
      "Ca-Ca",
      "Disko",
      "Foxtrot",
      "Salsa",
      "Breakdance",
      "Halk-Oyunlari",
      "Hip-Hop",
      "Jazz",
      "Jive",
      "Kalipso",
      "Lirik",
      "Mambo",
      "Modern-Dans",
      "Paso-Double",
      "Pop",
      "Punk",
      "Rumba",
      "Salsa",
      "Samba",
      "Swing",
      "Tango",
      "Vals",
      "Zeybek",
      "Zumba",
      "Tap-Dansi",
      "Oryantal",
      "Sirtaki",
      "Roman"
    ]
  },
  {
    "brans": "Dragon-Boat",
    "no": 111,
    "mevki": [
      "Dragon-Bot"
    ]
  },
  {
    "brans": "Eskrim",
    "no": 112,
    "mevki": [
      "Farketmez",
      "Flore",
      "Epe",
      "Kilic"
    ]
  },
  {
    "brans": "Fitness",
    "no": 113,
    "mevki": [
      "Farketmez",
      "Esneklik",
      "Kardiyovaskuler/aerobik",
      "Anaerobik",
      "Dayaniklilik"
    ]
  },
  {
    "brans": "Flyboard",
    "no": 114,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Futbol",
    "no": 115,
    "mevki": [
      "Farketmez",
      "Kaleci",
      "Defans",
      "Orta",
      "Forvet"
    ]
  },
  {
    "brans": "Gures",
    "no": 116,
    "mevki": [
      "Farketmez",
      "30-45kg",
      "45-60kg",
      "60-75kg",
      "75-90kg",
      "90kg-ustu"
    ]
  },
  {
    "brans": "Halter",
    "no": 117,
    "mevki": [
      "Farketmez",
      "Koparma",
      "Silkme"
    ]
  },
  {
    "brans": "Hapkido",
    "no": 118,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Hentbol",
    "no": 119,
    "mevki": [
      "Hentbol"
    ]
  },
  {
    "brans": "Heykel",
    "no": 120,
    "mevki": [
      "Heykeltras"
    ]
  },
  {
    "brans": "Hokey",
    "no": 121,
    "mevki": [
      "Farketmez",
      "Acik-Alan",
      "Salon",
      "Analig",
      "Okul",
      "Plaj"
    ]
  },
  {
    "brans": "Hung-Gar",
    "no": 122,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Hwarangdo",
    "no": 123,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Jet-Ski",
    "no": 124,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Jimnastik",
    "no": 125,
    "mevki": [
      "Farketmez",
      "Artistik",
      "Ritmik",
      "Trampolin",
      "Aerobik",
      "Parkur",
      "Step"
    ]
  },
  {
    "brans": "Jieishudan",
    "no": 126,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Judo",
    "no": 127,
    "mevki": [
      "Farketmez",
      "34-38kg",
      "42-46kg",
      "50-55kg",
      "60-66kg",
      "73-81kg",
      "90kg-Ustu"
    ]
  },
  {
    "brans": "Jui-Jitsu",
    "no": 128,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Kablolu-Kayak",
    "no": 129,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Kano",
    "no": 130,
    "mevki": [
      "Kano"
    ]
  },
  {
    "brans": "Kalaripayat",
    "no": 131,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Kayak",
    "no": 132,
    "mevki": [
      "Farketmez",
      "Kuzey-Kombine",
      "Alp-Disiplini",
      "Free-Ride",
      "Atlama",
      "Free-Style",
      "Skibob",
      "Carving",
      "Skywall",
      "Monoski",
      "Telemark",
      "Boarder-Cross",
      "Half-Pipe",
      "Biatlon",
      "Snowboard",
      "Kayakli-Kosu",
      "Skiboarding"
    ]
  },
  {
    "brans": "Kateda",
    "no": 133,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Kenjutsu",
    "no": 134,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Kick-Boks",
    "no": 135,
    "mevki": [
      "Farketmez",
      "Point-Fighting",
      "Light-Contact",
      "Kick-Light",
      "Full-Contact",
      "Low-Kick",
      "K1-Rules"
    ]
  },
  {
    "brans": "Kiteboat",
    "no": 136,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Krav-Maga",
    "no": 137,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Korfball",
    "no": 138,
    "mevki": [
      "Korfbol"
    ]
  },
  {
    "brans": "Kurek",
    "no": 139,
    "mevki": [
      "Farketmez",
      "Kiyi-Okyanus",
      "Universite",
      "Okyanus",
      "Yaris-Teknesi",
      "Kurek-Egzersizi",
      "Tek-Kurek",
      "Kurek-Cekme"
    ]
  },
  {
    "brans": "Kort-Tenisi",
    "no": 140,
    "mevki": [
      "Farketmez",
      "Acik-Alan",
      "Kapali-Alan",
      "Toprak-Saha",
      "Cim-Saha",
      "Sert-Saha"
    ]
  },
  {
    "brans": "Kuk-Sool-Won",
    "no": 141,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Kulelkavido",
    "no": 142,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Kuttu-Varsai",
    "no": 143,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Lethwei",
    "no": 144,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "LOL",
    "no": 145,
    "mevki": [
      "Farketmez",
      "Support",
      "ADC",
      "Top",
      "Jungle",
      "Mid"
    ]
  },
  {
    "brans": "Masa-Tenisi",
    "no": 146,
    "mevki": [
      "Tenisci"
    ]
  },
  {
    "brans": "Muay-Thai",
    "no": 147,
    "mevki": [
      "Farketmez",
      "Point-Fighting",
      "K1-Rules"
    ]
  },
  {
    "brans": "Muhendis",
    "no": 148,
    "mevki": [
      "Agac-Endustri",
      "Bilgisayar",
      "Bilisim-Sistemleri",
      "Biyomuhendislik",
      "Cevre",
      "Enerji-Sistemleri",
      "Endustriyel-Tasarim",
      "Elektrik",
      "Elektrik-Elektronik",
      "Endustri",
      "Fizik",
      "Gemi-Makinalari-İsletme",
      "Geomatik",
      "Gida",
      "Harita",
      "Havacilik-Uzay",
      "İnsaat",
      "Jeoloji",
      "Matematik",
      "Maden",
      "Makine",
      "Mekatronik",
      "Metaluruji-Malzeme",
      "Nanoteknoloji",
      "Malzeme-Bilimi",
      "Orman",
      "Orman-Endustri",
      "Kimya",
      "Nukleer-Enerji",
      "Otomotiv",
      "Rayli-Sistemler",
      "Sistem",
      "Tekstil",
      "Yazilim",
      "Ziraat"
    ]
  },
  {
    "brans": "Muzisyen",
    "no": 149,
    "mevki": [
      "Farketmez",
      "Ahsap-Blok",
      "Armonika",
      "Afoxe",
      "Agogo",
      "Agung",
      "Angklung",
      "Akordeon",
      "Baglama-Kisa",
      "Baglama-Uzun",
      "Babendil",
      "Bak",
      "Bamileke",
      "Balafon",
      "Bata-Davulu",
      "Bateri",
      "Bayan",
      "BlokFlut",
      "Boru",
      "Bifora",
      "Cabasa",
      "Cajon",
      "Carillon",
      "Castanet",
      "Caxirola",
      "Caxixi",
      "Chacaras",
      "Clapstick",
      "Def",
      "Claves",
      "İnek-Cani",
      "Crotales",
      "Cornet",
      "Cymbal",
      "Ferrinho",
      "Flexaton",
      "Fagot",
      "Flut",
      "Gitar",
      "Okta-Vibraton",
      "Gandingan",
      "Gayda",
      "Ghatam",
      "Glockenspiel",
      "Gong",
      "Guiro",
      "Islik",
      "Harmoneon",
      "Handpan",
      "Hang",
      "Kamis",
      "Kayamb",
      "Keman",
      "Kemanak",
      "Kemence",
      "Khartal",
      "Ksilofon",
      "Klarnet",
      "Kouxian",
      "Kulintang",
      "Lur",
      "Maraca",
      "Marimba",
      "Mbira",
      "Ney",
      "Org",
      "Obua",
      "Okarina",
      "Pate",
      "Piyano",
      "Shekere",
      "Saksafon",
      "Saz-Kisa",
      "Saz-Uzun",
      "Trombon",
      "Kesik-Davul",
      "Kasik",
      "Celik-Davul",
      "Teponaztli",
      "Uzgen",
      "Cop-Tupu",
      "Txalaparta",
      "Vibrafon",
      "Vibraslap",
      "Muzik-Tahtasi",
      "Tenor",
      "Tahta-Balik",
      "Ufleme-Sisesi",
      "Yan-Flut",
      "Zil",
      "Zurna"
    ]
  },
  {
    "brans": "Ninjitsu",
    "no": 150,
    "mevki": [
      "Farketmez",
      "Tai-Sabaki",
      "Tai-Jutsu",
      "Jutai-Jutsu",
      "Kobu-Jutsu"
    ]
  },
  {
    "brans": "Okculuk",
    "no": 151,
    "mevki": [
      "Okculuk"
    ]
  },
  {
    "brans": "Oyun",
    "no": 152,
    "mevki": [
      "101",
      "Batak",
      "Okey"
    ]
  },
   {
    "brans": "Online-Oyun",
    "no": 153,
    "mevki": [
      "Call-of-Duty",
      "CrossfireX",
      "Destiny-2",
      "Fornite",
      "GTA",
      "Sea-of-Thieves",
      "Hood",
      "Overcooked"
    ]
  },
  {
    "brans": "Paradal-Serey",
    "no": 154,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Paten",
    "no": 155,
    "mevki": [
      "Paten"
    ]
  },
  {
    "brans": "Parasail",
    "no": 156,
    "mevki": [
      "Sorfcu"
    ]
  },
  {
    "brans": "Pencak-Silat",
    "no": 157,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Pentatlon",
    "no": 158,
    "mevki": [
      "Pentatlon"
    ]
  },
  {
    "brans": "Picigin",
    "no": 159,
    "mevki": [
      "Sporcu"
    ]
  },
  {
    "brans": "Pencak-Silat",
    "no": 160,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Rafting",
    "no": 161,
    "mevki": [
      "Rafting"
    ]
  },
  {
    "brans": "Resim",
    "no": 162,
    "mevki": [
      "Farketmez",
      "Kara-Kalem",
      "Yagli-Boya",
      "Kuru-Boya",
      "Nu",
      "Narural",
      "Diger"
    ]
  },
  {
    "brans": "Ruzgar-Sorfu",
    "no": 163,
    "mevki": [
      "Sorfcu"
    ]
  },
  {
    "brans": "Sanguchi",
    "no": 164,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Sambo",
    "no": 165,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Satranc",
    "no": 166,
    "mevki": [
      "Farketmez",
      "Sureli",
      "Suresiz"
    ]
  },
  {
    "brans": "Sayokan",
    "no": 167,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Shorinji-Kampo",
    "no": 168,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Skimboard",
    "no": 169,
    "mevki": [
      "Sorfcu"
    ]
  },
  {
    "brans": "Sinav-Hazirlik",
    "no": 170,
    "mevki": [
      "LGS",
      "YKS",
      "AYT",
      "TYT",
      "Orta-Ogretim-Lise-KPSS",
      "Onlisans-KPSS",
      "Lisans-KPSS",
      "ALES",
      "TUS",
      "YDS",
      "DGS",
      "IELTS-TOEFL"
    ]
  },
  {
    "brans": "Sindo",
    "no": 171,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Sip-Kwon-Do",
    "no": 172,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Sinema",
    "no": 173,
    "mevki": [
      "Farketmez",
      "Aksiyon",
      "Animasyon",
      "Belgesel",
      "Bilim-Kurgu",
      "Cizgifilm",
      "Dini",
      "Dram",
      "Duygusal",
      "Erotik",
      "Fantastik",
      "Gerilim",
      "Komedi",
      "Korku",
      "Macera",
      "Muzikat",
      "Politik",
      "Pornografik",
      "Romantik",
      "Savas",
      "Spor",
      "Suc",
      "Western"
    ]
  },
  {
    "brans": "Sit-Down-Hydrofoil",
    "no": 174,
    "mevki": [
      "Sporcu"
    ]
  },
  {
    "brans": "Su-Topu",
    "no": 175,
    "mevki": [
      "Farketmez",
      "Kaleci",
      "Oyuncu"
    ]
  },
  {
    "brans": "Sumo",
    "no": 176,
    "mevki": [
      "Sumo"
    ]
  },
  {
    "brans": "Systema",
    "no": 177,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Sorf",
    "no": 178,
    "mevki": [
      "Sorfcu"
    ]
  },
  {
    "brans": "Snorkel-Dalisi",
    "no": 179,
    "mevki": [
      "Dalisci"
    ]
  },
  {
    "brans": "Tai-Chai",
    "no": 180,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Taekyon",
    "no": 181,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Taekwon-Do",
    "no": 182,
    "mevki": [
      "Taekwon-Do"
    ]
  },
  {
    "brans": "Takilmak",
    "no": 183,
    "mevki": [
      "Dam",
      "Ev-Arkadasi"
    ]
  },
  {
    "brans": "Tirmanis",
    "no": 184,
    "mevki": [
      "Farketmez",
      "Serbest",
      "Free-Solo",
      "Yapay",
      "Egitim",
      "Uzun-Duvar",
      "Yapay-Duvar"
    ]
  },
  {
    "brans": "Trekking",
    "no": 185,
    "mevki": [
      "Trekking"
    ]
  },
  {
    "brans": "Triatlon",
    "no": 186,
    "mevki": [
      "Triatlon"
    ]
  },
  {
    "brans": "Tuplu-Dalis",
    "no": 187,
    "mevki": [
      "Dalgic"
    ]
  },
  {
    "brans": "Valorant",
    "no": 188,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Voleybol",
    "no": 189,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Yelken",
    "no": 190,
    "mevki": [
      "Yelken"
    ]
  },
  {
    "brans": "Yazilim",
    "no": 191,
    "mevki": [
      "Farketmez",
      "C",
      "C#",
      "C++",
      "Pyhon",
      "Java",
      "Dart",
      "BackEnd",
      "FronEnd"
    ]
  },
  {
    "brans": "Yuzme",
    "no": 192,
    "mevki": [
      "Farketmez",
      "Deniz",
      "Havuz",
      "Serbest",
      "Kurbagalama",
      "Kelebekleme",
      "Sirtustu",
      "Karisik"
    ]
  },
  {
    "brans": "Waboba",
    "no": 193,
    "mevki": [
      "Waboba"
    ]
  },
  {
    "brans": "Wing-Chun",
    "no": 194,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Xingyiquan",
    "no": 195,
    "mevki": [
      "Farketmez"
    ]
  }
]""";
// ignore: constant_identifier_names
const String _SexData = """[
  {
    "sex": "Seçiniz",
    "x": 1000
  },
  {
    "sex": "Male",
    "x": 1001
  },
  {
    "sex": "Female",
    "x": 1002    
  }
]""";
