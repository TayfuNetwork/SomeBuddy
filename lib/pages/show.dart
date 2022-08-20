import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class show extends StatefulWidget {
  const show({Key? key}) : super(key: key);

  @override
  State<show> createState() => _showState();
}

class _showState extends State<show> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profili'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              const Center(
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  backgroundImage: AssetImage("images/top.jpg"),
                  radius: 75,
                ),
              ),
              const SizedBox(width: 8),
              const ListTile(
                textColor: Colors.black,
                title: Text(
                  "Tayfun Kaya",
                  style: TextStyle(color: Colors.white),
                ),
                leading: CircleAvatar(
                  child: Text(
                    "29",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  backgroundColor: Colors.blue,
                ),
                subtitle: Text(
                  "Artvin/Borçka - Yazılım/Flutter",
                  style: TextStyle(color: Colors.blue),
                ),
                trailing: Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 18),
              const Divider(
                height: 2,
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                    'Biografim burada yer alıyor. Uygulamanın sahibiyim, tasarımcısıyım ve de geri kalan her şeyiyim.'),
              ),
              const Divider(
                height: 2,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Bana ait bazı fotoğraflar aşağıdadır.',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(color: Colors.grey, blurRadius: 6),
                      ]),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      child: Row(
                        children: const [
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            backgroundImage: AssetImage("images/top.jpg"),
                            radius: 75,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            backgroundImage: AssetImage("images/top.jpg"),
                            radius: 75,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            backgroundImage: AssetImage("images/top.jpg"),
                            radius: 75,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            backgroundImage: AssetImage("images/top.jpg"),
                            radius: 75,
                          ),
                        ],
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
