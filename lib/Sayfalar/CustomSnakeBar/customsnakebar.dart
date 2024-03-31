import 'package:flutter/material.dart';

class CustomSnackbar extends SnackBar {
  CustomSnackbar({
    super.key,
    required String text,
    required int deger
  }) : super(
            content: Row(
              children: [
                Image.asset("assets/coin.png", width: 30),
                const SizedBox(width: 10),
                Expanded(child: Text(text, style: const TextStyle(color: Colors.white)))
              ],
            ),
            backgroundColor: deger == 0 ? Colors.red : Colors.green,
            
            action: SnackBarAction(
              label: "Kapat",
              textColor: Colors.white60,
              onPressed: () {},
            ));
}
