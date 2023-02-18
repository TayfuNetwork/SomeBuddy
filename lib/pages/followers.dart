import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:version1/pages/show.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class Followers extends StatefulWidget {
  Followers({super.key});

  @override
  State<Followers> createState() => _FollowersState();
}

@override
void initState() {
  AuthService().user!;
}

@override
void dispose() {
  AuthService().user!;
}

class _FollowersState extends State<Followers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 220, 222, 238),
                Color.fromARGB(255, 76, 65, 147)
              ], end: Alignment.topRight, begin: Alignment.bottomRight),
              color: Color.fromARGB(255, 163, 215, 231)),
          child: Column(
            children: [
              StreamBuilder(
                  stream: getTakipciler(AuthService().user!.id!),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Text("Hiç hobidaşınız yok".tr(),
                          style: TextStyle(color: Colors.white));
                    }
                    if (snapshot.data.data() != null) {
                      MyUser user = MyUser.fromMap(snapshot.data.data()!);

                      return Expanded(
                        child: ListView(
                            children: user.takip!.map((u) {
                          return FutureBuilder<
                                  DocumentSnapshot<Map<String, dynamic>>>(
                              future: getUser(u),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data!.data() != null) {
                                    MyUser izlenen =
                                        MyUser.fromMap(snapshot.data!.data()!);
                                    ImageProvider _havePhoto() {
                                      if (izlenen.image != null) {
                                        return NetworkImage(
                                          izlenen.image!,
                                        );
                                      } else {
                                        return const AssetImage(
                                            "images/logo.png");
                                      }
                                    }

                                    return Column(
                                      children: [
                                        ListTile(
                                          title: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                Text(
                                                  "${izlenen.userName} ${izlenen.soyisim} -",
                                                  style: GoogleFonts.lato(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontSize: 12),
                                                ),
                                                izlenen.il != null
                                                    ? Text(
                                                        "${izlenen.il} ${izlenen.brans} -",
                                                        style:
                                                            GoogleFonts.aBeeZee(
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                fontSize: 12),
                                                      )
                                                    : Text(
                                                        "Kayıt yok",
                                                        style: GoogleFonts.lato(
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontSize: 12,
                                                            color: Colors.grey),
                                                      ),
                                              ],
                                            ),
                                          ),
                                          leading: CircleAvatar(
                                            backgroundImage: _havePhoto(),
                                            backgroundColor: Colors.grey,
                                          ),
                                          subtitle: SingleChildScrollView(
                                              child: Text(
                                            izlenen.bio!,
                                            style: GoogleFonts.lato(
                                                fontStyle: FontStyle.italic,
                                                fontSize: 16,
                                                color: Colors.white),
                                          )),
                                          trailing: Icon(
                                            Icons.question_mark,
                                            size: 12,
                                          ),
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(CupertinoPageRoute(
                                                    builder: (context) => show(
                                                          whoData: izlenen,
                                                        )));
                                          },
                                        )
                                      ],
                                    );
                                  }

                                  return CircularProgressIndicator();
                                }

                                return CircularProgressIndicator();
                              });
                        }).toList()),
                      );
                    }
                    return Text(
                      "Hiç hobidaşınız yok".tr(),
                      style: TextStyle(color: Colors.white),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

Future<DocumentSnapshot<Map<String, dynamic>>> getUser(String u) {
  return FirebaseFirestore.instance.collection("Users").doc(u).get();
}

Stream getTakipciler(String currentUserID) {
  return FirebaseFirestore.instance
      .collection("Users")
      .doc(currentUserID)
      .snapshots(includeMetadataChanges: false);
}
