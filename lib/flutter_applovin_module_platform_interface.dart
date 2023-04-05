import 'package:flutter_core_ads_manager/iadsmanager/i_ads.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_applovin_module_method_channel.dart';

abstract class FlutterApplovinModulePlatform extends PlatformInterface
    implements IAds {
  /// Constructs a FlutterApplovinModulePlatform.
  FlutterApplovinModulePlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterApplovinModulePlatform _instance =
      MethodChannelFlutterApplovinModule();

  /// The default instance of [FlutterApplovinModulePlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterApplovinModule].
  static FlutterApplovinModulePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterApplovinModulePlatform] when
  /// they register themselves.
  static set instance(FlutterApplovinModulePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
