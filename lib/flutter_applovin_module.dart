import 'package:flutter/material.dart';
import 'package:flutter_core_ads_manager/callback_ads.dart';
import 'package:flutter_core_ads_manager/iadsmanager/i_initialize.dart';
import 'package:flutter_core_ads_manager/iadsmanager/i_rewards.dart';
import 'package:flutter_core_ads_manager/size_ads.dart';

import 'flutter_applovin_module_platform_interface.dart';

class FlutterApplovinDiscoveryModule {
  Future<String?> getPlatformVersion() {
    return FlutterApplovinModulePlatform.instance.getPlatformVersion();
  }

  void initialize(
      BuildContext context, String? appId, IInitialize? iInitialize) {
    return FlutterApplovinModulePlatform.instance
        .initialize(context, appId, iInitialize);
  }

  void loadGdpr(BuildContext context, bool childDirected) {}

  void loadInterstitial(BuildContext context, String adUnitId) {
    FlutterApplovinModulePlatform.instance.loadInterstitial(context, adUnitId);
  }

  void loadRewards(BuildContext context, String adUnitId) {
    FlutterApplovinModulePlatform.instance.loadRewards(context, adUnitId);
  }

  Future<void> setTestDevices(BuildContext context, List<String> testDevices) {
    return FlutterApplovinModulePlatform.instance
        .setTestDevices(context, testDevices);
  }

  Widget showBanner(BuildContext context, SizeBanner sizeBanner,
      String adUnitId, CallbackAds? callbackAds) {
    return FlutterApplovinModulePlatform.instance
        .showBanner(context, sizeBanner, adUnitId, callbackAds);
  }

  void showInterstitial(
      BuildContext context, String adUnitId, CallbackAds? callbackAds) {
    FlutterApplovinModulePlatform.instance
        .showInterstitial(context, adUnitId, callbackAds);
  }

  Widget showNativeAds(BuildContext context, SizeNative sizeNative,
      String adUnitId, CallbackAds? callbackAds) {
    return FlutterApplovinModulePlatform.instance
        .showNativeAds(context, sizeNative, adUnitId, callbackAds);
  }

  void showRewards(BuildContext context, String adUnitId,
      CallbackAds? callbackAds, IRewards? iRewards) {
    FlutterApplovinModulePlatform.instance
        .showRewards(context, adUnitId, callbackAds, iRewards);
  }
}
