import 'dart:convert';

class IlService {
  List<Il> get iller {
    List iller = jsonDecode(_ilDatas) as List;
    return iller.map((e) => Il.fromJson(e)).toList();
  }

  List<Il> ilAra(String query) {
    return iller
        .where(
            (element) => element.il.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  List<String> ilceler(int plakaKodu) {
    int index = iller.indexWhere((element) => element.plaka == plakaKodu);
    if (index != -1) {
      return iller[index].ilceleri;
    }
    return [];
  }
}

class Il {
  String il;
  int plaka;
  List<String> ilceleri;

  Il({required this.il, required this.plaka, required this.ilceleri});

  factory Il.fromJson(Map<String, dynamic> json) {
    return Il(
      il: json["il"],
      ilceleri: json['ilceleri'].cast<String>(),
      plaka: json["plaka"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['il'] = il;
    data['plaka'] = plaka;
    data['ilceleri'] = ilceleri;
    return data;
  }
}

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

const String _ilDatas = """[
 
  {
    "il": "Adana",
    "plaka": 1,
    "ilceleri": [
      "Aladağ",
      "Ceyhan",
      "Çukurova",
      "Feke",
      "İmamoğlu",
      "Karaisalı",
      "Karataş",
      "Kozan",
      "Pozantı",
      "Saimbeyli",
      "Sarıçam",
      "Seyhan",
      "Tufanbeyli",
      "Yumurtalık",
      "Yüreğir"
    ]
  },
  {
    "il": "Adıyaman",
    "plaka": 2,
    "ilceleri": [
      "Besni",
      "Çelikhan",
      "Gerger",
      "Gölbaşı",
      "Kahta",
      "Merkez",
      "Samsat",
      "Sincik",
      "Tut"
    ]
  },
  {
    "il": "Afyonkarahisar",
    "plaka": 3,
    "ilceleri": [
      "Başmakçı",
      "Bayat",
      "Bolvadin",
      "Çay",
      "Çobanlar",
      "Dazkırı",
      "Dinar",
      "Emirdağ",
      "Evciler",
      "Hocalar",
      "İhsaniye",
      "İscehisar",
      "Kızılören",
      "Merkez",
      "Sandıklı",
      "Sinanpaşa",
      "Sultandağı",
      "Şuhut"
    ]
  },
  {
    "il": "Ağrı",
    "plaka": 4,
    "ilceleri": [
      "Diyadin",
      "Doğubayazıt",
      "Eleşkirt",
      "Hamur",
      "Merkez",
      "Patnos",
      "Taşlıçay",
      "Tutak"
    ]
  },
  {
    "il": "Amasya",
    "plaka": 5,
    "ilceleri": [
      "Göynücek",
      "Gümüşhacıköy",
      "Hamamözü",
      "Merkez",
      "Merzifon",
      "Suluova",
      "Taşova"
    ]
  },
  {
    "il": "Ankara",
    "plaka": 6,
    "ilceleri": [
      "Altındağ",
      "Ayaş",
      "Bala",
      "Beypazarı",
      "Çamlıdere",
      "Çankaya",
      "Çubuk",
      "Elmadağ",
      "Güdül",
      "Haymana",
      "Kalecik",
      "Kızılcahamam",
      "Nallıhan",
      "Polatlı",
      "Şereflikoçhisar",
      "Yenimahalle",
      "Gölbaşı",
      "Keçiören",
      "Mamak",
      "Sincan",
      "Kazan",
      "Akyurt",
      "Etimesgut",
      "Evren",
      "Pursaklar"
    ]
  },
  {
    "il": "Antalya",
    "plaka": 7,
    "ilceleri": [
      "Akseki",
      "Alanya",
      "Elmalı",
      "Finike",
      "Gazipaşa",
      "Gündoğmuş",
      "Kaş",
      "Korkuteli",
      "Kumluca",
      "Manavgat",
      "Serik",
      "Demre",
      "İbradı",
      "Kemer",
      "Aksu",
      "Döşemealtı",
      "Kepez",
      "Konyaaltı",
      "Muratpaşa"
    ]
  },
  {
    "il": "Artvin",
    "plaka": 8,
    "ilceleri": [
      "Ardanuç",
      "Arhavi",
      "Merkez",
      "Borçka",
      "Hopa",
      "Şavşat",
      "Yusufeli",
      "Murgul"
    ]
  },
  {
    "il": "Aydın",
    "plaka": 9,
    "ilceleri": [
      "Merkez",
      "Bozdoğan",
      "Efeler",
      "Çine",
      "Germencik",
      "Karacasu",
      "Koçarlı",
      "Kuşadası",
      "Kuyucak",
      "Nazilli",
      "Söke",
      "Sultanhisar",
      "Yenipazar",
      "Buharkent",
      "İncirliova",
      "Karpuzlu",
      "Köşk",
      "Didim"
    ]
  },
  {
    "il": "Balıkesir",
    "plaka": 10,
    "ilceleri": [
      "Altıeylül",
      "Ayvalık",
      "Merkez",
      "Balya",
      "Bandırma",
      "Bigadiç",
      "Burhaniye",
      "Dursunbey",
      "Edremit",
      "Erdek",
      "Gönen",
      "Havran",
      "İvrindi",
      "Karesi",
      "Kepsut",
      "Manyas",
      "Savaştepe",
      "Sındırgı",
      "Gömeç",
      "Susurluk",
      "Marmara"
    ]
  },
  {
    "il": "Bilecik",
    "plaka": 11,
    "ilceleri": [
      "Merkez",
      "Bozüyük",
      "Gölpazarı",
      "Osmaneli",
      "Pazaryeri",
      "Söğüt",
      "Yenipazar",
      "İnhisar"
    ]
  },
  {
    "il": "Bingöl",
    "plaka": 12,
    "ilceleri": [
      "Merkez",
      "Genç",
      "Karlıova",
      "Kiğı",
      "Solhan",
      "Adaklı",
      "Yayladere",
      "Yedisu"
    ]
  },
  {
    "il": "Bitlis",
    "plaka": 13,
    "ilceleri": [
      "Adilcevaz",
      "Ahlat",
      "Merkez",
      "Hizan",
      "Mutki",
      "Tatvan",
      "Güroymak"
    ]
  },
  {
    "il": "Bolu",
    "plaka": 14,
    "ilceleri": [
      "Merkez",
      "Gerede",
      "Göynük",
      "Kıbrıscık",
      "Mengen",
      "Mudurnu",
      "Seben",
      "Dörtdivan",
      "Yeniçağa"
    ]
  },
  {
    "il": "Burdur",
    "plaka": 15,
    "ilceleri": [
      "Ağlasun",
      "Bucak",
      "Merkez",
      "Gölhisar",
      "Tefenni",
      "Yeşilova",
      "Karamanlı",
      "Kemer",
      "Altınyayla",
      "Çavdır",
      "Çeltikçi"
    ]
  },
  {
    "il": "Bursa",
    "plaka": 16,
    "ilceleri": [
      "Gemlik",
      "İnegöl",
      "İznik",
      "Karacabey",
      "Keles",
      "Mudanya",
      "Mustafakemalpaşa",
      "Orhaneli",
      "Orhangazi",
      "Yenişehir",
      "Büyükorhan",
      "Harmancık",
      "Nilüfer",
      "Osmangazi",
      "Yıldırım",
      "Gürsu",
      "Kestel"
    ]
  },
  {
    "il": "Çanakkale",
    "plaka": 17,
    "ilceleri": [
      "Ayvacık",
      "Bayramiç",
      "Biga",
      "Bozcaada",
      "Çan",
      "Merkez",
      "Eceabat",
      "Ezine",
      "Gelibolu",
      "Gökçeada",
      "Lapseki",
      "Yenice"
    ]
  },
  {
    "il": "Çankırı",
    "plaka": 18,
    "ilceleri": [
      "Merkez",
      "Çerkeş",
      "Eldivan",
      "Ilgaz",
      "Kurşunlu",
      "Orta",
      "Şabanözü",
      "Yapraklı",
      "Atkaracalar",
      "Kızılırmak",
      "Bayramören",
      "Korgun"
    ]
  },
  {
    "il": "Çorum",
    "plaka": 19,
    "ilceleri": [
      "Alaca",
      "Bayat",
      "Merkez",
      "İskilip",
      "Kargı",
      "Mecitözü",
      "Ortaköy",
      "Osmancık",
      "Sungurlu",
      "Boğazkale",
      "Uğurludağ",
      "Dodurga",
      "Laçin",
      "Oğuzlar"
    ]
  },
  {
    "il": "Denizli",
    "plaka": 20,
    "ilceleri": [
      "Acıpayam",
      "Buldan",
      "Çal",
      "Çameli",
      "Çardak",
      "Çivril",
      "Merkez",
      "Merkezefendi",
      "Pamukkale",
      "Güney",
      "Kale",
      "Sarayköy",
      "Tavas",
      "Babadağ",
      "Bekilli",
      "Honaz",
      "Serinhisar",
      "Baklan",
      "Beyağaç",
      "Bozkurt"
    ]
  },
  {
    "il": "Diyarbakır",
    "plaka": 21,
    "ilceleri": [
      "Kocaköy",
      "Çermik",
      "Çınar",
      "Çüngüş",
      "Dicle",
      "Ergani",
      "Hani",
      "Hazro",
      "Kulp",
      "Lice",
      "Silvan",
      "Eğil",
      "Bağlar",
      "Kayapınar",
      "Sur",
      "Yenişehir",
      "Bismil"
    ]
  },
  {
    "il": "Edirne",
    "plaka": 22,
    "ilceleri": [
      "Merkez",
      "Enez",
      "Havsa",
      "İpsala",
      "Keşan",
      "Lalapaşa",
      "Meriç",
      "Uzunköprü",
      "Süloğlu"
    ]
  },
  {
    "il": "Elazığ",
    "plaka": 23,
    "ilceleri": [
      "Ağın",
      "Baskil",
      "Merkez",
      "Karakoçan",
      "Keban",
      "Maden",
      "Palu",
      "Sivrice",
      "Arıcak",
      "Kovancılar",
      "Alacakaya"
    ]
  },
  {
    "il": "Erzincan",
    "plaka": 24,
    "ilceleri": [
      "Çayırlı",
      "Merkez",
      "İliç",
      "Kemah",
      "Kemaliye",
      "Refahiye",
      "Tercan",
      "Üzümlü",
      "Otlukbeli"
    ]
  },
  {
    "il": "Erzurum",
    "plaka": 25,
    "ilceleri": [
      "Aşkale",
      "Çat",
      "Hınıs",
      "Horasan",
      "İspir",
      "Karayazı",
      "Narman",
      "Oltu",
      "Olur",
      "Pasinler",
      "Şenkaya",
      "Tekman",
      "Tortum",
      "Karaçoban",
      "Uzundere",
      "Pazaryolu",
      "Köprüköy",
      "Palandöken",
      "Yakutiye",
      "Aziziye"
    ]
  },
  {
    "il": "Eskişehir",
    "plaka": 26,
    "ilceleri": [
      "Çifteler",
      "Mahmudiye",
      "Mihalıççık",
      "Sarıcakaya",
      "Seyitgazi",
      "Sivrihisar",
      "Alpu",
      "Beylikova",
      "İnönü",
      "Günyüzü",
      "Han",
      "Mihalgazi",
      "Odunpazarı",
      "Tepebaşı"
    ]
  },
  {
    "il": "Gaziantep",
    "plaka": 27,
    "ilceleri": [
      "Araban",
      "İslahiye",
      "Nizip",
      "Oğuzeli",
      "Yavuzeli",
      "Şahinbey",
      "Şehitkamil",
      "Karkamış",
      "Nurdağı"
    ]
  },
  {
    "il": "Giresun",
    "plaka": 28,
    "ilceleri": [
      "Alucra",
      "Bulancak",
      "Dereli",
      "Espiye",
      "Eynesil",
      "Merkez",
      "Görele",
      "Keşap",
      "Şebinkarahisar",
      "Tirebolu",
      "Piraziz",
      "Yağlıdere",
      "Çamoluk",
      "Çanakçı",
      "Doğankent",
      "Güce"
    ]
  },
  {
    "il": "Gümüşhane",
    "plaka": 29,
    "ilceleri": [
      "Merkez",
      "Kelkit",
      "Şiran",
      "Torul",
      "Köse",
      "Kürtün"
    ]
  },
  {
    "il": "Hakkari",
    "plaka": 30,
    "ilceleri": [
      "Çukurca",
      "Merkez",
      "Şemdinli",
      "Yüksekova"
    ]
  },
  {
    "il": "Hatay",
    "plaka": 31,
    "ilceleri": [
      "Altınözü",
      "Arsuz",
      "Defne",
      "Dörtyol",
      "Hassa",
      "Antakya",
      "İskenderun",
      "Kırıkhan",
      "Payas",
      "Reyhanlı",
      "Samandağ",
      "Yayladağı",
      "Erzin",
      "Belen",
      "Kumlu"
    ]
  },
  {
    "il": "Isparta",
    "plaka": 32,
    "ilceleri": [
      "Atabey",
      "Eğirdir",
      "Gelendost",
      "Merkez",
      "Keçiborlu",
      "Senirkent",
      "Sütçüler",
      "Şarkikaraağaç",
      "Uluborlu",
      "Yalvaç",
      "Aksu",
      "Gönen",
      "Yenişarbademli"
    ]
  },
  {
    "il": "Mersin",
    "plaka": 33,
    "ilceleri": [
      "Anamur",
      "Erdemli",
      "Gülnar",
      "Mut",
      "Silifke",
      "Tarsus",
      "Aydıncık",
      "Bozyazı",
      "Çamlıyayla",
      "Akdeniz",
      "Mezitli",
      "Toroslar",
      "Yenişehir"
    ]
  },
  {
    "il": "İstanbul",
    "plaka": 34,
    "ilceleri": [
      "Adalar",
      "Bakırköy",
      "Beşiktaş",
      "Beykoz",
      "Beyoğlu",
      "Çatalca",
      "Eyüp",
      "Fatih",
      "Gaziosmanpaşa",
      "Kadıköy",
      "Kartal",
      "Sarıyer",
      "Silivri",
      "Şile",
      "Şişli",
      "Üsküdar",
      "Zeytinburnu",
      "Büyükçekmece",
      "Kağıthane",
      "Küçükçekmece",
      "Pendik",
      "Ümraniye",
      "Bayrampaşa",
      "Avcılar",
      "Bağcılar",
      "Bahçelievler",
      "Güngören",
      "Maltepe",
      "Sultanbeyli",
      "Tuzla",
      "Esenler",
      "Arnavutköy",
      "Ataşehir",
      "Başakşehir",
      "Beylikdüzü",
      "Çekmeköy",
      "Esenyurt",
      "Sancaktepe",
      "Sultangazi"
    ]
  },
  {
    "il": "İzmir",
    "plaka": 35,
    "ilceleri": [
      "Aliağa",
      "Bayındır",
      "Bergama",
      "Bornova",
      "Çeşme",
      "Dikili",
      "Foça",
      "Karaburun",
      "Karşıyaka",
      "Kemalpaşa",
      "Kınık",
      "Kiraz",
      "Menemen",
      "Ödemiş",
      "Seferihisar",
      "Selçuk",
      "Tire",
      "Torbalı",
      "Urla",
      "Beydağ",
      "Buca",
      "Konak",
      "Menderes",
      "Balçova",
      "Çiğli",
      "Gaziemir",
      "Narlıdere",
      "Güzelbahçe",
      "Bayraklı",
      "Karabağlar"
    ]
  },
  {
    "il": "Kars",
    "plaka": 36,
    "ilceleri": [
      "Arpaçay",
      "Digor",
      "Kağızman",
      "Merkez",
      "Sarıkamış",
      "Selim",
      "Susuz",
      "Akyaka"
    ]
  },
  {
    "il": "Kastamonu",
    "plaka": 37,
    "ilceleri": [
      "Abana",
      "Araç",
      "Azdavay",
      "Bozkurt",
      "Cide",
      "Çatalzeytin",
      "Daday",
      "Devrekani",
      "İnebolu",
      "Merkez",
      "Küre",
      "Taşköprü",
      "Tosya",
      "İhsangazi",
      "Pınarbaşı",
      "Şenpazar",
      "Ağlı",
      "Doğanyurt",
      "Hanönü",
      "Seydiler"
    ]
  },
  {
    "il": "Kayseri",
    "plaka": 38,
    "ilceleri": [
      "Bünyan",
      "Develi",
      "Felahiye",
      "İncesu",
      "Pınarbaşı",
      "Sarıoğlan",
      "Sarız",
      "Tomarza",
      "Yahyalı",
      "Yeşilhisar",
      "Akkışla",
      "Talas",
      "Kocasinan",
      "Melikgazi",
      "Hacılar",
      "Özvatan"
    ]
  },
  {
    "il": "Kırklareli",
    "plaka": 39,
    "ilceleri": [
      "Babaeski",
      "Demirköy",
      "Merkez",
      "Kofçaz",
      "Lüleburgaz",
      "Pehlivanköy",
      "Pınarhisar",
      "Vize"
    ]
  },
  {
    "il": "Kırşehir",
    "plaka": 40,
    "ilceleri": [
      "Çiçekdağı",
      "Kaman",
      "Merkez",
      "Mucur",
      "Akpınar",
      "Akçakent",
      "Boztepe"
    ]
  },
  {
    "il": "Kocaeli",
    "plaka": 41,
    "ilceleri": [
      "Gebze",
      "Gölcük",
      "Kandıra",
      "Karamürsel",
      "Körfez",
      "Derince",
      "Başiskele",
      "Çayırova",
      "Darıca",
      "Dilovası",
      "İzmit",
      "Kartepe"
    ]
  },
  {
    "il": "Konya",
    "plaka": 42,
    "ilceleri": [
      "Akşehir",
      "Beyşehir",
      "Bozkır",
      "Cihanbeyli",
      "Çumra",
      "Doğanhisar",
      "Ereğli",
      "Hadim",
      "Ilgın",
      "Kadınhanı",
      "Karapınar",
      "Kulu",
      "Sarayönü",
      "Seydişehir",
      "Yunak",
      "Akören",
      "Altınekin",
      "Derebucak",
      "Hüyük",
      "Karatay",
      "Meram",
      "Selçuklu",
      "Taşkent",
      "Ahırlı",
      "Çeltik",
      "Derbent",
      "Emirgazi",
      "Güneysınır",
      "Halkapınar",
      "Tuzlukçu",
      "Yalıhüyük"
    ]
  },
  {
    "il": "Kütahya",
    "plaka": 43,
    "ilceleri": [
      "Altıntaş",
      "Domaniç",
      "Emet",
      "Gediz",
      "Merkez",
      "Simav",
      "Tavşanlı",
      "Aslanapa",
      "Dumlupınar",
      "Hisarcık",
      "Şaphane",
      "Çavdarhisar",
      "Pazarlar"
    ]
  },
  {
    "il": "Malatya",
    "plaka": 44,
    "ilceleri": [
      "Akçadağ",
      "Arapgir",
      "Arguvan",
      "Darende",
      "Doğanşehir",
      "Hekimhan",
      "Merkez",
      "Pütürge",
      "Yeşilyurt",
      "Battalgazi",
      "Doğanyol",
      "Kale",
      "Kuluncak",
      "Yazıhan"
    ]
  },
  {
    "il": "Manisa",
    "plaka": 45,
    "ilceleri": [
      "Akhisar",
      "Alaşehir",
      "Demirci",
      "Gördes",
      "Kırkağaç",
      "Kula",
      "Merkez",
      "Salihli",
      "Sarıgöl",
      "Saruhanlı",
      "Selendi",
      "Soma",
      "Şehzadeler",
      "Yunusemre",
      "Turgutlu",
      "Ahmetli",
      "Gölmarmara",
      "Köprübaşı"
    ]
  },
  {
    "il": "Kahramanmaraş",
    "plaka": 46,
    "ilceleri": [
      "Afşin",
      "Andırın",
      "Dulkadiroğlu",
      "Onikişubat",
      "Elbistan",
      "Göksun",
      "Merkez",
      "Pazarcık",
      "Türkoğlu",
      "Çağlayancerit",
      "Ekinözü",
      "Nurhak"
    ]
  },
  {
    "il": "Mardin",
    "plaka": 47,
    "ilceleri": [
      "Derik",
      "Kızıltepe",
      "Artuklu",
      "Merkez",
      "Mazıdağı",
      "Midyat",
      "Nusaybin",
      "Ömerli",
      "Savur",
      "Dargeçit",
      "Yeşilli"
    ]
  },
  {
    "il": "Muğla",
    "plaka": 48,
    "ilceleri": [
      "Bodrum",
      "Datça",
      "Fethiye",
      "Köyceğiz",
      "Marmaris",
      "Menteşe",
      "Milas",
      "Ula",
      "Yatağan",
      "Dalaman",
      "Seydikemer",
      "Ortaca",
      "Kavaklıdere"
    ]
  },
  {
    "il": "Muş",
    "plaka": 49,
    "ilceleri": [
      "Bulanık",
      "Malazgirt",
      "Merkez",
      "Varto",
      "Hasköy",
      "Korkut"
    ]
  },
  {
    "il": "Nevşehir",
    "plaka": 50,
    "ilceleri": [
      "Avanos",
      "Derinkuyu",
      "Gülşehir",
      "Hacıbektaş",
      "Kozaklı",
      "Merkez",
      "Ürgüp",
      "Acıgöl"
    ]
  },
  {
    "il": "Niğde",
    "plaka": 51,
    "ilceleri": [
      "Bor",
      "Çamardı",
      "Merkez",
      "Ulukışla",
      "Altunhisar",
      "Çiftlik"
    ]
  },
  {
    "il": "Ordu",
    "plaka": 52,
    "ilceleri": [
      "Akkuş",
      "Altınordu",
      "Aybastı",
      "Fatsa",
      "Gölköy",
      "Korgan",
      "Kumru",
      "Mesudiye",
      "Perşembe",
      "Ulubey",
      "Ünye",
      "Gülyalı",
      "Gürgentepe",
      "Çamaş",
      "Çatalpınar",
      "Çaybaşı",
      "İkizce",
      "Kabadüz",
      "Kabataş"
    ]
  },
  {
    "il": "Rize",
    "plaka": 53,
    "ilceleri": [
      "Ardeşen",
      "Çamlıhemşin",
      "Çayeli",
      "Fındıklı",
      "İkizdere",
      "Kalkandere",
      "Pazar",
      "Merkez",
      "Güneysu",
      "Derepazarı",
      "Hemşin",
      "İyidere"
    ]
  },
  {
    "il": "Sakarya",
    "plaka": 54,
    "ilceleri": [
      "Akyazı",
      "Geyve",
      "Hendek",
      "Karasu",
      "Kaynarca",
      "Sapanca",
      "Kocaali",
      "Pamukova",
      "Taraklı",
      "Ferizli",
      "Karapürçek",
      "Söğütlü",
      "Adapazarı",
      "Arifiye",
      "Erenler",
      "Serdivan"
    ]
  },
  {
    "il": "Samsun",
    "plaka": 55,
    "ilceleri": [
      "Alaçam",
      "Bafra",
      "Çarşamba",
      "Havza",
      "Kavak",
      "Ladik",
      "Terme",
      "Vezirköprü",
      "Asarcık",
      "Ondokuzmayıs",
      "Salıpazarı",
      "Tekkeköy",
      "Ayvacık",
      "Yakakent",
      "Atakum",
      "Canik",
      "İlkadım"
    ]
  },
  {
    "il": "Siirt",
    "plaka": 56,
    "ilceleri": [
      "Baykan",
      "Eruh",
      "Kurtalan",
      "Pervari",
      "Merkez",
      "Şirvan",
      "Tillo"
    ]
  },
  {
    "il": "Sinop",
    "plaka": 57,
    "ilceleri": [
      "Ayancık",
      "Boyabat",
      "Durağan",
      "Erfelek",
      "Gerze",
      "Merkez",
      "Türkeli",
      "Dikmen",
      "Saraydüzü"
    ]
  },
  {
    "il": "Sivas",
    "plaka": 58,
    "ilceleri": [
      "Divriği",
      "Gemerek",
      "Gürün",
      "Hafik",
      "İmranlı",
      "Kangal",
      "Koyulhisar",
      "Merkez",
      "Suşehri",
      "Şarkışla",
      "Yıldızeli",
      "Zara",
      "Akıncılar",
      "Altınyayla",
      "Doğanşar",
      "Gölova",
      "Ulaş"
    ]
  },
  {
    "il": "Tekirdağ",
    "plaka": 59,
    "ilceleri": [
      "Çerkezköy",
      "Çorlu",
      "Ergene",
      "Hayrabolu",
      "Malkara",
      "Muratlı",
      "Saray",
      "Süleymanpaşa",
      "Kapaklı",
      "Şarköy",
      "Marmaraereğlisi"
    ]
  },
  {
    "il": "Tokat",
    "plaka": 60,
    "ilceleri": [
      "Almus",
      "Artova",
      "Erbaa",
      "Niksar",
      "Reşadiye",
      "Merkez",
      "Turhal",
      "Zile",
      "Pazar",
      "Yeşilyurt",
      "Başçiftlik",
      "Sulusaray"
    ]
  },
  {
    "il": "Trabzon",
    "plaka": 61,
    "ilceleri": [
      "Akçaabat",
      "Araklı",
      "Arsin",
      "Çaykara",
      "Maçka",
      "Of",
      "Ortahisar",
      "Sürmene",
      "Tonya",
      "Vakfıkebir",
      "Yomra",
      "Beşikdüzü",
      "Şalpazarı",
      "Çarşıbaşı",
      "Dernekpazarı",
      "Düzköy",
      "Hayrat",
      "Köprübaşı"
    ]
  },
  {
    "il": "Tunceli",
    "plaka": 62,
    "ilceleri": [
      "Çemişgezek",
      "Hozat",
      "Mazgirt",
      "Nazımiye",
      "Ovacık",
      "Pertek",
      "Pülümür",
      "Merkez"
    ]
  },
  {
    "il": "Şanlıurfa",
    "plaka": 63,
    "ilceleri": [
      "Akçakale",
      "Birecik",
      "Bozova",
      "Ceylanpınar",
      "Eyyübiye",
      "Halfeti",
      "Haliliye",
      "Hilvan",
      "Karaköprü",
      "Siverek",
      "Suruç",
      "Viranşehir",
      "Harran"
    ]
  },
  {
    "il": "Uşak",
    "plaka": 64,
    "ilceleri": [
      "Banaz",
      "Eşme",
      "Karahallı",
      "Sivaslı",
      "Ulubey",
      "Merkez"
    ]
  },
  {
    "il": "Van",
    "plaka": 65,
    "ilceleri": [
      "Başkale",
      "Çatak",
      "Erciş",
      "Gevaş",
      "Gürpınar",
      "İpekyolu",
      "Muradiye",
      "Özalp",
      "Tuşba",
      "Bahçesaray",
      "Çaldıran",
      "Edremit",
      "Saray"
    ]
  },
  {
    "il": "Yozgat",
    "plaka": 66,
    "ilceleri": [
      "Akdağmadeni",
      "Boğazlıyan",
      "Çayıralan",
      "Çekerek",
      "Sarıkaya",
      "Sorgun",
      "Şefaatli",
      "Yerköy",
      "Merkez",
      "Aydıncık",
      "Çandır",
      "Kadışehri",
      "Saraykent",
      "Yenifakılı"
    ]
  },
  {
    "il": "Zonguldak",
    "plaka": 67,
    "ilceleri": [
      "Çaycuma",
      "Devrek",
      "Ereğli",
      "Merkez",
      "Alaplı",
      "Gökçebey"
    ]
  },
  {
    "il": "Aksaray",
    "plaka": 68,
    "ilceleri": [
      "Ağaçören",
      "Eskil",
      "Gülağaç",
      "Güzelyurt",
      "Merkez",
      "Ortaköy",
      "Sarıyahşi"
    ]
  },
  {
    "il": "Bayburt",
    "plaka": 69,
    "ilceleri": [
      "Merkez",
      "Aydıntepe",
      "Demirözü"
    ]
  },
  {
    "il": "Karaman",
    "plaka": 70,
    "ilceleri": [
      "Ermenek",
      "Merkez",
      "Ayrancı",
      "Kazımkarabekir",
      "Başyayla",
      "Sarıveliler"
    ]
  },
  {
    "il": "Kırıkkale",
    "plaka": 71,
    "ilceleri": [
      "Delice",
      "Keskin",
      "Merkez",
      "Sulakyurt",
      "Bahşili",
      "Balışeyh",
      "Çelebi",
      "Karakeçili",
      "Yahşihan"
    ]
  },
  {
    "il": "Batman",
    "plaka": 72,
    "ilceleri": [
      "Merkez",
      "Beşiri",
      "Gercüş",
      "Kozluk",
      "Sason",
      "Hasankeyf"
    ]
  },
  {
    "il": "Şırnak",
    "plaka": 73,
    "ilceleri": [
      "Beytüşşebap",
      "Cizre",
      "İdil",
      "Silopi",
      "Merkez",
      "Uludere",
      "Güçlükonak"
    ]
  },
  {
    "il": "Bartın",
    "plaka": 74,
    "ilceleri": [
      "Merkez",
      "Kurucaşile",
      "Ulus",
      "Amasra"
    ]
  },
  {
    "il": "Ardahan",
    "plaka": 75,
    "ilceleri": [
      "Merkez",
      "Çıldır",
      "Göle",
      "Hanak",
      "Posof",
      "Damal"
    ]
  },
  {
    "il": "Iğdır",
    "plaka": 76,
    "ilceleri": [
      "Aralık",
      "Merkez",
      "Tuzluca",
      "Karakoyunlu"
    ]
  },
  {
    "il": "Yalova",
    "plaka": 77,
    "ilceleri": [
      "Merkez",
      "Altınova",
      "Armutlu",
      "Çınarcık",
      "Çiftlikköy",
      "Termal"
    ]
  },
  {
    "il": "Karabük",
    "plaka": 78,
    "ilceleri": [
      "Eflani",
      "Eskipazar",
      "Merkez",
      "Ovacık",
      "Safranbolu",
      "Yenice"
    ]
  },
  {
    "il": "Kilis",
    "plaka": 79,
    "ilceleri": [
      "Merkez",
      "Elbeyli",
      "Musabeyli",
      "Polateli"
    ]
  },
  {
    "il": "Osmaniye",
    "plaka": 80,
    "ilceleri": [
      "Bahçe",
      "Kadirli",
      "Merkez",
      "Düziçi",
      "Hasanbeyli",
      "Sumbas",
      "Toprakkale"
    ]
  },
  {
    "il": "Düzce",
    "plaka": 81,
    "ilceleri": [
      "Akçakoca",
      "Merkez",
      "Yığılca",
      "Cumayeri",
      "Gölyaka",
      "Çilimli",
      "Gümüşova",
      "Kaynaşlı"
    ]
  }
]""";
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
    "brans": "Paradal-Serey",
    "no": 151,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Paten",
    "no": 152,
    "mevki": [
      "Patenci"
    ]
  },
  {
    "brans": "Parasail",
    "no": 153,
    "mevki": [
      "Sörfçü"
    ]
  },
  {
    "brans": "Pencak-Silat",
    "no": 154,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Pentatlon",
    "no": 155,
    "mevki": [
      "Pentatlon"
    ]
  },
  {
    "brans": "Picigin",
    "no": 156,
    "mevki": [
      "Sporcu"
    ]
  },
  {
    "brans": "Pencak-Sılat",
    "no": 157,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Rafting",
    "no": 158,
    "mevki": [
      "Rafting"
    ]
  },
  {
    "brans": "Resim",
    "no": 159,
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
    "no": 160,
    "mevki": [
      "Sörfçü"
    ]
  },
  {
    "brans": "Sanguchi",
    "no": 161,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Sambo",
    "no": 162,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Satranç",
    "no": 163,
    "mevki": [
      "Farketmez",
      "Süreli",
      "Süresiz"
    ]
  },
  {
    "brans": "Shorinji-Kampo",
    "no": 164,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Sınav-Hazırlık",
    "no": 165,
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
    "no": 166,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Sip-Kwon-Do",
    "no": 167,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Sayokan",
    "no": 168,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Sit-Down-Hydrofoil",
    "no": 169,
    "mevki": [
      "Sporcu"
    ]
  },
  {
    "brans": "Su-Topu",
    "no": 170,
    "mevki": [
      "Farketmez",
      "Kaleci",
      "Oyuncu"
    ]
  },
  {
    "brans": "Sumo",
    "no": 171,
    "mevki": [
      "Sumo"
    ]
  },
  {
    "brans": "Systema",
    "no": 172,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Sörf",
    "no": 173,
    "mevki": [
      "Sörfçü"
    ]
  },
  {
    "brans": "Skimboard",
    "no": 174,
    "mevki": [
      "Sörfçü"
    ]
  },
  {
    "brans": "Şnorkel-Dalışı",
    "no": 175,
    "mevki": [
      "Dalışçı"
    ]
  },
  {
    "brans": "Tai-Chai",
    "no": 176,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Taekyon",
    "no": 177,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Taekwon-Do",
    "no": 178,
    "mevki": [
      "Taekwon-Do"
    ]
  },
  {
    "brans": "Tırmanış",
    "no": 179,
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
    "no": 180,
    "mevki": [
      "Trekking"
    ]
  },
  {
    "brans": "Triatlon",
    "no": 181,
    "mevki": [
      "Triatlon"
    ]
  },
  {
    "brans": "Tüplü-Dalış",
    "no": 182,
    "mevki": [
      "Dalışçı"
    ]
  },
  {
    "brans": "Valorant",
    "no": 183,
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
    "no": 184,
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
    "no": 185,
    "mevki": [
      "Yelken"
    ]
  },
  {
    "brans": "Yazılım",
    "no": 186,
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
    "no": 187,
    "mevki": [
      "Farketmez",
      "Serbest",
      "Kurbağalama",
      "Kelebekleme",
      "Sırtüstü",
      "Karışık"
    ]
  },
  {
    "brans": "Waboba",
    "no": 188,
    "mevki": [
      "Waboba"
    ]
  },
  {
    "brans": "Wing-Chun",
    "no": 189,
    "mevki": [
      "Farketmez"
    ]
  },
  {
    "brans": "Xingyiquan",
    "no": 190,
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
    "sex": "Erkek",
    "x": 1001
  },
  {
    "sex": "Kadın",
    "x": 1002    
  }
]""";
