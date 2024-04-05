import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Color arka_plan_renk = const Color.fromARGB(255, 62, 64, 80);
Color arka_plan_renk_coin = const Color.fromARGB(10, 0, 0, 0);
Color bilgi_karti_renk = Color.fromARGB(255, 249, 70, 89);
Color kirmizi_renk = Color(0xFFCA0E1D);


alt_yazi(BuildContext context, String mesaj, {int tur = 0}) {
  ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(mesaj),
                    backgroundColor: tur==0?Colors.red:Colors.green,
                    duration: const Duration(seconds: 5),
                    ));
}

// bool oturum_kontol() {
//   GetStorage box = GetStorage();
//   var sonuc = box.read("kul");
// 
//   if (sonuc==null || sonuc.toString().length < 20) {
//     return false;
//   } else {
//     return true;
//   }
// }

class ButonSabitler {
  EdgeInsets paddingSabit = const EdgeInsets.only(top: 10, bottom: 10);
}