import 'package:flutter/material.dart';
import 'package:gorev_yap_kazan_flutter/Admin/adminpage.dart';

class AdminPortal extends StatelessWidget {
  const AdminPortal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Admin Portal"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AdminPage()));
            }, child: const Text("Görev kanıtları")),
            ElevatedButton(onPressed: () {
              
            }, child: const Text("Görev yayınlama talepleri"))
          ],
        ),
      ),
    );
  }
}