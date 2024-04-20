import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gorev_yap_kazan_flutter/Sabitler/ext.dart';
import 'package:gorev_yap_kazan_flutter/Sayfalar/anasayfa.dart';
import 'package:gorev_yap_kazan_flutter/Sayfalar/Oturum/Auth/auth.service.dart';
import 'package:gorev_yap_kazan_flutter/Sayfalar/gorevler.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var isAdmin = false;

  checkIsAdmin() async {
      if (FirebaseAuth.instance.currentUser?.uid == "Ao5adB5INhZJAZu1zsBTYsigEIb2") {
      setState(() {
        isAdmin = true;
        });
      } else {
        setState(() {
        isAdmin = false;
        });
        }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: arka_plan_renk,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 80, bottom: 5),
                    child: const Text(
                      "Hoş geldin",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    )),
                const Text(
                  "Para kazanmaya başlamak için giriş yap.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 10),
                  child: Image.asset("assets/img1.png"),
                ),
                GestureDetector(
                      onTap: () async {
                        bool result = await AuthService().signInWithGoogle();
                        await checkIsAdmin();
                        if (isAdmin == true) {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                            // GorevlerPage yerine AdminPortal olacak
                              builder: (context) => const GorevlerPage()));
                        } else if (result) {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => const AnaSayfa()));
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color(0xFF2D2F3A),
                                  offset: Offset(0, 4),
                                  blurRadius: 5)
                            ]),
                        margin: const EdgeInsets.only(
                            bottom: 10, top: 20, left: 30, right: 30),
                        padding: ButonSabitler().paddingSabit,
                        child: const Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.google,
                                color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              "Google ile giriş yap",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        )),
                      ),
                    ),
                Container(
                    margin: const EdgeInsets.only(top: 30, bottom: 30),
                    child: const Text(
                      "Bilgi: Papara veya banka hesabı ile ödeme alabilirsiniz...",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
