import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gorev_yap_kazan_flutter/Sayfalar/Oturum/Auth/auth.service.dart';
import 'package:gorev_yap_kazan_flutter/Sayfalar/anasayfa.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'Sayfalar/Oturum/giris.dart';
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
runApp(MultiProvider(providers: [
  ChangeNotifierProvider(create: (context) => UserProvider()),
  ChangeNotifierProvider(create: (context) => UpdateUser())
],
child: const MyOldApp(),
));
}

class MyOldApp extends StatefulWidget {
  const MyOldApp({super.key});

  @override
  State<MyOldApp> createState() => _MyOldAppState();
}

class _MyOldAppState extends State<MyOldApp> {
  var isLogin = false;

  checkIfLogin() async {
    FirebaseAuth.instance
    .userChanges()
    .listen((User? user) {
      if (user == null) {
      setState(() {
        isLogin = false;
        });
      print('Kullanıcının oturumu şuanda kapalı!');
      } else {
        setState(() {
        isLogin = true;
        });
        print('Kullanıcının oturumu açık!');
        }
   });
  }
  
  @override
  void initState() {
    checkIfLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Görevle Kazan',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
      home: isLogin == true ? const AnaSayfa() : const LoginPage(),
    );
  }
}