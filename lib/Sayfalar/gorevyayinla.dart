import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gorev_yap_kazan_flutter/Sabitler/ext.dart';
import 'package:gorev_yap_kazan_flutter/Sayfalar/CustomAppBar-Drawer/custom.appbar-drawer.dart';

class GorevYayinlaPage extends StatefulWidget {
  const GorevYayinlaPage({super.key});

  @override
  State<GorevYayinlaPage> createState() => _GorevYayinlaPageState();
}

class _GorevYayinlaPageState extends State<GorevYayinlaPage> {
  String? baslik;
  String? aciklama;
  String dropdownValue = "Youtube";
  int? fiyat;
  int? sayi;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: arka_plan_renk,
        appBar: const CustomAppBar(appbartitle: "Görev Yayınla"),
        drawer: const CustomDrawer(),
        body: Column(
          children: [
            Container(
              height: 100,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.orange.shade700,
                  borderRadius: BorderRadius.circular(30)),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/information.png"),
                    const SizedBox(width: 5),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("BİLGİLENDİRME",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            )),
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: 'Yeterli coin yoksa '),
                              TextSpan(
                                  text: 'Coin Yükle',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600)),
                              TextSpan(
                                  text: ' sayfasından \nsatın alabilirsiniz.'),
                            ],
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
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[A-Za-z0-9-\s]')),
                                ],
                                keyboardType: TextInputType.text,
                                maxLength: 35,
                                decoration: customInputDecoration(
                                    labelText: "Başlık",
                                    hintText: "Örnek: Video izle ve like At"),
                              ),
                              const SizedBox(height: 5),
                              TextField(
                                onChanged: (value) {
                                  aciklama = value;
                                },
                                keyboardType: TextInputType.multiline,
                                maxLines: 10,
                                maxLength: 300,
                                decoration: customInputDecoration(
                                    labelText: "Görevi Açıklayın",
                                    hintText:
                                        "Örnek: \n1- Youtube/Dexpery Beta kanalına git \n2- Son videoya tıkla \n3- Videoya like at ve ekran görüntüsü al"),
                              ),
                              const SizedBox(height: 5),
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
                                      const Text("Kategori Seç",
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
                                            value: "Youtube",
                                            child: Text("Youtube"),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: "İnstagram",
                                            child: Text("İnstagram"),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: "Tiktok",
                                            child: Text("Tiktok"),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: "X-Twitter",
                                            child: Text("X (Twitter)"),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: "PlayStore",
                                            child: Text("Play Store"),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: "Google",
                                            child: Text("Google Chrome"),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: "Diğer",
                                            child: Text("Diğer"),
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
                                  try {
                                    fiyat = int.parse(value);
                                  } catch (e) {}
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                keyboardType: TextInputType.number,
                                decoration: customInputDecoration(
                                    labelText: "Kişi Başı Ücret",
                                    hintText:
                                        "En az 300 coin olabilir"),
                              ),
                              const SizedBox(height: 12),
                              TextField(
                                onChanged: (value) {
                                  try {
                                    sayi = int.parse(value);
                                  } catch (e) {}
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                keyboardType: TextInputType.number,
                                decoration: customInputDecoration(
                                    labelText: "Görevi Kaç Kişi Yapacak",
                                    hintText: "Örnek: 100"),
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
                                    if (aciklama != null &&
                                        baslik != null &&
                                        sayi != null &&
                                        fiyat != null) {
                                      if (fiyat! < 300) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Kişi başı ücret en az 300 coin olabilir!",
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
                                          if (userData['coin'] <
                                              fiyat! * sayi!) {
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
                                                .collection('TasksRequest');
                                            final newTask = {
                                              "baslik": baslik,
                                              "aciklama": aciklama,
                                              "kategori": dropdownValue,
                                              "fiyat": fiyat,
                                              "sayi": sayi
                                            };
                                            await tasksRef.add(newTask);
                                            await DeleteCoin().deleteCoin(
                                                UpdateCoinValue:
                                                    fiyat! * sayi!);
                                            Navigator.of(context).pushReplacement(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const GorevYayinlaPage()));

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "İşlem başarılı! Göreviniz onaylandıktan sonra yayınlanacaktır. Aklınıza soru takılırsa Destek bölümüne yazabilirsiniz.",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                    backgroundColor:
                                                        Colors.green));
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
                                              text: 'Görevi Yayınla | Ücret: '),
                                          TextSpan(
                                              text:
                                                  "${fiyat != null && sayi != null ? fiyat! * sayi! : 0}",
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
