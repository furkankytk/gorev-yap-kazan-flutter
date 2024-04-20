// ignore_for_file: file_names

import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import 'package:gorev_yap_kazan_flutter/Admin/AdminDetayPage.dart';
import 'package:gorev_yap_kazan_flutter/Sabitler/ext.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  CollectionReference tasksref =
      FirebaseFirestore.instance.collection("TasksDone");
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Görev Kanıtları"),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: tasksref.get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Text("Hata");
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              final String gorevAciklama =
                                  snapshot.data?.docs[index]["gorevAciklama"];
                              final String gorevBaslik =
                                  snapshot.data?.docs[index]["gorevBaslik"];
                              final int gorevFiyat =
                                  snapshot.data?.docs[index]["gorevFiyat"];
                              final String gorevId =
                                  snapshot.data?.docs[index]["gorevId"];
                              final String gorevKategori =
                                  snapshot.data?.docs[index]["gorevKategori"];
                              final int gorevSayi =
                                  snapshot.data?.docs[index]["gorevSayi"];
                              final String kanit =
                                  snapshot.data?.docs[index]["kanit"];
                              final String kullaniciId =
                                  snapshot.data?.docs[index]["kullaniciId"];
                              final String tasksDoneId =
                                  snapshot.data?.docs[index]["tasksDoneId"];
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AdminDetayPage(
                                      gorevAciklama: gorevAciklama,
                                      gorevBaslik: gorevBaslik,
                                      gorevFiyat: gorevFiyat,
                                      gorevId: gorevId,
                                      gorevKategori: gorevKategori,
                                      gorevSayi: gorevSayi,
                                      kanit: kanit,
                                      kullaniciId: kullaniciId,
                                      tasksDoneId: tasksDoneId),
                                ),
                              );
                            },
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.only(
                                    left: 5, right: 5, top: 5),
                                decoration: BoxDecoration(
                                  color: arka_plan_renk,
                                  border: Border.all(
                                      color: arka_plan_renk, width: 2),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  children: [
                                    const Text("Görev"),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                                Icons.chevron_right)),
                                      ),
                                    )
                                  ],
                                )),
                          );
                        },
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
