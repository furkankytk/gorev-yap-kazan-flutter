import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gorev_yap_kazan_flutter/Admin/adminpage.dart';
import 'package:gorev_yap_kazan_flutter/Sabitler/ext.dart';
import 'package:gorev_yap_kazan_flutter/Sayfalar/AwesomeDialogs/awesomeDialogs.dart';
import 'package:gorev_yap_kazan_flutter/Sayfalar/CustomSnakeBar/customsnakebar.dart';
import 'package:gorev_yap_kazan_flutter/Sayfalar/Oturum/Auth/auth.service.dart';
import 'package:gorev_yap_kazan_flutter/Sayfalar/anasayfa.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key})
      : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
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
    return AppBar(
      backgroundColor: Colors.transparent,
        elevation: 0,
      title: const Text("Görevle Kazan"),
      centerTitle: true,
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
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: arka_plan_renk_coin,
            ),
            child: Row(children: [
              Image.asset("assets/coin.png", width: 20),
              const SizedBox(width: 3),
              Text("${userProvider.userSnapshot?.data()?["coin"] ?? "Yükleniyor"}"),
            ]),
          ),
        )
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
            onTap: () {},
          ),
          ListTile(
            title: const Text("Görev Yayınla"),
            leading: const Icon(Icons.task_alt),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Destek"),
            leading: const Icon(Icons.help_outline),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Hata Bildir"),
            leading: const Icon(Icons.chat_bubble_outline_rounded),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Çıkış Yap"),
            leading: const Icon(Icons.logout_outlined),
            onTap: () {
              cikisYapButon(context);
            },
          ),
          ListTile(
            title: const Text("+999 Coin"),
            leading: const Icon(Icons.attach_money_outlined),
            onTap: () {
              Provider.of<UpdateUser>(context, listen: false)
                  .updateCoin(FirebaseAuth.instance.currentUser!.uid, 999);
            },
          ),
          ListTile(
            title: const Text("Admin Panel"),
            leading: const Icon(Icons.admin_panel_settings),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const AdminPage()));
            },
          ),
        ],
      ),
    );
  }
}