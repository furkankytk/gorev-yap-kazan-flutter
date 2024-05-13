import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gorev_yap_kazan_flutter/Sabitler/ext.dart';
import 'package:gorev_yap_kazan_flutter/Sayfalar/CustomAppBar-Drawer/custom.appbar-drawer.dart';

class OdemeTalebiPage extends StatefulWidget {
  const OdemeTalebiPage({super.key});

  @override
  State<OdemeTalebiPage> createState() => _OdemeTalebiPageState();
}

class _OdemeTalebiPageState extends State<OdemeTalebiPage> {
  String? hesapbilgisi;
  String dropdownValue = "Papara Numaranızı Girin";
  int? coindegeri;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: arka_plan_renk,
        appBar: const CustomAppBar(appbartitle: "Ödeme Talebi"),
        drawer: const CustomDrawer(),
        body: Column(
          children: [
            Container(
              height: 100,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.blue.shade600,
                  borderRadius: BorderRadius.circular(30)),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/payment.png"),
                    const SizedBox(width: 5),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("EMEĞİNİZ GÜVENDE",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            )),
                        Expanded(
                          child: Text(
                            "İşlemi onayladığınızda bakiyeniz ve\nbilgileriniz güvenli bir şekilde kaydedilir.",
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
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 56.0,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: arka_plan_renk,
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Ödeme Yöntemi Seç",
                                          style: TextStyle(fontSize: 16)),
                                      DropdownButton<String>(
                                        dropdownColor: Colors.black,
                                        value: dropdownValue,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownValue = newValue!;
                                          });
                                        },
                                        items: const [
                                          DropdownMenuItem<String>(
                                            value: "Papara Numaranızı Girin",
                                            child: Text("Papara"),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: "IBAN Numaranızı Girin",
                                            child: Text("Banka"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              TextField(
                                onChanged: (value) {
                                  hesapbilgisi = value;
                                },
                                keyboardType: TextInputType.text,
                                maxLength: 35,
                                decoration: customInputDecoration(
                                    labelText: dropdownValue,
                                    hintText: dropdownValue ==
                                            "Papara Numaranızı Girin"
                                        ? "Örnek: 12345678910"
                                        : "Örnek: TR90 **** **** **** **** **** **"),
                              ),
                              const SizedBox(height: 5),
                              TextField(
                                onChanged: (value) {
                                  try {
                                    coindegeri = int.parse(value);
                                  } catch (e) {}
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                keyboardType: TextInputType.number,
                                decoration: customInputDecoration(
                                    labelText:
                                        "Çekmek İstediğiniz Coin Değerini Girin",
                                    hintText:
                                        "En az 5000 coin olabilir! (1000 coin = 1 TL)"),
                              ),
                              const SizedBox(height: 12),
                              const Center(
                                  child: Text(
                                "Minimum Ödeme Tutarı: 5000 Coin (5 TL)",
                                style: TextStyle(color: Colors.black),
                              )),
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
                                    if (hesapbilgisi != null &&
                                        coindegeri != null) {
                                      if (coindegeri! < 5000) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Minimum ödeme tutarı 5000 coin (5 TL) olmalıdır!",
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                                backgroundColor: Colors.red));
                                      } else {
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
                                        final userRef = firestore
                                            .collection('Users')
                                            .doc(FirebaseAuth
                                                .instance.currentUser?.uid);
                                        DocumentSnapshot documentSnapshot =
                                            await userRef.get();
                                        Map<String, dynamic> userData =
                                            documentSnapshot.data()
                                                as Map<String, dynamic>;
                                        if (userData['coin'] == null) {
                                          Navigator.of(context).pop();
                                        } else {
                                          if (userData['coin'] < coindegeri) {
                                            Navigator.of(context).pop();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Yetersiz bakiye!",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                    backgroundColor:
                                                        Colors.red));
                                          } else {
                                            final firestore =
                                                FirebaseFirestore.instance;
                                            final tasksRef = firestore
                                                .collection('PayRequest');
                                            final newTask = {
                                              "user_uid": FirebaseAuth
                                                  .instance.currentUser?.uid,
                                              "odemeturu": dropdownValue,
                                              "kactl": coindegeri! / 1000,
                                              "hesapbilgisi": hesapbilgisi
                                            };
                                            await tasksRef.add(newTask);
                                            await DeleteCoin().deleteCoin(
                                                UpdateCoinValue: coindegeri!);
                                            Navigator.of(context).pushReplacement(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const OdemeTalebiPage()));

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: RichText(
                                                  text: const TextSpan(
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                      children: [
                                                    TextSpan(
                                                        text:
                                                            "Başarılı! Kontrolden sonra ödemeniz yapılacaktır. Sorunuz varsa Destek bölümüne yazabilirsiniz."),
                                                    TextSpan(
                                                        text:
                                                            "\nOrtalama 1-12 saat sürer.",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300)),
                                                  ])),
                                              backgroundColor: Colors.green,
                                            ));
                                          }
                                        }
                                      }
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
                                  child: Center(
                                    child: RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                        children: <TextSpan>[
                                          const TextSpan(
                                              text:
                                                  'Ödeme Talebini Onayla | Kazanç: '),
                                          TextSpan(
                                              text: coindegeri == null
                                                  ? "0 TL"
                                                  : "${(coindegeri! / 1000).toStringAsFixed(1)} TL",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                  ),
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

class DeleteCoin {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> deleteCoin({required int UpdateCoinValue}) async {
    final docRef = _firestore
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    await _firestore.runTransaction((transaction) async {
      final documentSnapshot = await transaction.get(docRef);
      final currentCoinValue = documentSnapshot.data()!['coin'] as int;
      final newCoinValue = currentCoinValue - UpdateCoinValue;
      transaction.update(docRef, {'coin': newCoinValue});
    });
  }
}
