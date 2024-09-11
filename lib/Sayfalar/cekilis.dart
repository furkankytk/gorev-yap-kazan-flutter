import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gorev_yap_kazan_flutter/Sabitler/ext.dart';
import 'package:gorev_yap_kazan_flutter/Sayfalar/CustomAppBar-Drawer/custom.appbar-drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class CekilisPage extends StatefulWidget {
  const CekilisPage({super.key});

  @override
  State<CekilisPage> createState() => _CekilisPageState();
}

class _CekilisPageState extends State<CekilisPage> {
  String? aciklama;
  String? baslik;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: arka_plan_renk,
        appBar: const CustomAppBar(appbartitle: "Haftalık Çekilişler"),
        drawer: const CustomDrawer(),
        body: Column(
          children: [
            Container(
              height: 120,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.yellow.shade900,
                  borderRadius: BorderRadius.circular(30)),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/giveaway2.png"),
                    const SizedBox(width: 5),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("BİLGİLENDİRME",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            )),
                        Expanded(
                          child: Text(
                            "Çekilişlerde her 1000 katılımcıda\n12 kişiye 10.000 coin dağıtılır.\nKazandığınızda bildirim alacaksınız",
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
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Cekilisler')
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
                                  FirebaseAuth.instance.currentUser?.uid)) {
                                return InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        barrierColor:
                                            Colors.black.withOpacity(0.8),
                                        builder: (context) => SizedBox(
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Column(
                                                    children: [
                                                      const Text(
                                                          "ÇEKİLİŞE KATIL",
                                                          style: TextStyle(
                                                              fontSize: 25,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      const Divider(),
                                                      const SizedBox(
                                                          height: 20),
                                                      RichText(
                                                          text: TextSpan(
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                              children: [
                                                            const TextSpan(
                                                                text: "1) "),
                                                            const TextSpan(
                                                                text:
                                                                    "Çekiliş Sayfasına Git ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .green)),
                                                            const TextSpan(
                                                                text:
                                                                    "tuşuna bas,\n\n\n"),
                                                            const TextSpan(
                                                                text:
                                                                    "2) Açılan pencerede 'Kullanıcı ID' değerine şunu yaz: "),
                                                            TextSpan(
                                                                recognizer:
                                                                    TapGestureRecognizer()
                                                                      ..onTap =
                                                                          () async {
                                                                        await Clipboard.setData(ClipboardData(
                                                                            text:
                                                                                FirebaseAuth.instance.currentUser!.uid));
                                                                        Fluttertoast
                                                                            .showToast(
                                                                          msg:
                                                                              'Başarıyla kopyalandı',
                                                                          toastLength:
                                                                              Toast.LENGTH_SHORT,
                                                                          gravity:
                                                                              ToastGravity.BOTTOM,
                                                                          backgroundColor:
                                                                              Colors.black,
                                                                          textColor:
                                                                              Colors.white,
                                                                        );
                                                                        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                        //     content:
                                                                        //         Text("Başarıyla kopyalandı!", style: TextStyle(color: Colors.white)),
                                                                        //     backgroundColor: Colors.green));
                                                                      },
                                                                text:
                                                                    "${FirebaseAuth.instance.currentUser!.uid} ",
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .blue)),
                                                            TextSpan(
                                                                recognizer:
                                                                    TapGestureRecognizer()
                                                                      ..onTap =
                                                                          () async {
                                                                        await Clipboard.setData(ClipboardData(
                                                                            text:
                                                                                FirebaseAuth.instance.currentUser!.uid));
                                                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                            content:
                                                                                Text("Başarıyla kopyalandı!", style: TextStyle(color: Colors.white)),
                                                                            backgroundColor: Colors.green));
                                                                      },
                                                                text:
                                                                    "(Kopyalamak için uzun bas) ve çekilişe katıl,\n\n\n"),
                                                            const TextSpan(
                                                                text:
                                                                    "3) Çekilişe katıldıktan sonra "),
                                                            const TextSpan(
                                                                text:
                                                                    "Çekilişi Tamamladım ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .orange)),
                                                            const TextSpan(
                                                                text:
                                                                    "tuşuna bas."),
                                                          ])),
                                                      const SizedBox(
                                                          height: 30),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .green,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30)),
                                                            child: TextButton(
                                                              onPressed:
                                                                  () async {
                                                                final url = Uri
                                                                    .parse(snapshot
                                                                            .data!
                                                                            .docs[index]
                                                                        [
                                                                        "link"]);
                                                                await launchUrl(
                                                                    url,
                                                                    mode: LaunchMode
                                                                        .externalApplication);
                                                              },
                                                              child: const Text(
                                                                  'Çekiliş Sayfasına Git',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white)),
                                                            ),
                                                          ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .orange,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30)),
                                                            child: TextButton(
                                                              onPressed:
                                                                  () async {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return AlertDialog(
                                                                        content:
                                                                            const Text('Çekilişe katıldığınızı onaylıyor musunuz?'),
                                                                        actions: <Widget>[
                                                                          TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              YapanlarEkleme().updateYapanlar(cekilisId: snapshot.data!.docs[index].id);
                                                                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const CekilisPage()));
                                                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                                content: Text("Çekilişe başarıyla katıldınız", style: TextStyle(color: Colors.white)),
                                                                                backgroundColor: Colors.green,
                                                                              ));
                                                                            },
                                                                            child:
                                                                                const Text('Eminim, onaylıyorum', style: TextStyle(color: Colors.green)),
                                                                          ),
                                                                          TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                const Text('İptal', style: TextStyle(color: Colors.red)),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    });
                                                              },
                                                              child: const Text(
                                                                  'Çekilişi Tamamladım',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white)),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ));
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
                                            image: const DecorationImage(
                                              image: AssetImage(
                                                  "assets/Diğer.png"),
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
                                        const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Çekilişe Katılmak İçin Tıkla",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(Icons
                                                        .timelapse_outlined),
                                                    SizedBox(width: 2),
                                                    Text(
                                                        "Ortalama 10-30 saniye"),
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

class YapanlarEkleme {
  Future<void> updateYapanlar({required String cekilisId}) async {
// 'yapanlar' array'i içeren belge referansı
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('Cekilisler').doc(cekilisId);

// Eklemek istediğiniz yapıcıyı oluşturun
// Array'e yeni yapıcıyı ekleme
    await documentReference.update({
      'yapanlar':
          FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
    });
  }
}
