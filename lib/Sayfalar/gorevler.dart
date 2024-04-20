import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gorev_yap_kazan_flutter/Sabitler/ext.dart';
import 'package:gorev_yap_kazan_flutter/Sayfalar/CustomAppBar-Drawer/custom.appbar-drawer.dart';
import 'package:gorev_yap_kazan_flutter/Sayfalar/gorevdetay.dart';

class GorevlerPage extends StatefulWidget {
  const GorevlerPage({super.key});

  @override
  State<GorevlerPage> createState() => _GorevlerPageState();
}

class _GorevlerPageState extends State<GorevlerPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: arka_plan_renk,
        appBar: CustomAppBar(),
        drawer: const CustomDrawer(),
        body: Column(
          children: [
            Container(
              height: 100,
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              decoration: BoxDecoration(
                  color: bilgi_karti_renk2,
                  borderRadius: BorderRadius.circular(30)),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/warning.png"),
                    const SizedBox(width: 5),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("UYARI",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            )),
                        Text(
                          "Eksik veya yanlış yapılan görevlerin \nödemesi yapılmaz!",
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
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Tasks')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Text("Hata",
                            style: TextStyle(color: Colors.black));
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final gorev = snapshot.data!.docs[index];
                              final yapanlar =
                                  gorev['yapanlar'] as List<dynamic>;

                              if (!yapanlar.contains(
                                      FirebaseAuth.instance.currentUser?.uid) &&
                                  gorev["sayı"] > 0) {
                                return InkWell(
                                  onTap: () {
                                    final kullaniciId =
                                        FirebaseAuth.instance.currentUser?.uid;
                                    final gorevId =
                                        snapshot.data!.docs[index].id;
                                    final String gorevBaslik =
                                        snapshot.data!.docs[index]["başlık"];
                                    final String gorevAciklama =
                                        snapshot.data!.docs[index]["açıklama"];
                                    final int gorevFiyat =
                                        snapshot.data!.docs[index]["fiyat"];
                                    final String gorevKategori =
                                        snapshot.data!.docs[index]["kategori"];
                                    final int gorevSayi =
                                        snapshot.data!.docs[index]["sayı"];
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GorevDetayPage(
                                            gorevId: gorevId,
                                            gorevAciklama: gorevAciklama,
                                            gorevBaslik: gorevBaslik,
                                            gorevFiyat: gorevFiyat,
                                            gorevKategori: gorevKategori,
                                            gorevSayi: gorevSayi,
                                            kullaniciId: kullaniciId),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.only(
                                        left: 5, right: 5, top: 5),
                                    decoration: BoxDecoration(
                                      color: arka_plan_renk,
                                      border: Border.all(
                                          color: arka_plan_renk, width: 2),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/${snapshot.data!.docs[index]["kategori"]}.png"),
                                              fit: BoxFit.fill,
                                            ),
                                            color: arka_plan_renk,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          width: 50,
                                          height: 50,
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${snapshot.data!.docs[index]["başlık"]}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                        "assets/coin.png",
                                                        width: 20),
                                                    const SizedBox(width: 2),
                                                    Text(
                                                        "${snapshot.data!.docs[index]["fiyat"]}"),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            child: IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                  Icons.chevron_right),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                              return const SizedBox();
                            });
                      }
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}