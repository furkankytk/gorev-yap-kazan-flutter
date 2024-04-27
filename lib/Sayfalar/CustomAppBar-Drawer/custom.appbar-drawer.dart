import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gorev_yap_kazan_flutter/Admin/adminportal.dart';
import 'package:gorev_yap_kazan_flutter/Sabitler/ext.dart';
import 'package:gorev_yap_kazan_flutter/Sayfalar/AwesomeDialogs/awesomeDialogs.dart';
import 'package:gorev_yap_kazan_flutter/Sayfalar/CustomSnakeBar/customsnakebar.dart';
import 'package:gorev_yap_kazan_flutter/Sayfalar/Oturum/Auth/auth.service.dart';
import 'package:gorev_yap_kazan_flutter/Sayfalar/anasayfa.dart';
import 'package:gorev_yap_kazan_flutter/Sayfalar/coinyukle.dart';
import 'package:gorev_yap_kazan_flutter/Sayfalar/destek.dart';
import 'package:gorev_yap_kazan_flutter/Sayfalar/notification.dart';
import 'package:gorev_yap_kazan_flutter/Sayfalar/gorevyayinla.dart';
import 'package:gorev_yap_kazan_flutter/Sayfalar/odemetalebi.dart';
import 'package:gorev_yap_kazan_flutter/Sayfalar/sikcasorulansorular.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.appbartitle})
      : preferredSize = const Size.fromHeight(kToolbarHeight);
        final String appbartitle;


  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool isThereNotification = false;
  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      List<dynamic> data = documentSnapshot["Notifications"] as List<dynamic>;
      if (data.isEmpty) {
        isThereNotification = false;
      } else {
        isThereNotification = true;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Row(
            children: [
              Icon(Icons.notifications_active_outlined, weight: 30),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Aktif bildiriminiz var. Sağ üsttteki bildirim iconundan mesajınıza erişebilirsiniz.",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
          backgroundColor: Color.fromARGB(255, 210, 126, 0),
        ));
      }

      setState(() {
        isThereNotification;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final UserProvider userProvider = Provider.of(context, listen: false);

      userProvider.getUserInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return AppBar(
      titleSpacing: 0.0,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(widget.appbartitle),
      leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu)),
      actions: <Widget>[
        InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackbar(text: "1000 coin = 1 TL", deger: 1));
          },
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: arka_plan_renk_coin,
            ),
            child: Row(children: [
              Image.asset("assets/coin.png", width: 20),
              const SizedBox(width: 3),
              Text(
                  "${userProvider.userSnapshot?.data()?["coin"] ?? "Yükleniyor"}"),
            ]),
          ),
        ),
        IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const NotificationsPage()));
            },
            icon: Icon(
                isThereNotification == false
                    ? Icons.notifications_none_outlined
                    : Icons.notifications_active_outlined,
                color: isThereNotification == false
                    ? Colors.white
                    : Colors.yellow)),
      ],
    );
  }
}

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final UserProvider userProvider = Provider.of(context, listen: false);

      userProvider.getUserInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName:
                Text("${userProvider.userSnapshot?.data()?["username"] ?? ""}"),
            accountEmail:
                Text("${userProvider.userSnapshot?.data()?["email"] ?? ""}"),
            currentAccountPicture: const CircleAvatar(
              child: Icon(Icons.account_circle, size: 60),
            ),
          ),
          ListTile(
            title: const Text("Anasayfa"),
            leading: const Icon(Icons.home),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const AnaSayfa()));
            },
          ),
          ListTile(
            title: const Text("Ödeme Talebi"),
            leading: const Icon(Icons.payment),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const OdemeTalebiPage()));
            },
          ),
          ListTile(
            title: const Text("Görev Yayınla"),
            leading: const Icon(Icons.task_alt),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const GorevYayinlaPage()));
            },
          ),
          ListTile(
            title: const Text("Destek"),
            leading: const Icon(Icons.support_agent_outlined),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const DestekPage()));
            },
          ),
          ListTile(
            title: const Text("Sıkça Sorulan Sorular"),
            leading: const Icon(Icons.help_outline),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SikcaSorulanSorularPage()));
            },
          ),
          ListTile(
            title: const Text("Coin Yükle"),
            leading: const Icon(Icons.shopping_bag_outlined),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CoinYuklePage()));
            },
          ),
          ListTile(
            title: const Text("Çıkış Yap"),
            leading: const Icon(Icons.logout_outlined),
            onTap: () {
              cikisYapButon(context);
            },
          ),
          ListTile(
            title: const Text("Admin Panel"),
            leading: const Icon(Icons.admin_panel_settings),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const AdminPortal()));
            },
          ),
        ],
      ),
    );
  }
}
