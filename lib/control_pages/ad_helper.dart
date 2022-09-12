import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1753932827820630/3349726379';
      /* } else if (Platform.isIOS) {
      return '<YOUR_IOS_BANNER_AD_UNIT_ID>'; */
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1753932827820630/5486565435';
      /* } else if (Platform.isIOS) {
      return '<YOUR_IOS_INTERSTITIAL_AD_UNIT_ID>'; */
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1753932827820630/1439509214';
      /* } else if (Platform.isIOS) {
      return '<YOUR_IOS_REWARDED_AD_UNIT_ID>'; */
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
