import 'package:flutter/material.dart';
import 'package:flutter_applovin_discovery_module/flutter_applovin_module_platform_interface.dart';
import 'package:flutter_core_ads_manager/callback_ads.dart';
import 'package:flutter_core_ads_manager/iadsmanager/i_initialize.dart';
import 'package:flutter_core_ads_manager/iadsmanager/i_rewards.dart';
import 'package:flutter_core_ads_manager/size_ads.dart';

class FlutterApplovinDiscoveryModule {
  Future<String?> getPlatformVersion() {
    return FlutterApplovinDiscoveryModulePlatform.instance.getPlatformVersion();
  }

  void initialize(
      BuildContext context, String? appId, IInitialize? iInitialize) {
    return FlutterApplovinDiscoveryModulePlatform.instance
        .initialize(context, appId, iInitialize);
  }

  void loadGdpr(BuildContext context, bool childDirected) {}

  void loadInterstitial(BuildContext context, String adUnitId) {
    FlutterApplovinDiscoveryModulePlatform.instance
        .loadInterstitial(context, adUnitId);
  }

  void loadRewards(BuildContext context, String adUnitId) {
    FlutterApplovinDiscoveryModulePlatform.instance
        .loadRewards(context, adUnitId);
  }

  Future<void> setTestDevices(BuildContext context, List<String> testDevices) {
    return FlutterApplovinDiscoveryModulePlatform.instance
        .setTestDevices(context, testDevices);
  }

  Widget showBanner(BuildContext context, SizeBanner sizeBanner,
      String adUnitId, CallbackAds? callbackAds) {
    return FlutterApplovinDiscoveryModulePlatform.instance
        .showBanner(context, sizeBanner, adUnitId, callbackAds);
  }

  void showInterstitial(
      BuildContext context, String adUnitId, CallbackAds? callbackAds) {
    FlutterApplovinDiscoveryModulePlatform.instance
        .showInterstitial(context, adUnitId, callbackAds);
  }

  Widget showNativeAds(BuildContext context, SizeNative sizeNative,
      String adUnitId, CallbackAds? callbackAds) {
    return FlutterApplovinDiscoveryModulePlatform.instance
        .showNativeAds(context, sizeNative, adUnitId, callbackAds);
  }

  void showRewards(BuildContext context, String adUnitId,
      CallbackAds? callbackAds, IRewards? iRewards) {
    FlutterApplovinDiscoveryModulePlatform.instance
        .showRewards(context, adUnitId, callbackAds, iRewards);
  }
}
