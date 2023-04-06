import 'package:flutter_applovin_discovery_module/flutter_applovin_module_method_channel.dart';
import 'package:flutter_core_ads_manager/iadsmanager/i_ads.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class FlutterApplovinDiscoveryModulePlatform extends PlatformInterface
    implements IAds {
  /// Constructs a FlutterApplovinDiscoveryModulePlatform.
  FlutterApplovinDiscoveryModulePlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterApplovinDiscoveryModulePlatform _instance =
      MethodChannelFlutterApplovinModule();

  /// The default instance of [FlutterApplovinDiscoveryModulePlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterApplovinModule].
  static FlutterApplovinDiscoveryModulePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterApplovinDiscoveryModulePlatform] when
  /// they register themselves.
  static set instance(FlutterApplovinDiscoveryModulePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
