import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_applovin_discovery_module/flutter_applovin_discovery_module.dart';
import 'package:flutter_applovin_discovery_module/flutter_applovin_discovery_module_platform_interface.dart';
import 'package:flutter_applovin_discovery_module/flutter_applovin_discovery_module_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterApplovinModulePlatform
    with MockPlatformInterfaceMixin
    implements FlutterApplovinModulePlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterApplovinModulePlatform initialPlatform =
      FlutterApplovinModulePlatform.instance;

  test('$MethodChannelFlutterApplovinModule is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterApplovinModule>());
  });

  test('getPlatformVersion', () async {
    FlutterApplovinModule FlutterApplovinDiscoveryModulePlugin =
        FlutterApplovinModule();
    MockFlutterApplovinModulePlatform fakePlatform =
        MockFlutterApplovinModulePlatform();
    FlutterApplovinModulePlatform.instance = fakePlatform;

    expect(
        await FlutterApplovinDiscoveryModulePlugin.getPlatformVersion(), '42');
  });
}
