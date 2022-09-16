import 'package:flutter/material.dart';

class usage extends StatelessWidget {
  const usage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nasıl Kullanılır ?"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(vertical: 10),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(color: Colors.grey, blurRadius: 6),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: SingleChildScrollView(
              child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  margin: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 49, 48, 43),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(color: Colors.grey, blurRadius: 6),
                      ]),
                  child: Column(
                    children: [
                      const Text(
                        "Kullanıcı oturum açmıştır",
                        style: TextStyle(fontSize: 18),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            "Profil sayfasından bilgilerini doldurduktan sonra kendisini 'Bilgilerim' sayfası karşılar."),
                      ),
                      const Text(
                        "Sol açılır menü",
                        style: TextStyle(fontSize: 18),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            "Bu menü aracılığı ile mesajlarının bulunduğu sayfaya gidebilir, aynı şekilde 'Profil' butonuna tıklayarak aramalarda nasıl görüneceğini düzenleyebilir, profil resmi yükleyebilir, kendisini tanımlayabilir ve de galerisine yeni resimler ekleyebilir"),
                      ),
                      const Text(
                        "Bilgilerini doldurma",
                        style: TextStyle(fontSize: 18),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            " Karşısına çıkan açılır menüler aracılığı ile hangi şehirde, hangi hobi dalında aktif oluğunu belirtir ve 'Kaydet ve partner bul' butonuna tıklar. Kullanıcı bilgilerini girmek istemezse 'Gezinti' adlı butona tıklayarak sadece arama yapabilir veya kayıt yaptıktan hemen sonra karşısına çıkacak 'hobi kaydımı sil' butonuna basarak kaydını silebilir."),
                      ),
                      const Text(
                        "Arama sayfası",
                        style: TextStyle(fontSize: 18),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            "Bu sayfada hangi ilde, ne tür aktivitelerle ilgilenen insanları bulmak istediğini açılır menüler vasıtasıyla belirtir ve 'Ara' butonuna tıklar."),
                      ),
                      const Text(
                        "Arama sonuçları",
                        style: TextStyle(fontSize: 18),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            "Bu sayfada girilen kriterlere uygun eşleşmeler listelenir. Listelenen kullanıcının üstüne tıklayarak üyelerin profiline gidip kendisi hakkında daha fazla bilgiye ( Resimler ve biografisi ) ulaşabilirsiniz."),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Kapat',
                              style: TextStyle(color: Colors.red),
                            )),
                      )
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
