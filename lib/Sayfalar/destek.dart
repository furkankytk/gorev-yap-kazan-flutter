import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gorev_yap_kazan_flutter/Sabitler/ext.dart';
import 'package:gorev_yap_kazan_flutter/Sayfalar/CustomAppBar-Drawer/custom.appbar-drawer.dart';

class DestekPage extends StatefulWidget {
  const DestekPage({super.key});

  @override
  State<DestekPage> createState() => _DestekPageState();
}

class _DestekPageState extends State<DestekPage> {
  String? aciklama;
  String? baslik;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: arka_plan_renk,
        appBar: const CustomAppBar(appbartitle: "Destek"),
        drawer: const CustomDrawer(),
        body: Column(
          children: [
            Container(
              height: 100,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(30)),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/support.png"),
                    const SizedBox(width: 5),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("AKTİF DESTEK",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            )),
                        Expanded(
                          child: Text(
                            "Sorunlarınızı çözmek için buradayız.\nFormu doldurun ve sorunu çözelim",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        )),
                    child: SingleChildScrollView(
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          margin:
                              const EdgeInsets.only(left: 5, right: 5, top: 5),
                          child: Column(
                            children: [
                              TextField(
                                onChanged: (value) {
                                  baslik = value;
                                },
                                keyboardType: TextInputType.text,
                                maxLength: 35,
                                decoration: customInputDecoration(
                                    labelText: "Başlık",
                                    hintText: "Örnek: Uygulamada Hata Aldım"),
                              ),
                              const SizedBox(height: 5),
                              TextField(
                                onChanged: (value) {
                                  aciklama = value;
                                },
                                keyboardType: TextInputType.text,
                                minLines: 10,
                                maxLines: 30,
                                decoration: customInputDecoration(
                                    labelText: "Yaşadığınız Sorundan Bahsedin",
                                    hintText: ""),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                height: 46,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.green,
                                ),
                                child: InkWell(
                                  onTap: () async {
                                    if (baslik != null && aciklama != null) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        },
                                      );

                                      final firestore =
                                          FirebaseFirestore.instance;
                                      final tasksRef =
                                          firestore.collection('Support');
                                      final newTask = {
                                        "user_uid": FirebaseAuth
                                            .instance.currentUser?.uid,
                                        "baslik": baslik,
                                        "aciklama": aciklama,
                                      };
                                      await tasksRef.add(newTask);
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const DestekPage()));

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: RichText(
                                            text: const TextSpan(
                                                style: TextStyle(
                                                    color: Colors.white),
                                                children: [
                                              TextSpan(
                                                  text:
                                                      "Mesajınız İletildi! Ekibimiz aktif olduğunda size dönüş yapılacaktır"),
                                              TextSpan(
                                                  text:
                                                      "\nOrtalama 1-12 saat sürer.",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300)),
                                            ])),
                                        backgroundColor: Colors.green,
                                      ));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Eksik bilgileri lütfen tamamlayın!",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              backgroundColor: Colors.red));
                                    }
                                  },
                                  child: const Center(child: Text("Gönder")),
                                ),
                              )
                            ],
                          )),
                    ))),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names

  InputDecoration customInputDecoration(
      {required String labelText, required String hintText}) {
    return InputDecoration(
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        filled: true,
        fillColor: arka_plan_renk,
        counterStyle: const TextStyle(color: Colors.black),
        labelText: labelText,
        hintText: hintText,
        border: const OutlineInputBorder());
  }
}
