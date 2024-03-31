import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gorev_yap_kazan_flutter/main.dart';

void cikisYapButon(BuildContext context) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.warning,
    animType: AnimType.topSlide,
    showCloseIcon: true,
    title: "DİKKAT",
    desc: "Çıkış yapmak istediğinize emin misiniz?",
    btnOkText: "İPTAL",
    btnCancelText: "ÇIKIŞ YAP",
    btnCancelOnPress: () async {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MyOldApp()));
    },
    btnOkOnPress: () {},
  ).show();
}