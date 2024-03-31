import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gorev_yap_kazan_flutter/Sabitler/ext.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';

class GorevDetayPage extends StatefulWidget {
  const GorevDetayPage({
    super.key,
    required this.gorevId,
    required this.gorevBaslik,
    required this.gorevAciklama,
    required this.gorevFiyat,
    required this.gorevKategori,
    required this.gorevSayi,
    required this.kullaniciId,
  });
  final gorevId;
  final String gorevBaslik;
  final String gorevAciklama;
  final int gorevFiyat;
  final String gorevKategori;
  final int gorevSayi;
  final kullaniciId;

  @override
  State<GorevDetayPage> createState() => _GorevDetayPageState();
}

class _GorevDetayPageState extends State<GorevDetayPage> {
  File? file;
  String? imagename;
  String gorevTalimat = "";
  @override
  void initState() {
    gorevTalimat = widget.gorevAciklama.replaceAll("\\n", "\n");
    super.initState();
  }

  getImage() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    final picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      file = File(image.path);
    } else {}
    setState(() {});
    Navigator.of(context).pop();
  }

  uploadFile(File file, String uuidString) async {
    // Circular Progress Indıcator
    // Firebase Storage referansı oluşturun
    final storageRef = FirebaseStorage.instance.ref().child(uuidString);
    await storageRef.putFile(file);

    final downloadURL = await storageRef.getDownloadURL();
    print("DOWNLOAD URL: $downloadURL");
    return downloadURL;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: arka_plan_renk,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Görev Sekmesi"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: bilgi_karti_renk,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: const [
                      BoxShadow(color: Color(0xFFF64250), blurRadius: 6),
                    ]),
                child: Column(
                  children: [
                    const Text("Görev Hakkında",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    bilgiSatir(
                        baslik: "Başlık:",
                        aciklama: widget.gorevBaslik,
                        color: kirmizi_renk),
                    bilgiSatir(
                        baslik: "Kategori:",
                        aciklama: widget.gorevKategori,
                        color: kirmizi_renk),
                    bilgiSatir(
                        baslik: "Fiyat:",
                        aciklama: "${widget.gorevFiyat} coin",
                        color: kirmizi_renk),
                    bilgiSatir(
                        baslik: "Stok:",
                        aciklama: "${widget.gorevSayi} kişi",
                        color: kirmizi_renk),
                  ],
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: const [
                        BoxShadow(color: Colors.white70, blurRadius: 6),
                      ]),
                  child: Column(
                    children: [
                      const Text("Görev Talimatı",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      Text(gorevTalimat,
                          style: const TextStyle(color: Colors.black)),
                    ],
                  )),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: const Color(0xFF36C2CF),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: const [
                      BoxShadow(color: Color(0xFF36C2CF), blurRadius: 6),
                    ]),
                child: Column(children: [
                  const Text("Kanıt Ekle",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  InkWell(
                    onTap: () async {
                      if (file == null) {
                        await getImage();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    "Zaten ekran görüntüsü eklemişsiniz.")));
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(color: Color(0xFF09B4C3), blurRadius: 6),
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.upload_file, color: Colors.black),
                          const SizedBox(width: 3),
                          Text(
                            file == null
                                ? "Ekran görüntüsü eklemek için tıkla"
                                : "Ekran görüntüsü başarıyla eklendi",
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: InkWell(
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const Center(child: CircularProgressIndicator());
                      },
                    );
                    if (file != null) {
                      final uuid = Uuid();
                      final uuidString = uuid.v4();
                      await uploadFile(file!, uuidString);
                      FirebaseFirestore.instance
                          .collection('TasksDone')
                          .doc()
                          .set({
                        "gorevId": widget.gorevId,
                        "gorevAciklama": widget.gorevAciklama,
                        "gorevBaslik": widget.gorevBaslik,
                        "gorevFiyat": widget.gorevFiyat,
                        "gorevKategori": widget.gorevKategori,
                        "gorevSayi": widget.gorevSayi,
                        "kullaniciId": widget.kullaniciId,
                        "kanit": uuidString
                        // 29.03.2024 firestore bitmiyor. İnternetten kaynaklı olabilir. Çünkü file null gelse bile null diye kaydedecek
                        // ekran görüntüsünü de gönder
                      });
                      // görevi göremez hale getir ve görevler sayfasına gönder
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: RichText(
                              text: const TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  children: [
                            TextSpan(
                                text:
                                    "Kanıtınız onaylandıktan sonra ödeme yapılacaktır."),
                            TextSpan(
                                text: "\nTahmini 1-12 saat arası.",
                                style: TextStyle(fontWeight: FontWeight.w300)),
                          ]))));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "Görevi tamamlamak için kanıt eklemeniz gerekmektedir.")));
                    }
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(color: Colors.greenAccent, blurRadius: 6),
                        ]),
                    child: const Center(
                        child: Text("Görevi Tamamla",
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 20))),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

Widget bilgiSatir(
    {required String baslik, required String aciklama, required Color color}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 100,
          decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12))),
          padding:
              const EdgeInsets.only(top: 10, left: 10, bottom: 10, right: 2),
          child: Text(baslik,
              style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12))),
            padding:
                const EdgeInsets.only(top: 10, left: 10, bottom: 10, right: 8),
            child: Text(aciklama,
                style: const TextStyle(fontSize: 15, color: Colors.black)),
          ),
        )
      ],
    ),
  );
}
