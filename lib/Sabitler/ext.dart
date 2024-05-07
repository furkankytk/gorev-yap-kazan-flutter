import 'package:flutter/material.dart';

Color arka_plan_renk = const Color.fromARGB(255, 62, 64, 80);
Color arka_plan_renk_coin = const Color.fromARGB(10, 0, 0, 0);
Color bilgi_karti_renk = Color.fromARGB(255, 249, 70, 89);
Color kirmizi_renk = Color(0xFFCA0E1D);
Color bilgi_karti_renk2 = Color.fromARGB(255, 231, 39, 58);


alt_yazi(BuildContext context, String mesaj, {int tur = 0}) {
  ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(mesaj),
                    backgroundColor: tur==0?Colors.red:Colors.green,
                    duration: const Duration(seconds: 5),
                    ));
}

class ButonSabitler {
  EdgeInsets paddingSabit = const EdgeInsets.only(top: 10, bottom: 10);
}