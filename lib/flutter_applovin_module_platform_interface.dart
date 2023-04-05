import 'package:flutter_core_ads_manager/iadsmanager/i_ads.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_applovin_module_method_channel.dart';

abstract class FlutterApplovinDiscoverModulePlatform extends PlatformInterface
    implements IAds {
  /// Constructs a FlutterApplovinDiscoverModulePlatform.
  FlutterApplovinDiscoverModulePlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterApplovinDiscoverModulePlatform _instance =
      MethodChannelFlutterApplovinModule();

  /// The default instance of [FlutterApplovinDiscoverModulePlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterApplovinModule].
  static FlutterApplovinDiscoverModulePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterApplovinDiscoverModulePlatform] when
  /// they register themselves.
  static set instance(FlutterApplovinDiscoverModulePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
