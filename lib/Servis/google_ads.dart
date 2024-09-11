import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GoogleAds extends ChangeNotifier {
  InterstitialAd? interstitialAd;
  BannerAd? bannerAd;
  bool adIsLoaded = false;
  late BannerAd banner;
  RewardedAd? rewardedAd;

  void showInterstitialAd({bool showAfterLoad = false}) {
    InterstitialAd.load(
        adUnitId: "ca-app-pub-3940256099942544/1033173712",
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            interstitialAd = ad;
            if (interstitialAd != null) {
              interstitialAd!.show();
            }
          },
          onAdFailedToLoad: (LoadAdError error) {},
        ));
  }

  void loadBannerAd({required VoidCallback adLoaded}) {
    bannerAd = BannerAd(
      adUnitId: "ca-app-pub-3940256099942544/6300978111",
      request: const AdRequest(),
      size: AdSize.fullBanner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          bannerAd = ad as BannerAd;
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    )..load();
  }

  void loadRewardedAd() {
    RewardedAd.load(
        adUnitId: "ca-app-pub-3940256099942544/5224354917",
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            print("reklam yüklendi");
            rewardedAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            // debugprint
            print('reklam yüklenemedi sorun şu: $error');
          },
        ));
  }

  void showRewardedAd() {
    // :(
    print("callback gg");
    if (rewardedAd != null) {
      // Denenecek
      print("callback çalışıyor, güzel");
      rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          //buraya da callback lazım gibi
          loadRewardedAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          loadRewardedAd();
        },
      );
      rewardedAd!.show(
        onUserEarnedReward: (ad, reward) {
          // ödül
          print("ödül verildi");
        },
      );
      rewardedAd = null;
    } else {
      print("rewardedAd null");
    }
  }
  
  // void denemeShowRewardedAd() {
  //   if (Provider.of<GoogleAds>(context).rewardedAd != null
  //     
  //     //_rewardedAd != null
  //     ) {
  //     rewardedAd!.show(
  //       onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
  //         print('Kullanıcı ödül kazandı: ${reward.amount}');
  //       },
  //     );
  //   } else {
  //     print('Reklam henüz yüklenmedi');
  //   }
  // }
}
