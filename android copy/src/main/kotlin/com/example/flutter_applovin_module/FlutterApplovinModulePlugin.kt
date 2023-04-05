package com.example.flutter_applovin_module

import android.app.Activity
import android.content.Context
import androidx.annotation.NonNull
import com.adsmanager.applovin.ApplovinMaxAds
import com.adsmanager.core.CallbackAds
import com.adsmanager.core.iadsmanager.IInitialize
import com.adsmanager.core.rewards.IRewards
import com.adsmanager.core.rewards.RewardsItem

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.*
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterApplovinModulePlugin */
class FlutterApplovinModulePlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private val CALLBACK_CHANNEL = "flutter_applovin_module_callback"
  private lateinit var channel : MethodChannel
  private lateinit var applovinMaxAds: ApplovinMaxAds
  private lateinit var context: Context
  private lateinit var callbackChannel: BasicMessageChannel<String>
  private lateinit var activity: Activity
  private lateinit var binaryMessenger: BinaryMessenger
  private lateinit var flutterPluginBinding: FlutterPlugin.FlutterPluginBinding

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_applovin_module")
    this.flutterPluginBinding = flutterPluginBinding
    binaryMessenger = flutterPluginBinding.binaryMessenger
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "getPlatformVersion" -> {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }
      "initialize" -> {
        val appId = call.argument<String>("appId") ?: ""
        applovinMaxAds.initialize(context, appId, object : IInitialize {
          override fun onInitializationComplete() {
            activity.runOnUiThread {
              callbackChannel.send("onInitializationComplete|")
            }
          }
        })
        flutterPluginBinding.platformViewRegistry.registerViewFactory(
          "bannerFan",
          BannerPlatformViewFactory(
            StandardMessageCodec.INSTANCE,
            activity,
            context,
            applovinMaxAds,
            callbackChannel
          )
        )
        flutterPluginBinding.platformViewRegistry.registerViewFactory(
          "nativeFan",
          NativePlatformViewFactory(
            StandardMessageCodec.INSTANCE,
            activity,
            context,
            applovinMaxAds,
            callbackChannel
          )
        )
      }
      "setTestDevices" -> {
        val testDevices = call.argument<List<String>>("testDevices")
        testDevices?.let { applovinMaxAds.setTestDevices(activity, it) }
      }
      "loadGdpr" -> {
        val childDirected = call.argument<Boolean>("childDirected")
        applovinMaxAds.loadGdpr(activity, childDirected == true)
      }
      "loadInterstitial" -> {
        val adUnitId = call.argument<String>("adUnitId")
        adUnitId?.let { applovinMaxAds.loadInterstitial(activity, it) }
      }
      "loadRewards" -> {
        val adUnitId = call.argument<String>("adUnitId")
        adUnitId?.let { applovinMaxAds.loadRewards(activity, it) }
      }
      "showInterstitial" -> {
        val adUnitId = call.argument<String>("adUnitId")
        adUnitId?.let {
          applovinMaxAds.showInterstitial(activity, it, object : CallbackAds() {
            override fun onAdFailedToLoad(error: String?) {
              super.onAdFailedToLoad(error)
              activity.runOnUiThread {
                callbackChannel.send("InterstitialAdFailedToLoad|$error")
              }
            }

            override fun onAdLoaded() {
              super.onAdLoaded()
              activity.runOnUiThread {
                callbackChannel.send("InterstitialAdLoaded|")
              }
            }
          })
        }
      }
      "showRewards" -> {
        val adUnitId = call.argument<String>("adUnitId")
        adUnitId?.let {
          applovinMaxAds.showRewards(activity, it, object : CallbackAds() {
            override fun onAdFailedToLoad(error: String?) {
              super.onAdFailedToLoad(error)
              activity.runOnUiThread {
                callbackChannel.send("RewardsAdFailedToLoad|$error")
              }
            }

            override fun onAdLoaded() {
              super.onAdLoaded()
              activity.runOnUiThread {
                callbackChannel.send("RewardsAdLoaded|")
              }
            }
          }, object : IRewards {
            override fun onUserEarnedReward(rewardsItem: RewardsItem?) {
              activity.runOnUiThread {
                callbackChannel.send("RewardsUserEarnedReward|${rewardsItem.toString()}")
              }
            }
          })
        }
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    applovinMaxAds = ApplovinMaxAds()
    activity = binding.activity
    channel.setMethodCallHandler(this)
    context = binding.activity
    callbackChannel =
      BasicMessageChannel(binaryMessenger, CALLBACK_CHANNEL, StringCodec.INSTANCE)
  }

  override fun onDetachedFromActivityForConfigChanges() {

  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {

  }

  override fun onDetachedFromActivity() {

  }
}
