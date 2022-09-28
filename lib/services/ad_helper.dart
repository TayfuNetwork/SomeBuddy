import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
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
          
        }, onAdFailedToLoad: (err) {
          _isIntertitialLoaded = false;
          interstitialAd = null;
         
        }));
  }

  BannerAd createBannerAd() {
    BannerAd bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: _bannerAdUnitId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
    
        },
        onAdFailedToLoad: (ad, e) {
          ad.dispose();
         
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
         
        }, onAdFailedToLoad: (err) {
          _isRewardedAdLoaded = false;
          rewardedAd = null;
         
        }));
  }

  Future<void> showInterstitialAd(Function(InterstitialAd)? function) async {
    if (interstitialAd == null) {
      createInterstitialAd();
      
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

    }
  }

  Future<void> showRewardedAd(Function(RewardedAd)? function) async {
    if (rewardedAd == null) {
      createRewardedAd();
   
      return;
    }
    if (_isRewardedAdLoaded) {
   
      rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (RewardedAd ad) {
       
        },
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
          onUserEarnedReward: (ad, reward) {
            Fluttertoast.showToast(
              msg: "DevamEdebilirsin".tr(),
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_LONG,
            );
          },
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
