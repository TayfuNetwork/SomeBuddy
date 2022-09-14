import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {
  static AdHelper? _instance;
  AdHelper._();
  factory AdHelper() {
    if (_instance != null) {
      return _instance!;
    } else {
      _instance = AdHelper._();
      return _instance!;
    }
  }
  InterstitialAd? interstitialAd;
  RewardedAd? rewardedAd;

  void createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: _interstitialAdUnitId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          _isIntertitialLoaded = true;
          interstitialAd = ad;
          print("İnterstitialdAd Loaded");
        }, onAdFailedToLoad: (err) {
          _isIntertitialLoaded = false;
          interstitialAd = null;
          print("failed to load an insterstitital ad: ${err.message}");
        }));
  }

  BannerAd createBannerAd() {
    BannerAd bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: _bannerAdUnitId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          print("reklam gösterildi");
        },
        onAdFailedToLoad: (ad, e) {
          ad.dispose();
          print("hata oluştu ${e.message}");
        },
      ),
      request: AdRequest(),
    );
    bannerAd.load();
    return bannerAd;
  }

  void createRewardedAd() {
    RewardedAd.load(
        adUnitId: _rewardedAdUnitId,
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
          _isRewardedAdLoaded = true;
          rewardedAd = ad;
          print("revarded ad loaded");
        }, onAdFailedToLoad: (err) {
          _isRewardedAdLoaded = false;
          rewardedAd = null;
          print("${err.message}");
        }));
  }

  Future<void> showInterstitialAd(Function(InterstitialAd)? function) async {
    if (interstitialAd == null) {
      createInterstitialAd();
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    if (_isIntertitialLoaded) {
      print("Show Ads isLoaded");
      interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: function,
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          print('$ad onAdDismissedFullScreenContent.');
          ad.dispose();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          ad.dispose();
          createInterstitialAd();
        },
      );
      try {
        await interstitialAd!.show();
        // _isShowAds = false;
      } on Exception catch (e) {
        print("Hata: " + e.toString());
        // _isShowAds = true;
      }
      interstitialAd = null;

      _isIntertitialLoaded = false;
      // if (_isShowAds)
      createInterstitialAd();
    } else {
      print("Dont show Ad isNotLoaded");
    }
  }

  Future<void> showRewardedAd(Function(RewardedAd)? function) async {
    if (rewardedAd == null) {
      createRewardedAd();
      print('Warning: attempt to show rewarded before loaded.');
      return;
    }
    if (_isRewardedAdLoaded) {
      print("Show Ads isLoaded");
      rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (RewardedAd ad) {
          print('ad onAdShowedFullScreenContent.');
        },
        onAdDismissedFullScreenContent: (RewardedAd ad) {
          print('$ad onAdDismissedFullScreenContent.');
          ad.dispose();
        },
        onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
          ad.dispose();
          createRewardedAd();
        },
      );
      try {
        await rewardedAd!.show(
          onUserEarnedReward: (ad, reward) {
            Fluttertoast.showToast(
              msg: "Cinsiyeti Seçebilirsin",
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_LONG,
            );
          },
        );
      } on Exception catch (e) {
        print("Hata: " + e.toString());
      }
      rewardedAd = null;

      _isRewardedAdLoaded = false;
      // if (_isShowAds)
      createRewardedAd();
    } else {
      print("Dont show Ad isNotLoaded");
    }
  }

  String _bannerAdUnitId = Platform.isAndroid
      ? "ca-app-pub-3940256099942544/6300978111"
      : ""; //ca-app-pub-1753932827820630/3349726379
  String _interstitialAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'
      : ""; //ca-app-pub-1753932827820630/5486565435
  String _rewardedAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5224354917'
      : ""; //ca-app-pub-1753932827820630/1439509214

  bool _isIntertitialLoaded = false;
  bool _isRewardedAdLoaded = false;
}

AdHelper adHelper = AdHelper();
