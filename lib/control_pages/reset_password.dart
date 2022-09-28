import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/background.png"), fit: BoxFit.cover)),
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "ParolaSifirlama".tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                   Text(
                    "BilgileriniPaylasma".tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.orange),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1)),
                      focusColor: Colors.blue,
                      hintText: 'Email',
                      enabled: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                        ),
                        onPressed: () {
                          resetPassword();
                        },
                        icon: const Icon(Icons.email_outlined),
                        label: Text(
                          'SifirlamaMailiGonder'.tr(),
                          style: TextStyle(fontSize: 18),
                        )),
                  )
                ],
              ))),
        ),
      );
  Future resetPassword() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          backgroundColor: Colors.blue,
          content: Text('SifirlamaGonderildi'.tr(),
              style: TextStyle(color: Colors.white))));
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blue,
          content: Text(e.message.toString(),
              style: const TextStyle(color: Colors.white))));
      Navigator.of(context).pop();
    }
  }
}
