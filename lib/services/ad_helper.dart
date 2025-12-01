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

  createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: _interstitialAdUnitId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          _isIntertitialLoaded = true;
          interstitialAd = ad;
        }, onAdFailedToLoad: (err) {
          _isIntertitialLoaded = false;
          interstitialAd = null;
        }));
  }

  BannerAd createBannerAd() {
    BannerAd bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: bannerAdUnitId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {},
        onAdFailedToLoad: (ad, e) {
          ad.dispose();
        },
      ),
      request: AdRequest(),
    );
    bannerAd.load();
    return bannerAd;
  }

  createRewardedAd() {
    RewardedAd.load(
        adUnitId: _rewardedAdUnitId,
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
          _isRewardedAdLoaded = true;
          rewardedAd = ad;
        }, onAdFailedToLoad: (err) {
          _isRewardedAdLoaded = false;
          rewardedAd = null;
        }));
  }

  Future<void> showInterstitialAd(Function(InterstitialAd)? function) async {
    if (interstitialAd == null) {
      // createInterstitialAd();
      print('Hata');
      return;
    }
    if (_isIntertitialLoaded) {
      interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: function,
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
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
        Fluttertoast.showToast(
          msg: e.toString(),
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
        );
        // _isShowAds = true;
      }
      interstitialAd = null;

      _isIntertitialLoaded = false;
      // if (_isShowAds)
      createInterstitialAd();
    } else {
      Fluttertoast.showToast(
        msg: "Reklam yüklenemedi.",
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  Future showRewardedAd(
      {required Function(AdWithoutView, RewardItem) onUserEarnedReward}) async {
    if (rewardedAd == null) {
      createRewardedAd();
      print('Hata');
      return;
    }
    if (_isRewardedAdLoaded) {
      rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (RewardedAd ad) {},
        onAdDismissedFullScreenContent: (RewardedAd ad) {
          ad.dispose();
        },
        onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
          ad.dispose();
          createRewardedAd();
        },
      );
      try {
        await rewardedAd!.show(
          onUserEarnedReward: onUserEarnedReward,
        );
      } on Exception catch (e) {
        Fluttertoast.showToast(
          msg: e.toString(),
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
        );
      }
      rewardedAd = null;

      _isRewardedAdLoaded = false;
      // if (_isShowAds)
      createRewardedAd();
    } else {
      Fluttertoast.showToast(
        msg: "Reklam yüklenemedi.",
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  String bannerAdUnitId = Platform.isAndroid
      ? 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
      : "";
  String _interstitialAdUnitId = Platform.isAndroid
      ? 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
      : ""; 
  String _rewardedAdUnitId = Platform.isAndroid
      ? 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
      : "";

  bool _isIntertitialLoaded = false;
  bool _isRewardedAdLoaded = false;
}

AdHelper adHelper = AdHelper();
