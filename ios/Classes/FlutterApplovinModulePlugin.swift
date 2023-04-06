import Flutter
import UIKit

public class FlutterApplovinDiscoveryModulePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_applovin_discovery_module", binaryMessenger: registrar.messenger())
    let instance = FlutterApplovinDiscoveryModulePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
