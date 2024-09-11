import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gorev_yap_kazan_flutter/Sayfalar/Oturum/Auth/auth.service.dart';
import 'package:gorev_yap_kazan_flutter/Sayfalar/anasayfa.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gorev_yap_kazan_flutter/Servis/google_ads.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'Sayfalar/Oturum/giris.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserProvider()),
      ChangeNotifierProvider(create: (context) => UpdateUser()),
      ChangeNotifierProvider(create: (context) => GoogleAds()),
    ],
    child: const MyOldApp(),
  ));
}

class MyOldApp extends StatefulWidget {
  const MyOldApp({super.key});

  @override
  State<MyOldApp> createState() => _MyOldAppState();
}

class _MyOldAppState extends State<MyOldApp> {
  final GoogleAds _googleAds = GoogleAds();
  var isLogin = false;

  checkIfLogin() async {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        setState(() {
          isLogin = false;
        });
      } else {
        setState(() {
          isLogin = true;
        });
      }
    });
  }

  @override
  void initState() {
    _googleAds.loadBannerAd(
      adLoaded: () {},
    );
    _googleAds.showInterstitialAd();
    checkIfLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return Column(
          children: [
            Expanded(child: child!),
            if (_googleAds.bannerAd != null)
              Container(
                decoration: const BoxDecoration(color: Colors.white),
                width: 468,
                height: 60,
                child: AdWidget(ad: _googleAds.bannerAd!),
              ),
          ],
        );
      },
      title: 'Görevle Kazan',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
      home: isLogin == true ? const AnaSayfa() : const LoginPage(),
    );
  }
}
