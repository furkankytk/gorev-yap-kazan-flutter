import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gorev_yap_kazan_flutter/Sabitler/ext.dart';
import 'package:gorev_yap_kazan_flutter/Sayfalar/CustomAppBar-Drawer/custom.appbar-drawer.dart';

class CoinYuklePage extends StatefulWidget {
  const CoinYuklePage({super.key});

  @override
  State<CoinYuklePage> createState() => _CoinYuklePageState();
}

class _CoinYuklePageState extends State<CoinYuklePage> {
  int? paparano;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: arka_plan_renk,
        appBar: const CustomAppBar(appbartitle: "Coin Yükle"),
        drawer: const CustomDrawer(),
        body: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
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
                            const EdgeInsets.only(left: 5, right: 5),
                        child: Column(
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20),
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: arka_plan_renk,
                                    borderRadius: BorderRadius.circular(40),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.white70, blurRadius: 6),
                                    ]),
                                child: Column(
                                  children: [
                                    const Text("Adımları Takip Edin",
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                    RichText(
                                        text: TextSpan(
                                            style: const TextStyle(
                                                color: Colors.white),
                                            children: [
                                          const TextSpan(
                                            text:
                                                "1) Paparaya girin ve para transfer kısmına gelin\n\n",
                                          ),
                                          TextSpan(
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () async {
                                                  await Clipboard.setData(
                                                      const ClipboardData(
                                                          text: "X"));
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              "Başarıyla kopyalandı!",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                          backgroundColor:
                                                              Colors.green));
                                                },
                                              text:
                                                  "2) X papara numaralı hesaba para yükleyin (Kopyalamak için uzun basın). Her yüklediğiniz 1 TL'den 1000 coin kazandırır.\n\n"),
                                          TextSpan(
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () async {
                                                await Clipboard.setData(
                                                    ClipboardData(
                                                        text: FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            "Başarıyla kopyalandı!",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                        backgroundColor:
                                                            Colors.green));
                                              },
                                            text:
                                                "3) Para transferi yaparken açıklama kısmına şu kodu yazın: ${FirebaseAuth.instance.currentUser?.uid} (Kopyalamak için uzun basın)\n\n",
                                          ),
                                          const TextSpan(
                                            text:
                                                "4) Neredeyse bitmek üzere. Aşağıdaki 'Papara Numaranızı Girin' kısmını doldurun ve tamamlayın.",
                                          ),
                                        ])),
                                  ],
                                )),
                            TextField(
                              onChanged: (value) {
                                try {
                                  paparano = int.parse(value);
                                } catch (e) {}
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              decoration: customInputDecoration(
                                  labelText: "Papara Numaranızı Girin",
                                  hintText: "Örnek: 12345678910"),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              height: 46,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.green,
                              ),
                              child: InkWell(
                                onTap: () async {
                                  if (paparano != null) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      },
                                    );

                                    final firestore =
                                        FirebaseFirestore.instance;
                                    final tasksRef =
                                        firestore.collection('CoinYukle');
                                    final newTask = {
                                      "user_uid": FirebaseAuth
                                          .instance.currentUser?.uid,
                                      "paparano": paparano,
                                    };
                                    await tasksRef.add(newTask);
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const CoinYuklePage()));

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: RichText(
                                          text: const TextSpan(
                                              style: TextStyle(
                                                  color: Colors.white),
                                              children: [
                                            TextSpan(
                                                text:
                                                    "Başarılı! Kontroller bitince coin hesabınıza yatacaktır"),
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
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Eksik bilgileri lütfen tamamlayın!",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            backgroundColor: Colors.red));
                                  }
                                },
                                child: const Center(child: Text("Tamamla")),
                              ),
                            )
                          ],
                        )),
                  )),
            ),
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