import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

// void Main () {
//   FirebaseAuth.instance.currentUser?.uid;
// }

class AuthService {
  Future<bool> signInWithGoogle() async {
    bool result = false;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          int coin = 0;
          // add the data to firebase

          FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
            'username': user.displayName,
            'email': user.email,
            'coin': coin
          });
        }
        result = true;
      }
      return result;
    } catch (e) {
      print(e);
    }
    return result;
  }

  // Bunu kullanmam lazımmış
  // GoogleSignInAccount.authentication.id;

  // sarı uyarı vermesin diye:
  // userCredential;

  // Galiba buldum;
  // gUser.id;
}

///////////////////////////////////////////////////////////////////////// Kullanıcı bilgilerine erişmek için: (ÇALIŞIYOR)

class UserModel {
  final String uid;
  final String username;
  final String email;
  final int coin;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.coin,
  });

  factory UserModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserModel(
      uid: snapshot.id,
      username: snapshot.get('username'),
      email: snapshot.get('email'),
      coin: snapshot.get('coin'),
    );
  }
}

class UserProvider extends ChangeNotifier {
  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  DocumentSnapshot<Map<String, dynamic>>? userSnapshot;
  getUserInfo() async {
    userSnapshot = await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    notifyListeners();
  }

  Future<UserModel> getUserData({required String uid}) async {
    final docSnapshot =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();
    if (docSnapshot.exists) {
      _userModel = UserModel.fromFirestore(docSnapshot); // Set the model
      notifyListeners(); // Notify listeners about model change
      return _userModel!;
    } else {
      throw Exception('Kullanıcı bulunamadı.');
    }
  }
}

///////////////////////////////////////////////////////////// Kullanıcıya UpdateCoinValue değeri kadar coin ekleme

class UpdateUser extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateCoin(String uid, int UpdateCoinValue) async {
    final docRef = _firestore.collection('Users').doc(uid);
    await _firestore.runTransaction((transaction) async {
      final documentSnapshot = await transaction.get(docRef);
      final currentCoinValue = documentSnapshot.data()!['coin'] as int;
      final newCoinValue = currentCoinValue + UpdateCoinValue;
      transaction.update(docRef, {'coin': newCoinValue});
    });
  }
}

//////////////////////////////////////////