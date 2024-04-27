import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gorev_yap_kazan_flutter/Sabitler/ext.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: arka_plan_renk,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text('Bildirimler'),
        ),
        body: Column(
          children: [
            FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final documentData = snapshot.data!;
                  final notifications =
                      documentData['Notifications'] as List<dynamic>;
                  if (notifications.isEmpty) {
                    return const Center(child: Text("Bildirim sayfası boş"));
                  } else {
                    return Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: notifications.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.notifications,
                                      weight: 50, color: Colors.black),
                                  const SizedBox(width: 3),
                                  Expanded(
                                    child: Text(
                                      notifications[
                                          index], // Replace with your actual long text variable
                                      maxLines:
                                          10, // Allow up to 2 lines for text wrapping

                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      await NotificationSilme()
                                          .notificationSilme(
                                              mesaj: notifications[index]);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Mesaj başarıyla silindi")));
                                      setState(() {});
                                    },
                                    icon: const Icon(Icons.close,
                                        weight: 50, color: Colors.black),
                                    alignment: Alignment.centerRight,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }
                } else {
                  return const Center(
                      child: Text(
                          "Beklenmedik bir hata. Lütfen yetkililere ulaşın."));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationSilme {
  Future<void> notificationSilme({required String mesaj}) async {
    // Firestore instance'ı al
    final firestore = FirebaseFirestore.instance;

    // "tasks" dökümantasyonuna referans al
    final docRef = firestore
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid);

    // Güncellenecek alanları içeren bir harita oluştur
    final updates = <String, dynamic>{
      'Notifications': FieldValue.arrayRemove([mesaj]),
    };

    // Dökümantasyonu güncelle
    await docRef.update(updates);
  }
}
