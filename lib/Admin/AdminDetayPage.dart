import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gorev_yap_kazan_flutter/Admin/AdminPage.dart';
import 'package:gorev_yap_kazan_flutter/Sayfalar/Oturum/Auth/auth.service.dart';
import 'package:provider/provider.dart';

class AdminDetayPage extends StatefulWidget {
  const AdminDetayPage(
      {super.key,
      required this.gorevAciklama,
      required this.gorevBaslik,
      required this.gorevFiyat,
      required this.gorevId,
      required this.gorevKategori,
      required this.gorevSayi,
      required this.kanit,
      required this.kullaniciId,
      required this.tasksDoneId});
  final String gorevAciklama;
  final String gorevBaslik;
  final int gorevFiyat;
  final String gorevId;
  final String gorevKategori;
  final int gorevSayi;
  final String kanit;
  final String kullaniciId;
  final String tasksDoneId;

  @override
  State<AdminDetayPage> createState() => _AdminDetayPageState();
}

class _AdminDetayPageState extends State<AdminDetayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Başlık: ${widget.gorevBaslik}"),
                    Text("Fiyat: ${widget.gorevFiyat} coin"),
                    Text("Kategori: ${widget.gorevKategori}"),
                    const SizedBox(height: 10),
                    Text("Açıklama: \n${widget.gorevAciklama}"),
                    Image.network(widget.kanit,
                        width: MediaQuery.of(context).size.width),
                    Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                SayiUpdate().updateCoin(taskId: widget.gorevId);
                                DeleteFirestoreData().delete(
                                    tasksDoneDoc: widget.tasksDoneId,
                                    storageDataUrl: widget.kanit);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AdminPage()));
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Reddedildi.")));
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red)),
                              child: const Text("Reddet",
                                  style: TextStyle(color: Colors.white))),
                          ElevatedButton(
                              onPressed: () {
                                Provider.of<UpdateUser>(context, listen: false)
                                    .updateCoin(
                                        widget.kullaniciId, widget.gorevFiyat);
                                DeleteFirestoreData().delete(
                                    tasksDoneDoc: widget.tasksDoneId,
                                    storageDataUrl: widget.kanit);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AdminPage()));
                                        ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Onaylandı.")));
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.green)),
                              child: const Text("Onayla",
                                  style: TextStyle(color: Colors.white))),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DeleteFirestoreData {
  Future delete(
      {required String tasksDoneDoc, required String storageDataUrl}) async {
    final userCollection = FirebaseFirestore.instance.collection("TasksDone");

    await userCollection.doc(tasksDoneDoc).delete();

    await FirebaseStorage.instance.refFromURL(storageDataUrl).delete();
  }
}

class SayiUpdate {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int? yeniGorevSayiDegeri;

  Future<void> updateCoin({required String taskId}) async {
    final docRef = _firestore.collection('Tasks').doc(taskId);
    await _firestore.runTransaction((transaction) async {
      final documentSnapshot = await transaction.get(docRef);
      var gorevSayiDegeri = documentSnapshot.data()!['sayı'] as int;

      yeniGorevSayiDegeri = gorevSayiDegeri + 1;
      transaction.update(docRef, {'sayı': yeniGorevSayiDegeri});
    });
  }
}
