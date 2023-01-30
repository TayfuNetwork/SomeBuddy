import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:version1/control_pages/statuPage.dart';

import '../control_pages/myDrawer.dart';

class usage extends StatelessWidget {
  const usage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: createStatuPage(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          drawer: MyDrawer(),
          appBar: AppBar(
            toolbarHeight: 80,
            elevation: 0,
            backgroundColor: Colors.black12,
            title: Center(child: Text("UsageAppbarTitle".tr())),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(vertical: 10),
              margin: const EdgeInsets.all(8),
              color: Colors.black.withOpacity(0),
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
                          Text(
                            "kullaniciOturum".tr(),
                            style: TextStyle(fontSize: 18),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("ProfilSayfasinda".tr()),
                          ),
                          Text(
                            "SolAcilirMenu".tr(),
                            style: TextStyle(fontSize: 18),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("BuMenuAraciligi".tr()),
                          ),
                          Text(
                            "BilgileriniDoldurma".tr(),
                            style: TextStyle(fontSize: 18),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("KarsisinaCikan".tr()),
                          ),
                          Text(
                            "UsageAramaSayfasi".tr(),
                            style: TextStyle(fontSize: 18),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("BySayfaHangi".tr()),
                          ),
                          Text(
                            "UsageAramaSonuclari".tr(),
                            style: TextStyle(fontSize: 18),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("BuSayfaGirilen".tr()),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Kapat'.tr(),
                                  style: TextStyle(color: Colors.red),
                                )),
                          )
                        ],
                      )),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
