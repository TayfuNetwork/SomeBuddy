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
    "brans": "Aromatik-Bitikler",
    "no": 90,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Aslando",
    "no": 91,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Atıcılık",
    "no": 92,
    "mevki": [
      "Atıcı"
    ]
  },
  {
    "brans": "Atletizm",
    "no": 93,
    "mevki": [
      "Farketmez",
      "100m-Koşu",
      "200m-Koşu",
      "400m-Koşu",
      "110m-Engelli-Koşu-Erkek",
      "100m-Engelli-Koşu-Kadın",
      "800m-Koşu",
      "1500m-Koşu",
      "1mil-Koşu",
      "3000m-Koşu",
      "5000m-Koşu",
      "10000m-Koşu",
      "3000m-Su-Engeli",
      "Bayrak-Koşuları",
      "42km-Maraton-Koşusu",
      "21km-Yarı-Maraton-Koşusu",
      "10km-Maraton",
      "15km-Maraton",
      "Yürüyüş",
      "Atlama",
      "Atma",
      "Kros-Dağ-Koşusu"
    ]
  },
  {
    "brans": "Ayakta-Kürek-Sörf",
    "no": 94,
    "mevki": [
      "Sörfçü"
    ]
  },
  {
    "brans": "Badminton",
    "no": 95,
    "mevki": [
      "Badminton"
    ]
  },
  {
    "brans": "Baguazhan",
    "no": 96,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Bale",
    "no": 97,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Balıkçılık",
    "no": 98,
    "mevki": [
      "Farketmez",
      "Oltalı",
      "Ağlı",
      "Zıpkınlı",
      "Tekneli"
    ]
  },
  {
    "brans": "Bando",
    "no": 99,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Bartitsu",
    "no": 100,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Basketbol",
    "no": 101,
    "mevki": [
      "Farketmez",
      "ileri",
      "geri"
    ]
  },
  {
    "brans": "Binicilik",
    "no": 102,
    "mevki": [
      "Farketmez",
      "Engel-Atlama",
      "At-Terbiyesi",
      "Engelli-At-Terbiyesi",
      "Atlı-Dayanıklılık",
      "Voltij",
      "Atlı-Arabacılık",
      "Engelli-Atlı-Arabacılık",
      "Dizginleme"
    ]
  },
  {
    "brans": "Bisiklet",
    "no": 103,
    "mevki": [
      "Farketmez",
      "Yol",
      "Pist",
      "Cyclo-Cross",
      "BMX"
    ]
  },
  {
    "brans": "BodyBuilding",
    "no": 104,
    "mevki": [
      "Farketmez",
      "Kol",
      "Omuz",
      "Sırt",
      "Karın",
      "Bacak",
      "Squat",
      "Kanat",
      "Full"
    ]
  },
  {
    "brans": "BodyBoarding",
    "no": 105,
    "mevki": [
      "Sörfçü"
    ]
  },
  {
    "brans": "Boks",
    "no": 106,
    "mevki": [
      "Farketmez",
      "49-51kg",
      "52-54kg",
      "55-57kg",
      "59-62kg",
      "63-67kg",
      "69-73kg",
      "76-80kg",
      "90-Üstü"
    ]
  },
  {
    "brans": "Bowls",
    "no": 107,
    "mevki": [
      "Bowls"
    ]
  },
  {
    "brans": "Çadır",
    "no": 108,
    "mevki": [
      "Dağ-Kamp-Gecelik(Çadırım-Var)",
      "Dağ-Kamp-Gecelik(Çadırım-Yok)",
      "Tur-Birçok-Yer(Çadırım-Var)",
      "Tur-Birçok-Yer(Çadırım-Yok)",
      "Sahil(Çadırım-Var)",
      "Sahil(Çadırım-Yok)"
    ]
  },
  {
    "brans": "Dans",
    "no": 109,
    "mevki": [
      "Farketmez",
      "Rock",
      "Broadway",
      "Bale",
      "Capoeira",
      "Ça-Ça",
      "Disko",
      "Foxtrot",
      "Salsa",
      "Breakdance",
      "Halk-Oyunları",
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
      "Tap-Dansı",
      "Oryantal",
      "Sirtaki",
      "Roman"
    ]
  },
  {
    "brans": "Dragon-Boat",
    "no": 110,
    "mevki": [
      "Dragon-Bot"
    ]
  },
  {
    "brans": "Eskrim",
    "no": 111,
    "mevki": [
      "Farketmez",
      "Flöre",
      "Epe",
      "Kılıç"
    ]
  },
  {
    "brans": "Fitness",
    "no": 112,
    "mevki": [
      "Farketmez",
      "Esneklik",
      "Kardiyovasküler/aerobik",
      "Anaerobik",
      "Dayanıklılık"
    ]
  },
  {
    "brans": "Flyboard",
    "no": 113,
    "mevki": [
      "Sörfçü"
    ]
  },
  {
    "brans": "Futbol",
    "no": 114,
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
    "no": 115,
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
    "no": 116,
    "mevki": [
      "Farketmez",
      "Koparma",
      "Silkme"
    ]
  },
  {
    "brans": "Hapkido",
    "no": 117,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Hentbol",
    "no": 118,
    "mevki": [
      "Hentbol"
    ]
  },
  {
    "brans": "Heykel",
    "no": 119,
    "mevki": [
      "Heykeltraş"
    ]
  },
  {
    "brans": "Hokey",
    "no": 120,
    "mevki": [
      "Farketmez",
      "Açık-Alan",
      "Salon",
      "Analig",
      "Okul",
      "Plaj"
    ]
  },
  {
    "brans": "Hung-Gar",
    "no": 121,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Hwarangdo",
    "no": 122,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Jet-Ski",
    "no": 123,
    "mevki": [
      "Sörfçü"
    ]
  },
  {
    "brans": "Jimnastik",
    "no": 124,
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
    "no": 125,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Judo",
    "no": 126,
    "mevki": [
      "Farketmez",
      "34-38kg",
      "42-46kg",
      "50-55kg",
      "60-66kg",
      "73-81kg",
      "90-Üstü"
    ]
  },
  {
    "brans": "Jui-Jitsu",
    "no": 127,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Kablolu-Kayak",
    "no": 128,
    "mevki": [
      "Sörfçü"
    ]
  },
  {
    "brans": "Kano",
    "no": 129,
    "mevki": [
      "Kano"
    ]
  },
  {
    "brans": "Kalaripayat",
    "no": 130,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Kayak",
    "no": 131,
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
      "Kayaklı-Koşu",
      "Skiboarding"
    ]
  },
  {
    "brans": "Kateda",
    "no": 132,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Kenjutsu",
    "no": 133,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Kick-Boks",
    "no": 134,
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
    "no": 135,
    "mevki": [
      "Sörfçü"
    ]
  },
  {
    "brans": "Krav-Maga",
    "no": 136,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Korfball",
    "no": 137,
    "mevki": [
      "Korfbol"
    ]
  },
  {
    "brans": "Kürek",
    "no": 138,
    "mevki": [
      "Farketmez",
      "Kıyı-Okyanus",
      "Üniversite",
      "Okyanus",
      "Yarış-Teknesi",
      "Kürek-Egzersizi",
      "Tek-Kürek",
      "Kürek-Çekme"
    ]
  },
  {
    "brans": "Kort-Tenisi",
    "no": 139,
    "mevki": [
      "Farketmez",
      "Açık-Alan",
      "Kapalı-Alan",
      "Toprak-Saha",
      "Çim-Saha",
      "Sert-Saha"
    ]
  },
  {
    "brans": "Kuk-Sool-Won",
    "no": 140,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Kulelkavido",
    "no": 141,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Kuttu-Varsai",
    "no": 142,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Lethwei",
    "no": 143,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "LOL",
    "no": 144,
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
    "no": 145,
    "mevki": [
      "Tenisçi"
    ]
  },
  {
    "brans": "Muay-Thai",
    "no": 146,
    "mevki": [
      "Farketmez",
      "Point-Fighting",
      "K1-Rules"
    ]
  },
  {
    "brans": "Mühendis",
    "no": 147,
    "mevki": [
      "Ağaç-Endüstri",
      "Bilgisayar",
      "Bilişim-Sistemleri",
      "Biyomühendislik",
      "Çevre",
      "Enerji-Sistemleri",
      "Endüstriyel-Tasarım",
      "Elektrik",
      "Elektrik-Elektronik",
      "Endüstri",
      "Fizik",
      "Gemi-Makinaları-İşletme",
      "Geomatik",
      "Gıda",
      "Harita",
      "Havacılık-Uzay",
      "İnşaat",
      "Jeoloji",
      "Matematik",
      "Maden",
      "Makine",
      "Mekatronik",
      "Metaluruji-Malzeme",
      "Nanoteknoloji",
      "Malzeme-Bilimi",
      "Orman",
      "Orman-Endüstri",
      "Kimya",
      "Nükleer-Enerji",
      "Otomotiv",
      "Raylı-Sistemler",
      "Sistem",
      "Tekstil",
      "Yazılım",
      "Ziraat"
    ]
  },
  {
    "brans": "Müzisyen",
    "no": 148,
    "mevki": [
      "Farketmez",
      "Ahşap-Blok",
      "Armonika",
      "Afoxe",
      "Agogo",
      "Agung",
      "Angklung",
      "Akordeon",
      "Bağlama-Kısa",
      "Bağlama-Uzun",
      "Babendil",
      "Bak",
      "Bamileke",
      "Balafon",
      "Bata-Davulu",
      "Bateri",
      "Bayan",
      "BlokFlüt",
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
      "İnek-Çanı",
      "Crotales",
      "Cornet",
      "Cymbal",
      "Ferrinho",
      "Flexaton",
      "Fagot",
      "Flüt",
      "Gitar",
      "Okta-Vibraton",
      "Gandingan",
      "Gayda",
      "Ghatam",
      "Glockenspiel",
      "Gong",
      "Güiro",
      "Islık",
      "Harmoneon",
      "Handpan",
      "Hang",
      "Kamış",
      "Kayamb",
      "Keman",
      "Kemanak",
      "Kemençe",
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
      "Saz-Kısa",
      "Saz-Uzun",
      "Trombon",
      "Kesik-Davul",
      "Kaşık",
      "Çelik-Davul",
      "Teponaztli",
      "Üzgen",
      "Çöp-Tüpü",
      "Txalaparta",
      "Vibrafon",
      "Vibraslap",
      "Müzik-Tahtası",
      "Tenor",
      "Tahta-Balık",
      "Üfleme-Şişesi",
      "Yan-Flüt",
      "Zil",
      "Zurna"
    ]
  },
  {
    "brans": "Ninjitsu",
    "no": 149,
    "mevki": [
      "Farketmez",
      "Tai-Sabaki",
      "Tai-Jutsu",
      "Jutai-Jutsu",
      "Kobu-Jutsu"
    ]
  },
  {
    "brans": "Okçuluk",
    "no": 150,
    "mevki": [
      "Okçuluk"
    ]
  },
  {
    "brans": "Oyun",
    "no": 151,
    "mevki": [
      "101",
      "Batak",
      "Okey"
    ]
  },
   {
    "brans": "Online-Oyun",
    "no": 152,
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
    "no": 153,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Paten",
    "no": 154,
    "mevki": [
      "Patenci"
    ]
  },
  {
    "brans": "Parasail",
    "no": 155,
    "mevki": [
      "Sörfçü"
    ]
  },
  {
    "brans": "Pencak-Silat",
    "no": 156,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Pentatlon",
    "no": 157,
    "mevki": [
      "Pentatlon"
    ]
  },
  {
    "brans": "Picigin",
    "no": 158,
    "mevki": [
      "Sporcu"
    ]
  },
  {
    "brans": "Pencak-Sılat",
    "no": 159,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Rafting",
    "no": 160,
    "mevki": [
      "Rafting"
    ]
  },
  {
    "brans": "Resim",
    "no": 161,
    "mevki": [
      "Farketmez",
      "Kara-Kalem",
      "Yağlı-Boya",
      "Kuru-Boya",
      "Nü",
      "Narural",
      "Diğer"
    ]
  },
  {
    "brans": "Rüzgar-Sörfü",
    "no": 162,
    "mevki": [
      "Sörfçü"
    ]
  },
  {
    "brans": "Sanguchi",
    "no": 163,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Sambo",
    "no": 164,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Satranç",
    "no": 165,
    "mevki": [
      "Farketmez",
      "Süreli",
      "Süresiz"
    ]
  },
  {
    "brans": "Sayokan",
    "no": 166,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Shorinji-Kampo",
    "no": 167,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Skimboard",
    "no": 168,
    "mevki": [
      "Sörfçü"
    ]
  },
  {
    "brans": "Sınav-Hazırlık",
    "no": 169,
    "mevki": [
      "LGS",
      "YKS",
      "AYT",
      "TYT",
      "Orta-Öğretim-Lise-KPSS",
      "Önlisans-KPSS",
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
    "no": 170,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Sip-Kwon-Do",
    "no": 171,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Sinema",
    "no": 172,
    "mevki": [
      "Farketmez",
      "Aksiyon",
      "Animasyon",
      "Belgesel",
      "Bilim-Kurgu",
      "Çizgifilm"
      "Dini"
      "Dram",
      "Duygusal",
      "Erotik",
      "Fantastik",
      "Gerilim",
      "Komedi",
      "Korku",
      "Macera",
      "Müzikat",
      "Politik",
      "Pornografik",
      "Romantik",
      "Savaş",
      "Spor",
      "Suç",
      "Western"
    ]
  },
  {
    "brans": "Sit-Down-Hydrofoil",
    "no": 173,
    "mevki": [
      "Sporcu"
    ]
  },
  {
    "brans": "Su-Topu",
    "no": 174,
    "mevki": [
      "Farketmez",
      "Kaleci",
      "Oyuncu"
    ]
  },
  {
    "brans": "Sumo",
    "no": 175,
    "mevki": [
      "Sumo"
    ]
  },
  {
    "brans": "Systema",
    "no": 176,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Sörf",
    "no": 177,
    "mevki": [
      "Sörfçü"
    ]
  },
  {
    "brans": "Şnorkel-Dalışı",
    "no": 178,
    "mevki": [
      "Dalışçı"
    ]
  },
  {
    "brans": "Tai-Chai",
    "no": 179,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Taekyon",
    "no": 180,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Taekwon-Do",
    "no": 181,
    "mevki": [
      "Taekwon-Do"
    ]
  },
  {
    "brans": "Takılmak",
    "no": 182,
    "mevki": [
      "Dam",
      "Ev-Arkadaşı"
    ]
  },
  {
    "brans": "Tırmanış",
    "no": 183,
    "mevki": [
      "Farketmez",
      "Serbest",
      "Free-Solo",
      "Yapay",
      "Eğitim",
      "Uzun-Duvar",
      "Yapay-Duvar"
    ]
  },
  {
    "brans": "Trekking",
    "no": 184,
    "mevki": [
      "Trekking"
    ]
  },
  {
    "brans": "Triatlon",
    "no": 185,
    "mevki": [
      "Triatlon"
    ]
  },
  {
    "brans": "Tüplü-Dalış",
    "no": 186,
    "mevki": [
      "Dalışçı"
    ]
  },
  {
    "brans": "Valorant",
    "no": 187,
    "mevki": [
      "Farketmez",
      "Nan",
      "Shaolin",
      "Wudang",
      "hui"
    ]
  },
  {
    "brans": "Voleybol",
    "no": 188,
    "mevki": [
      "Farketmez",
      "Smacor",
      "pasor",
      "servis",
      "orta"
    ]
  },
  {
    "brans": "Yelken",
    "no": 189,
    "mevki": [
      "Yelken"
    ]
  },
  {
    "brans": "Yazılım",
    "no": 190,
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
    "no": 191,
    "mevki": [
      "Farketmez",
      "Deniz",
      "Havuz",
      "Serbest",
      "Kurbağalama",
      "Kelebekleme",
      "Sırtüstü",
      "Karışık"
    ]
  },
  {
    "brans": "Waboba",
    "no": 192,
    "mevki": [
      "Waboba"
    ]
  },
  {
    "brans": "Wing-Chun",
    "no": 193,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Xingyiquan",
    "no": 194,
    "mevki": [
      "Farketmez"
    ]
  }
]""";
// ignore: constant_identifier_names
const String _SexData = """[
  {
    "sex": "Seçiniz / Choice",
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
