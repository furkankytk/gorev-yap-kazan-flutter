import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityService {
  StreamSubscription? _subscription;

  void startListening(BuildContext context) {
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.none)) {
        ScaffoldMessenger.of(context).showMaterialBanner(
          MaterialBanner(
            dividerColor: Colors.transparent,
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_off_outlined, color: Colors.white, size: 20),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "Bağlantı yok. Lütfen internete bağlanın.",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  )
                ],
              ),
            ),
            actions: [Container()],
            elevation: 0,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
      }
    });
  }

  void stopListening() {
    _subscription?.cancel();
  }
}
