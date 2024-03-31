// class Oturum {
//   GetStorage box = GetStorage();
//   Future<bool>oturum_ac(BuildContext context, String mail, String sifre) async {
//     http.Response sonuc = await http.post(Uri.parse("http://10.0.2.2/config.php"), body: {
//      "oturumac" : "true",
//       "kul_mail" : mail,
//      "kul_sifre" : sifre
//      });
//      
//      if(sonuc.statusCode==200) {
// 
//         Map<String, dynamic> gelen = jsonDecode(sonuc.body);
//         Kullanici kullanici = Kullanici.fromJson(gelen["kullanici_bilgi"]);
//         print(kullanici.title);
//         print(gelen);
// 
//         if (gelen['durum'] == "ok") {
//           alt_yazi(context, "Oturum Açma İşlemi Başarılı", tur: 1);
//           await box.write("kul", gelen["kullanici_bilgi"]);
// 
//          return true;
//        } else {
//          alt_yazi(context, gelen['mesaj']);
//          return false;
//        }
// 
//       } else {
//        alt_yazi(context, "İşleminizi Şuanda Gerçekleştiremiyoruz. Lütfen Daha Sonra Tekrar Deneyiniz");
//        return false;
//       }
//  }
// }