import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gorev_yap_kazan_flutter/Sabitler/ext.dart';
import 'package:gorev_yap_kazan_flutter/Sayfalar/CustomAppBar-Drawer/custom.appbar-drawer.dart';
import 'package:gorev_yap_kazan_flutter/Sayfalar/CustomSnakeBar/customsnakebar.dart';
import 'package:gorev_yap_kazan_flutter/Sayfalar/cekilis.dart';
import 'package:gorev_yap_kazan_flutter/Sayfalar/gorevler.dart';
import 'package:gorev_yap_kazan_flutter/Servis/google_ads.dart';
import 'package:gorev_yap_kazan_flutter/network_check.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  late ConnectivityService _connectivityService;
  final GoogleAds _googleAds = GoogleAds();
  @override
  void initState() {
    _googleAds.loadBannerAd(
      adLoaded: () {},
    );
    _googleAds.showInterstitialAd();
    super.initState();
    _connectivityService = ConnectivityService();
    _connectivityService.startListening(context);
  }

  @override
  void dispose() {
    _connectivityService.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: arka_plan_renk,
        appBar: const CustomAppBar(appbartitle: "Her Şeyle Kazan"),
        drawer: const CustomDrawer(),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: arka_plan_renk),
              height: 180,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MyWidget(
                      image: "saatliksandik.png",
                      color1: Colors.orangeAccent,
                      color2: Colors.orange.shade700,
                      text: "Saatlik Sandık",
                      sandik: "saatliksandik"),
                  MyWidget(
                    image: "günlüksandik.png",
                    color1: Colors.redAccent,
                    color2: Colors.red.shade700,
                    text: "Günlük Sandık",
                    sandik: "günlüksandik",
                  )
                ],
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
                child: Column(
                  children: [
                    anaSayfaSutunlar(
                        image: "assets/task.png",
                        text: "Görev Yap Kazan",
                        footer: "Minik bir görev tamamla ve anında kazan",
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const GorevlerPage()));
                        }),
                    anaSayfaSutunlar(
                        image: "assets/game.png",
                        text: "Oyun Oyna Kazan",
                        footer: "Oyun oynayarak hem eğlen hem de kazan",
                        onTap: () {
                          // SnackBar "Çok yakında sizlerle..."
                        }),
                    anaSayfaSutunlar(
                        image: "assets/browser.png",
                        text: "Web'te Kazan",
                        footer:
                            "Tarayıcıda istersen video izle istersen de haber oku. Sınırsız kazanç",
                        onTap: () {}),
                    anaSayfaSutunlar(
                        image: "assets/giveaway.png",
                        text: "Haftalık Çekilişler",
                        footer:
                            "Her hafta yenilenen çekilişlere katılarak kazan",
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const CekilisPage()));
                        }),
                  ],
                ),
              ),
            ),
            if (_googleAds.bannerAd != null)
              Container(
                decoration: const BoxDecoration(color: Colors.white),
                width: 468,
                height: 60,
                child: AdWidget(ad: _googleAds.bannerAd!),
              ),
          ],
        ),
      ),
    );
  }

  InkWell anaSayfaSutunlar(
      {required image,
      required text,
      required footer,
      required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(15),
        width: 400,
        height: 100,
        decoration: BoxDecoration(
          color: arka_plan_renk,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 5),
              child: SizedBox(
                width: 70,
                child: Image.asset(image),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                    width: 280,
                    child:
                        Text(footer, maxLines: 2, overflow: TextOverflow.clip)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  final String image;
  final Color color1;
  final Color color2;
  final String text;
  final String sandik;

  const MyWidget(
      {super.key,
      required this.image,
      required this.color1,
      required this.color2,
      required this.text,
      required this.sandik});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              color: Color(0xFF2D2F3A), offset: Offset(0, 4), blurRadius: 5)
        ],
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [widget.color1, widget.color2],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      height: 150,
      width: 190,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Image.asset(
              "assets/${widget.image}",
              width: 90,
            ),
            Expanded(
                child: Text(widget.text,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                              color: Colors.black,
                              offset: Offset(1.0, 2.0),
                              blurRadius: 5.0)
                        ]))),
            Expanded(
                child: ElevatedButton(
                    onPressed: () async {
                      if (widget.sandik == "günlüksandik") {
                        final now = DateTime.now();
                        final isRewardAvailable =
                            await _isDailyRewardAvailable(now);
                        await _saveLastLoginDate(now);
                        if (isRewardAvailable) {
                          ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(
                              text:
                                  "Günlük sandıktan 300 coin kazandınız. Yarın tekrardan açabilirsiniz.",
                              deger: 1));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(
                              text:
                                  "Günlük sandığı yarın tekrardan açabilirsiniz.",
                              deger: 0));
                        }
                      } else if (widget.sandik == "saatliksandik") {
                        DateTime? lastLoginTime;
                        bool canClaimReward;
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        String? lastLoginTimeString =
                            prefs.getString('lastLoginTime');
                        lastLoginTime = lastLoginTimeString != null
                            ? DateTime.parse(lastLoginTimeString)
                            : null;

                        if (lastLoginTime != null) {
                          Duration difference =
                              DateTime.now().difference(lastLoginTime);
                          if (difference.inHours >= 1) {
                            canClaimReward = true;
                          } else {
                            canClaimReward = false;
                          }
                        } else {
                          canClaimReward = true;
                        }

                        if (canClaimReward == true) {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString(
                              'lastLoginTime', DateTime.now().toString());

                          lastLoginTime = DateTime.now();
                          ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(
                              text:
                                  "Saatlik sandıktan 300 coin kazandınız, 1 saat sonra tekrardan açabilirsiniz.",
                              deger: 1));
                          canClaimReward = false;
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(
                              text:
                                  "Saatlik sandığı ${60 - DateTime.now().difference(lastLoginTime!).inMinutes} dakika sonra tekrardan açabilirsiniz.",
                              deger: 0));
                        }
                      } else {}
                    },
                    child: const Text("Sandık Aç",
                        style: TextStyle(color: Colors.white))))
          ],
        ),
      ),
    );
  }
}

Future<bool> _isDailyRewardAvailable(DateTime now) async {
  final prefs = await SharedPreferences.getInstance();
  String formattedDate = DateFormat('yyyy-MM-dd').format(now);
  String lastLoginDate = prefs.getString('lastLoginDate') ?? '';

  if (formattedDate != lastLoginDate) {
    return true;
  } else {
    return false;
  }
}

Future<void> _saveLastLoginDate(DateTime now) async {
  final prefs = await SharedPreferences.getInstance();
  String formattedDate = DateFormat('yyyy-MM-dd').format(now);
  await prefs.setString('lastLoginDate', formattedDate);
}
