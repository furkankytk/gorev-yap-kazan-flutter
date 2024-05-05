import 'package:flutter/material.dart';
import 'package:gorev_yap_kazan_flutter/Sabitler/ext.dart';

class SikcaSorulanSorularPage extends StatefulWidget {
  const SikcaSorulanSorularPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SikcaSorulanSorularPageState createState() =>
      _SikcaSorulanSorularPageState();
}

class _SikcaSorulanSorularPageState extends State<SikcaSorulanSorularPage> {
  List<Map<String, String>> sssVerileri = [
    {
      "soru": "Neden Bu Uygulama?",
      "cevap":
          "1- Çeşitlilik:\nGörev yaparak para kazanma haricinde oyun oynayarak, çekilişe katılarak veya internette/web'te gezinerek de para kazanabilirsiniz. \n\n2- Kullanıcı dostu:\nUygulamamız kullanıcıların hiçbir sorun yaşamaması için özel olarak tasarlandı ve uygulamada aktif bir destek hizmetimiz bulunmaktadır.\n\n3- Fazla zaman harcamaz:\nUygulamayı vaktinizi çok harcamayacak şekilde tasarladık. Günün belirli saatlerinde uygulamaya giriş yapıp sandıkları açabilir, birkaç dakika süren görevleri yapabilir, çekilişlere katılabilirsiniz. Ekstradan oyun oynayarak ve tarayıcıda/web'te gezerek para kazanabilirsiniz."
    },
    {
      "soru": "Ödemeler Nasıl Yapılıyor?",
      "cevap":
          "Minimum alt ödeme limiti 5000 coin (5 TL) olarak belirlenmiştir. Bu limiti geçen kullanıcılar Ödeme Talebi sayfasından Papara veya Banka/Kredi Kartı hesaplarından ödeme alabilirler"
    },
    {
      "soru": "Papara İle Ödeme Alabilir Miyim?",
      "cevap":
          "Evet, Papara veya Banka/Kredi Kartı hesaplarınızdan ödeme alabilirsiniz."
    },
    {
      "soru": "1 TL Kaç Coin Ediyor?",
      "cevap":
          "1 TL = 1000 coin olarak belirlenmiştir. Bunun nedeni ise her çeşit ödüllendirmeyi ekleyebilmek. Bu sayede en küçükten en büyüğe kadar her türlü kazanç seçeneği ekleyebiliyoruz."
    },
    {
      "soru": "Görevi Yanlış/Eksik Yaparsam Ne Olur?",
      "cevap":
          "Yanlış yaptığınız görev için ödemeniz yapılmaz. Ancak bu kusurun uzun süre devam etmesi durumunda hesabınız askıya alınabilir."
    },
    {
      "soru": "Sizinle Nasıl İletişime Geçebilirim",
      "cevap":
          "Destek sayfasından bizimle iletişime geçebilirsiniz. Herhangi bir sorununuz varsa yazmaktan çekinmeyin."
    },
    {
      "soru": "Görev Yayınlamak İstiyorum. Ne Yapmalıyım?",
      "cevap":
          "Görev Yayınla sayfasından istediğiniz görevi verebilirsiniz."
    },
    {
      "soru": "Haftalık Çekilişler Nasıl Çalışır?",
      "cevap":
          "Her hafta düzenli olarak çekilişleri yeniliyoruz ve süre sonunda kaç katılımcı varsa ona göre ödeme yapıyoruz. Her 1000 katılımcıda 12 kişiye 10.000 coin dağıtılıyor. Örnek vermek gerekirse eğer 5000 kişi katılırsa 60 kişiye 10.000 coin dağıtılacak. Eğer çekilişi kazanırsanız bildirim alacaksınız. Sürekli mail adresinizi takip etmenize gerek yok. Çekilişe katılmak ortalama 10-30 saniye sürüyor. Yani kısa günün kârı :)"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: arka_plan_renk,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Sıkça Sorulan Sorular"),
      ),
      body: ListView.builder(
        itemCount: sssVerileri.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: ExpansionTile(
              title: Text(
                sssVerileri[index]["soru"]!,
                style: TextStyle(color: Colors.black),
              ),
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    sssVerileri[index]["cevap"]!,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
